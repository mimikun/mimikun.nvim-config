local M = {}

local api = vim.api
local humanize = require("codewindow.humanize")

local function left_pad(value, width)
  local padding = width - #value
  if padding <= 0 then
    return value
  end
  return string.rep(" ", padding) .. value
end

local function get_parent_height(window)
  if window and api.nvim_win_is_valid(window.parent_win or -1) then
    return api.nvim_win_get_height(window.parent_win)
  end
  return vim.o.lines
end

local function centerable_interval(raw_interval)
  local row_interval = math.max(2, math.ceil(raw_interval / 4))
  if row_interval % 2 == 1 then
    row_interval = row_interval + 1
  end
  return row_interval * 4
end

local function get_interval(window)
  local config = require("codewindow.config").get()
  local explicit_interval = tonumber(config.ruler_interval)
  if explicit_interval and explicit_interval > 0 then
    return math.floor(explicit_interval)
  end

  local height = math.max(1, get_parent_height(window))
  return centerable_interval(math.max(10, math.ceil(height / 10) * 10))
end

local function get_tick_interval(interval)
  local config = require("codewindow.config").get()
  local explicit_interval = tonumber(config.ruler_tick_interval)
  if explicit_interval and explicit_interval > 0 then
    return math.floor(explicit_interval)
  end

  return math.max(4, math.floor(interval / 2))
end

function M.render(lines, window)
  local utils = require("codewindow.utils")
  local min_width = utils.ruler_min_width()
  if min_width == 0 then
    utils.set_resolved_ruler_width(0)
    return {}
  end

  local minimap_height = math.ceil(#lines / 4)
  if minimap_height == 0 then
    utils.set_resolved_ruler_width(min_width)
    return {}
  end

  local interval = get_interval(window)
  local tick_interval = get_tick_interval(interval)
  local label_values = { 1 }
  for line = interval, #lines, interval do
    label_values[#label_values + 1] = line
  end
  local labels, width = humanize.line_number_labels(label_values, min_width)
  utils.set_resolved_ruler_width(width)

  local empty = string.rep(" ", width)
  local ruler = {}
  for y = 1, minimap_height do
    ruler[y] = empty
  end

  local tick = left_pad(".", width)

  for line = tick_interval, #lines, tick_interval do
    if line % interval ~= 0 then
      local row = math.ceil(line / 4)
      ruler[row] = tick
    end
  end

  ruler[1] = labels[1]
  for line = interval, #lines, interval do
    local row = math.ceil(line / 4)
    ruler[row] = labels[(line / interval) + 1]
  end

  return ruler
end

return M
