-- Floating window that renders a tsstatus.data report.
--
-- The question this screen exists to answer is "did every parser actually get
-- installed?", so the counts line is the payload and the lists below it are the
-- detail. Sections that need no action start collapsed: an expanded list of 320
-- healthy parsers would bury the two that failed.

local data = require("tsstatus.data")

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
  { state = "missing", label = "missing", icon = "✗", hl = "DiagnosticError", collapsed = false },
  { state = "outdated", label = "outdated", icon = "⟳", hl = "DiagnosticWarn", collapsed = false },
  { state = "orphan", label = "not in registry", icon = "?", hl = "DiagnosticInfo", collapsed = true },
  { state = "queries_only", label = "queries only", icon = "○", hl = "NonText", collapsed = true },
  { state = "installed", label = "up to date", icon = "✓", hl = "DiagnosticOk", collapsed = true },
}

local HELP = "q close   r refresh   <Tab> fold section"

---@type table<string, boolean>?
local collapsed = nil

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

---@param entry TSStatusEntry
---@return string
local function detail(entry)
  if entry.state == "outdated" then
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

---@param report TSStatusReport
---@return string[] lines, table[] highlights, table<integer, string> section_of_line
local function render(report)
  local buckets = {}
  for _, entry in ipairs(report.entries) do
    buckets[entry.state] = buckets[entry.state] or {}
    table.insert(buckets[entry.state], entry)
  end

  local lines = {}
  local hls = {}
  local section_of_line = {}

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
    summary[#summary + 1] = ("%s %d %s"):format(section.icon, count, section.label)
  end
  add(" " .. table.concat(summary, "   "), "Title")
  add("")

  for _, section in ipairs(SECTIONS) do
    local entries = buckets[section.state] or {}
    if #entries > 0 then
      local folded = collapsed[section.state]
      local row =
        add((" %s %s (%d)%s"):format(section.icon, section.label, #entries, folded and "  ..." or ""), section.hl)
      section_of_line[row] = section.state
      if not folded then
        for _, entry in ipairs(entries) do
          -- Icons are multi-byte and not all the same width, so the highlight
          -- columns are measured off the built string rather than assumed.
          local prefix = ("   %s "):format(section.icon)
          local name = ("%-28s "):format(entry.lang)
          row = add(prefix .. name .. detail(entry))
          hls[#hls + 1] = { row, 0, #prefix, section.hl }
          hls[#hls + 1] = { row, #prefix + #name, -1, "Comment" }
          section_of_line[row] = section.state
        end
      end
      -- The blank separator belongs to the section above it, so <Tab> still
      -- lands on something when the cursor is one line past a folded header.
      section_of_line[add("")] = section.state
    end
  end

  add(" " .. HELP, "Comment")

  return lines, hls, section_of_line
end

---@param buf integer
---@param report TSStatusReport
---@return table<integer, string>
local function draw(buf, report)
  local lines, hls, section_of_line = render(report)

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

  return section_of_line
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

function M.open()
  -- Fold state is per-session, not per-window: reopening the screen after an
  -- install should look the way the user left it.
  if not collapsed then
    collapsed = {}
    for _, section in ipairs(SECTIONS) do
      collapsed[section.state] = section.collapsed
    end
  end

  local ok, report = pcall(data.collect)
  if not ok then
    vim.notify("TSStatus: " .. tostring(report), vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "tsstatus"

  local sections = draw(buf, report)

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

  local function redraw(fresh)
    local cursor = vim.api.nvim_win_get_cursor(win)
    sections = draw(buf, fresh)
    fit(win, buf)
    local last = vim.api.nvim_buf_line_count(buf)
    vim.api.nvim_win_set_cursor(win, { math.min(cursor[1], last), cursor[2] })
  end

  local function map(lhs, fn)
    vim.keymap.set("n", lhs, fn, { buffer = buf, nowait = true, silent = true })
  end

  map("q", function()
    vim.api.nvim_win_close(win, true)
  end)
  map("<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end)
  map("r", function()
    report = data.collect()
    redraw(report)
  end)
  map("<Tab>", function()
    local row = vim.api.nvim_win_get_cursor(win)[1] - 1
    local state = sections[row]
    if state then
      collapsed[state] = not collapsed[state]
      redraw(report)
    end
  end)
end

return M
