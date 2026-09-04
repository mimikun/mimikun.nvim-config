-- Floating window that renders a tsstatus.data report.
--
-- The question this screen exists to answer is "did every parser actually get
-- installed?", so the counts line is the payload and the lists below it are the
-- detail. Sections that need no action start collapsed: an expanded list of 320
-- healthy parsers would bury the two that failed.

local actions = require("tsstatus.actions")
local data = require("tsstatus.data")
local track = require("tsstatus.track")

local M = {}

local NS = vim.api.nvim_create_namespace("tsstatus")

---@class TSStatusSection
---@field state TSStatusState
---@field label string
---@field icon string
---@field hl string
---@field collapsed boolean starting state

---@type TSStatusSection[]
local SECTIONS = {
  { state = "installing", label = "in progress", icon = "•", hl = "DiagnosticInfo", collapsed = false },
  { state = "failed", label = "failed", icon = "!", hl = "DiagnosticError", collapsed = false },
  { state = "missing", label = "missing", icon = "✗", hl = "DiagnosticError", collapsed = false },
  { state = "outdated", label = "outdated", icon = "⟳", hl = "DiagnosticWarn", collapsed = false },
  { state = "orphan", label = "not in registry", icon = "?", hl = "DiagnosticInfo", collapsed = true },
  { state = "queries_only", label = "queries only", icon = "○", hl = "NonText", collapsed = true },
  { state = "installed", label = "up to date", icon = "✓", hl = "DiagnosticOk", collapsed = true },
}

local SPINNER = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local TICK_MS = 120

local HELP = "q close   r refresh   <Tab> fold   i install   u update all   x uninstall   / filter"

---@type table<string, boolean>?
local collapsed = nil

---Substring the list is narrowed to. Empty means "show everything".
local filter = ""

local frame = 1

---@param rev string?
---@return string
local function short(rev)
  if not rev or rev == "" then
    return "-"
  end
  -- Pinned commits are full SHAs; tags (v2.0.0) and branches stay readable as is.
  if #rev == 40 and rev:match("^%x+$") then
    return rev:sub(1, 7)
  end
  return rev
end

---Installer errors carry absolute paths and can run to several hundred
---characters; the row only has to say which parser broke and roughly why.
---:TSLog still has the whole thing.
---@param text string
---@return string
local function truncate(text)
  local limit = 60
  if vim.fn.strchars(text) <= limit then
    return text
  end
  return vim.fn.strcharpart(text, 0, limit - 1) .. "…"
end

---@param entry TSStatusEntry
---@return string
local function detail(entry)
  if entry.state == "installing" then
    return entry.phase or "queued"
  elseif entry.state == "failed" then
    return truncate(entry.message or "install failed")
  elseif entry.state == "outdated" then
    if entry.queries_missing then
      return "queries missing"
    end
    return ("%s -> %s"):format(short(entry.have), short(entry.wanted))
  elseif entry.state == "missing" then
    return short(entry.wanted)
  elseif entry.state == "queries_only" then
    return entry.queries and "queries installed" or "queries MISSING"
  elseif entry.state == "orphan" then
    return "installed by something else"
  end
  return short(entry.have)
end

---@param section TSStatusSection
---@return string
local function icon_of(section)
  if section.state == "installing" then
    return SPINNER[frame]
  end
  return section.icon
end

---@class TSStatusRowMap
---@field section table<integer, TSStatusState>
---@field entry table<integer, TSStatusEntry>
---@field langs table<TSStatusState, string[]>

---@param report TSStatusReport
---@return string[] lines, table[] highlights, TSStatusRowMap map
local function render(report)
  local buckets = {}
  local langs = {}
  for _, entry in ipairs(report.entries) do
    langs[entry.state] = langs[entry.state] or {}
    table.insert(langs[entry.state], entry.lang)
    if filter == "" or entry.lang:find(filter, 1, true) then
      buckets[entry.state] = buckets[entry.state] or {}
      table.insert(buckets[entry.state], entry)
    end
  end

  local lines = {}
  local hls = {}
  local map = { section = {}, entry = {}, langs = langs }

  ---@param text string
  ---@param hl string?
  ---@param col_start integer?
  ---@param col_end integer?
  local function add(text, hl, col_start, col_end)
    lines[#lines + 1] = text
    if hl then
      hls[#hls + 1] = { #lines - 1, col_start or 0, col_end or -1, hl }
    end
    return #lines - 1
  end

  add(" " .. report.install_dir, "Comment")
  add("")

  local summary = {}
  for _, section in ipairs(SECTIONS) do
    local count = report.counts[section.state] or 0
    -- States at zero are noise, except "up to date" which is the number the
    -- screen exists to show even when it is the only one left.
    if count > 0 or section.state == "installed" then
      summary[#summary + 1] = ("%s %d %s"):format(icon_of(section), count, section.label)
    end
  end
  add(" " .. table.concat(summary, "   "), "Title")
  add("")

  for _, section in ipairs(SECTIONS) do
    local entries = buckets[section.state] or {}
    if #entries > 0 then
      local folded = collapsed[section.state]
      local row =
        add((" %s %s (%d)%s"):format(icon_of(section), section.label, #entries, folded and "  ..." or ""), section.hl)
      map.section[row] = section.state
      if not folded then
        for _, entry in ipairs(entries) do
          -- Icons are multi-byte and not all the same width, so the highlight
          -- columns are measured off the built string rather than assumed.
          local prefix = ("   %s "):format(icon_of(section))
          local name = ("%-28s "):format(entry.lang)
          row = add(prefix .. name .. detail(entry))
          hls[#hls + 1] = { row, 0, #prefix, section.hl }
          hls[#hls + 1] = { row, #prefix + #name, -1, "Comment" }
          map.section[row] = section.state
          map.entry[row] = entry
        end
      end
      -- The blank separator belongs to the section above it, so <Tab> still
      -- lands on something when the cursor is one line past a folded header.
      map.section[add("")] = section.state
    end
  end

  if filter ~= "" then
    add((" filter: %s   (/ to change, / then <CR> to clear)"):format(filter), "WarningMsg")
  end
  add(" " .. HELP, "Comment")

  return lines, hls, map
end

---@param buf integer
---@param report TSStatusReport
---@return TSStatusRowMap
local function draw(buf, report)
  local lines, hls, map = render(report)

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(buf, NS, 0, -1)
  for _, hl in ipairs(hls) do
    local row, col_start, col_end, group = hl[1], hl[2], hl[3], hl[4]
    local width = #lines[row + 1]
    if col_start <= width then
      vim.api.nvim_buf_set_extmark(buf, NS, row, math.min(col_start, width), {
        end_col = col_end == -1 and width or math.min(col_end, width),
        hl_group = group,
      })
    end
  end

  return map
end

---@param buf integer
---@return integer width, integer height
local function dimensions(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  -- Folding a section changes the content height by hundreds of lines, so the
  -- window is sized from what was actually rendered rather than once at open.
  return math.min(math.max(width + 1, 60), vim.o.columns - 4), math.min(#lines, vim.o.lines - 6)
end

---@param win integer
---@param buf integer
local function fit(win, buf)
  local width, height = dimensions(buf)
  vim.api.nvim_win_set_config(win, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
  })
end

---@return TSStatusReport
local function collect()
  -- A failure is deliberately sticky: it clears when the installer is asked to
  -- try that language again, not when the parser file happens to look fine.
  -- An install can leave the parser in place and still have failed.
  return data.collect(track.state())
end

function M.open()
  -- Fold state is per-session, not per-window: reopening the screen after an
  -- install should look the way the user left it.
  if not collapsed then
    collapsed = {}
    for _, section in ipairs(SECTIONS) do
      collapsed[section.state] = section.collapsed
    end
  end

  track.setup()

  local ok, report = pcall(collect)
  if not ok then
    vim.notify("TSStatus: " .. tostring(report), vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "tsstatus"

  local rows = draw(buf, report)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 60,
    height = 10,
    row = 0,
    col = 0,
    style = "minimal",
    border = "rounded",
    title = " tree-sitter parsers ",
    title_pos = "center",
  })
  vim.wo[win].cursorline = true
  vim.wo[win].wrap = false
  fit(win, buf)

  local function alive()
    return vim.api.nvim_win_is_valid(win) and vim.api.nvim_buf_is_valid(buf)
  end

  local function redraw(fresh)
    if not alive() then
      return
    end
    report = fresh
    local cursor = vim.api.nvim_win_get_cursor(win)
    rows = draw(buf, report)
    fit(win, buf)
    local last = vim.api.nvim_buf_line_count(buf)
    vim.api.nvim_win_set_cursor(win, { math.min(cursor[1], last), cursor[2] })
  end

  -- While an install is running the screen animates; when nothing is moving the
  -- timer stops, so an idle window costs nothing.
  local timer = vim.uv.new_timer()
  local ticking = false

  local function stop()
    ticking = false
    if timer and not timer:is_closing() then
      timer:stop()
    end
  end

  local function tick()
    if not alive() then
      stop()
      return
    end
    frame = frame % #SPINNER + 1
    redraw(collect())
    if not track.busy() then
      stop()
    end
  end

  local function start()
    if ticking or not alive() then
      return
    end
    ticking = true
    timer:start(TICK_MS, TICK_MS, vim.schedule_wrap(tick))
  end

  if track.busy() then
    start()
  end

  -- An install can begin after the window is already open (:TSInstall from
  -- another window), so the tracker wakes the timer rather than the timer
  -- polling for work.
  local subscription = track.subscribe(vim.schedule_wrap(function()
    if not alive() then
      return
    end
    if track.busy() then
      start()
    else
      -- A short install can begin and end between two ticks, so the last event
      -- has to redraw by itself or the screen keeps showing the old state.
      redraw(collect())
    end
  end))

  vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
    buffer = buf,
    once = true,
    callback = function()
      stop()
      if timer and not timer:is_closing() then
        timer:close()
      end
      track.unsubscribe(subscription)
    end,
  })

  local function map(lhs, fn)
    vim.keymap.set("n", lhs, fn, { buffer = buf, nowait = true, silent = true })
  end

  ---@return TSStatusState? state, TSStatusEntry? entry
  local function under_cursor()
    local row = vim.api.nvim_win_get_cursor(win)[1] - 1
    return rows.section[row], rows.entry[row]
  end

  ---Languages the cursor points at: one row, or every visible row of the
  ---section whose header (or trailing blank line) the cursor sits on.
  ---@return string[] langs, TSStatusState? state
  local function targets()
    local state, entry = under_cursor()
    if entry then
      return { entry.lang }, state
    end
    if not state then
      return {}, nil
    end
    local langs = {}
    for _, candidate in ipairs(report.entries) do
      if candidate.state == state and (filter == "" or candidate.lang:find(filter, 1, true)) then
        langs[#langs + 1] = candidate.lang
      end
    end
    return langs, state
  end

  ---Outdated parsers, split by whether nvim-treesitter can update them.
  ---@return string[] updatable, string[] reinstall
  local function outdated()
    local updatable, reinstall = {}, {}
    for _, entry in ipairs(report.entries) do
      if entry.state == "outdated" then
        -- update() reads <lang>.revision through an assert()ing helper
        -- (nvim-treesitter/util.lua:6), so a parser whose revision file is
        -- missing crashes the whole batch. Those go through a forced install
        -- instead, which rewrites the revision file and heals the state.
        if entry.have and entry.have ~= "" and not entry.queries_missing then
          updatable[#updatable + 1] = entry.lang
        else
          reinstall[#reinstall + 1] = entry.lang
        end
      end
    end
    return updatable, reinstall
  end

  ---A whole section at once is a big, slow action, so it asks before starting.
  ---@param verb string
  ---@param langs string[]
  ---@return boolean
  local function confirmed(verb, langs)
    if #langs <= 1 then
      return true
    end
    return vim.fn.confirm(("%s %d parsers?"):format(verb, #langs), "&Yes\n&No", 2) == 1
  end

  map("q", function()
    vim.api.nvim_win_close(win, true)
  end)
  map("<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end)
  map("r", function()
    redraw(collect())
  end)
  map("<Tab>", function()
    local state = under_cursor()
    if state then
      collapsed[state] = not collapsed[state]
      redraw(report)
    end
  end)

  map("i", function()
    local langs, state = targets()
    if #langs == 0 then
      return
    end
    -- Anything already on disk has to be forced, otherwise install() sees the
    -- parser present and returns without doing anything.
    local present = state ~= "missing" and state ~= "failed"
    if not confirmed(present and "Reinstall" or "Install", langs) then
      return
    end
    actions.install(langs, present)
  end)

  map("u", function()
    -- Update is deliberately not cursor-driven: "bring everything current" is
    -- the only version of it anyone wants, and outdated is where it applies.
    local updatable, reinstall = outdated()
    local total = #updatable + #reinstall
    if total == 0 then
      vim.notify("TSStatus: every parser is up to date", vim.log.levels.INFO)
      return
    end
    local subject = {}
    vim.list_extend(subject, updatable)
    vim.list_extend(subject, reinstall)
    if not confirmed("Update", subject) then
      return
    end
    actions.update(updatable)
    actions.install(reinstall, true)
  end)

  map("x", function()
    local langs = targets()
    if #langs > 0 then
      actions.uninstall(langs)
    end
  end)

  map("/", function()
    vim.ui.input({ prompt = "Filter parsers: ", default = filter }, function(input)
      if input == nil then
        return
      end
      filter = vim.trim(input)
      redraw(report)
    end)
  end)
end

return M
