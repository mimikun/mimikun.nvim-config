local FloatingWindow = require('deck.kit.Vim.FloatingWindow')
local ScheduledTimer = require('deck.kit.Async.ScheduledTimer')
local kit = require('deck.kit')
local spinner = require('deck.x.spinner')

local Config = {
  ns = vim.api.nvim_create_namespace('deck_notify'),
  min_width = math.floor(vim.o.columns * 0.25),
  max_width = math.floor(vim.o.columns * 0.5),
  max_height = math.floor(vim.o.lines * 0.6),
  show_duration = 5000,
}

---@alias deck.notify.Line string|((string|{ [1]: string, [2]?: string })[])

---@alias deck.notify.Decoration { col: integer, end_col: integer, hl_group: string }

---@alias deck.notify.Item { line: deck.notify.Line, plain_text: string, decorations: deck.notify.Decoration[], created_at: integer }

---@alias deck.notify.HistoryItem { type: 'lane', lane: deck.notify.Lane, created_at: integer } | { type: 'item', lane: deck.notify.Lane, line: deck.notify.Line[], created_at: integer }

---@param line deck.notify.Line
---@return string
local function to_plain_text(line)
  if type(line) == 'string' then
    return line
  end
  local parts = {}
  for _, part in ipairs(line) do
    if type(part) == 'string' then
      table.insert(parts, (part:gsub('\n', '')))
    else
      table.insert(parts, (part[1]:gsub('\n', '')))
    end
  end
  return table.concat(parts, '')
end
---Convert a line to extmarks.
---@param line deck.notify.Line
---@return { col: integer, end_col: integer, hl_group: string }[]
local function to_decoration(line)
  if type(line) == 'string' then
    return {}
  end
  local decorations = {}
  local offset = 0
  for _, part in ipairs(line) do
    if type(part) == 'table' then
      if part[2] ~= '' then
        table.insert(decorations, {
          col = offset,
          end_col = offset + #part[1],
          hl_group = part[2] or '',
        })
      end
    end
    offset = offset + #(part[1] or part)
  end
  return decorations
end

---@class deck.notify.Lane
---@field public buf integer
---@field public name string
---@field public default boolean
---@field public created_at integer
---@field public updated_at integer
---@field public finished_at? integer
---@field public items deck.notify.Item[]
local Lane = {}
Lane.__index = Lane

---Create a new task.
---@param name string
---@param default? boolean
function Lane.new(name, default)
  local self = setmetatable({}, Lane)
  self.buf = vim.api.nvim_create_buf(false, true)
  self.name = name
  self.default = default or false
  self.created_at = default and -1 or vim.uv.now()
  self.updated_at = self.created_at
  self.finished_at = nil
  self.items = {}
  return self
end

---Mark the task as done.
function Lane:mark_as_done()
  self.finished_at = vim.uv.now()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == self.buf then
      vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = self.buf })
      return
    end
  end

  local timer = ScheduledTimer.new()
  timer:start(200, 200, function()
    if not self:is_active() then
      local shown = false;
      for _, win in pairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == self.buf then
          shown = true
          break
        end
      end
      if not shown then
        timer:stop()
        vim.api.nvim_buf_delete(self.buf, { force = true })
      end
    end
  end)
end

---Check if the lane is done.
---@return boolean
function Lane:is_done()
  if self.default then
    return false
  end
  return self.finished_at ~= nil and (vim.uv.now() - self.finished_at) >= 0
end

---Check if the lane is done.
---@return boolean
function Lane:is_active()
  local now = vim.uv.now()
  if self.default then
    return now - self.updated_at < Config.show_duration
  end
  if not self.finished_at then
    return true
  end
  return (now - self.finished_at) < Config.show_duration
end

---Add a message to the lane.
---@param line deck.notify.Line
function Lane:add_line(line)
  self.updated_at = vim.uv.now()
  if self.finished_at then
    self.finished_at = self.updated_at
  end

  local item = {
    line = line,
    plain_text = to_plain_text(line),
    decorations = to_decoration(line),
    created_at = self.updated_at,
  } --[[@as deck.notify.Item]]
  table.insert(self.items, item)

  -- append message.
  vim.api.nvim_buf_set_lines(self.buf, -1, -1, false, { item.plain_text })

  -- decorate message.
  local row = vim.api.nvim_buf_line_count(self.buf) - 1
  for _, decor in ipairs(item.decorations) do
    vim.api.nvim_buf_set_extmark(self.buf, Config.ns, row, decor.col, {
      end_col = decor.end_col,
      hl_group = decor.hl_group,
      hl_mode = 'combine',
    })
  end
end

---Get the maximum width of items in the lane.
---@return integer
function Lane:get_max_width()
  local max_width = 0
  for _, item in ipairs(self.items) do
    local width = vim.api.nvim_strwidth(item.plain_text)
    if width > max_width then
      max_width = width
    end
  end
  return max_width
end

---Get the height of the lane.
---@return integer
function Lane:get_height()
  return #vim.iter(self.items):filter(function(item)
    return item.created_at + Config.show_duration > vim.uv.now()
  end):totable()
end

local state = {
  ---@type deck.notify.Lane[]
  lanes = { Lane.new('default', true), },
  ---@type table<string, { id: integer, spinner: deck.x.spinner.Spinner }>
  win_state = {},
  ---@type table<string, integer>
  shown_revisions = {},
  ---@type integer
  unique_id = 0,
  ---@type boolean
  showing = false,
}

local notify = {}

---Show notify lanes.
local function show()
  if state.showing then
    return
  end
  state.showing = true

  local active_lanes = {}
  for _, lane in ipairs(state.lanes) do
    if lane:is_active() then
      table.insert(active_lanes, lane)
    else
      if state.win_state[lane.name] and vim.api.nvim_win_is_valid(state.win_state[lane.name].id) then
        vim.api.nvim_win_close(state.win_state[lane.name].id, true)
        state.win_state[lane.name] = nil
      end
    end
  end

  -- check for finish.
  if #active_lanes == 0 then
    state.showing = false
    return
  end

  -- update only footer.
  for _, lane in ipairs(active_lanes) do
    local win_state = state.win_state[lane.name]
    if win_state and vim.api.nvim_win_is_valid(win_state.id) then
      vim.api.nvim_win_set_config(win_state.id, {
        footer = lane:is_done() and '✓' or win_state.spinner.get()
      })
    end
  end

  -- check for changes.
  local changed = false
  for _, lane in ipairs(active_lanes) do
    if state.shown_revisions[lane.name] ~= lane.updated_at then
      state.shown_revisions[lane.name] = lane.updated_at
      changed = true
    end
  end
  if not changed then
    state.showing = false
    vim.defer_fn(show, 64)
    return
  end

  -- show lanes.
  local offset_height = 0
  for _, lane in ipairs(vim.iter(active_lanes):rev():totable() --[=[@as deck.notify.Lane[]]=]) do
    local width = math.max(1, math.max(math.min(lane:get_max_width(), Config.max_width), Config.min_width))
    local height = math.max(1, math.min(lane:get_height(), Config.max_height))
    local border = vim.o.winborder or 'rounded'
    local border_size = FloatingWindow.get_border_size(border)

    -- show or move window.
    local base_win_config = {
      relative = 'editor',
      width = width,
      height = height,
      row = vim.o.lines - (height + border_size.top + border_size.bottom) - offset_height - 1,
      col = vim.o.columns - width,
      style = 'minimal',
      border = border,
      title = lane.name,
      title_pos = 'right',
      footer = '',
      footer_pos = 'right',
    }
    local win_state = state.win_state[lane.name]
    if not win_state or not vim.api.nvim_win_is_valid(win_state.id) then
      state.win_state[lane.name] = {
        id = vim.api.nvim_open_win(lane.buf, false, base_win_config),
        spinner = spinner.create(),
      }
      vim.api.nvim_set_option_value('winhighlight', 'FloatFooter:Normal', { win = state.win_state[lane.name].id })
    else
      vim.api.nvim_win_set_config(win_state.id, kit.merge({
        footer = lane:is_done() and '✓' or win_state.spinner.get()
      }, base_win_config))
    end
    win_state = state.win_state[lane.name]

    -- set cursor.
    vim.api.nvim_win_call(win_state.id, function()
      vim.api.nvim_win_set_cursor(win_state.id, { vim.api.nvim_buf_line_count(lane.buf), 0 })
      vim.cmd('normal! zb')
    end)

    -- compute offset for next lane.
    offset_height = offset_height + height + border_size.top + border_size.bottom
  end

  -- next tick.
  state.showing = false
  vim.defer_fn(show, 64)
end

---Add a message to a lane.
---@param name string
---@param lines deck.notify.Line[]
function notify.add_message(name, lines)
  -- Create or get lane.
  local lane = vim.iter(state.lanes):find(function(l)
    return l.name == name and not l:is_done()
  end)
  if not lane then
    lane = Lane.new(name)
    table.insert(state.lanes, lane)
  end

  -- Add lines and show.
  for _, line in ipairs(lines) do
    lane:add_line(line)
  end
  show()
end

---Create a unique lane name.
---@param name string
---@return string
function notify.create_lane_name(name)
  if vim.fn.strchars(name, true) > 20 then
    name = vim.fn.strcharpart(name, 0, 20, true) .. '...'
  end
  state.unique_id = state.unique_id + 1
  return ('%s (%s)'):format(name, state.unique_id)
end

---Mark a lane as done.
---@param name string
function notify.mark_as_done(name)
  local lane = vim.iter(state.lanes):find(function(l)
    return l.name == name
  end)
  if lane then
    lane:mark_as_done()
  end
end

---Get notify history.
---@return deck.notify.HistoryItem[]
function notify.get_history()
  local entries = {} --[=[@as deck.notify.HistoryItem[]]=]
  for _, lane in ipairs(state.lanes) do
    if lane.default then
      for _, item in ipairs(lane.items) do
        table.insert(entries, {
          type = 'item',
          lane = lane,
          line = item.line,
          created_at = item.created_at,
        })
      end
    else
      table.insert(entries, {
        type = 'lane',
        lane = lane,
        created_at = lane.created_at,
      })
    end
  end
  table.sort(entries, function(a, b)
    return a.created_at < b.created_at
  end)
  for i = #entries, 1, -1 do
    local entry = entries[i]
    if entry.type == 'lane' then
      for j = #entry.lane.items, 1, -1 do
        local item = entry.lane.items[j]
        table.insert(entries, i + 1, {
          type = 'item',
          lane = entry.lane,
          line = item.line,
          created_at = item.created_at,
        })
      end
    end
  end
  return entries
end

return notify
