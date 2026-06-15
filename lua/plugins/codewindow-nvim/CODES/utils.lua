local M = {}

local get_line = vim.fn.line
local exe = vim.cmd.execute
local api = vim.api
local resolved_ruler_width = 0

function M.buf_to_minimap(x, y)
  local config = require("codewindow.config").get()
  local minimap_x = math.floor((x - 1) / config.width_multiplier / 2) + 1
  local minimap_y = math.floor((y - 1) / 4) + 1
  return minimap_x, minimap_y
end

function M.ruler_min_width()
  local config = require("codewindow.config").get()
  if config.show_ruler == false then
    return 0
  end

  local width = tonumber(config.ruler_width) or 0
  return math.max(0, math.floor(width))
end

function M.set_resolved_ruler_width(width)
  resolved_ruler_width = math.max(0, math.floor(tonumber(width) or 0))
end

function M.ruler_width()
  local min_width = M.ruler_min_width()
  if min_width == 0 then
    return 0
  end
  return math.max(min_width, resolved_ruler_width)
end

function M.ruler_side()
  local config = require("codewindow.config").get()
  if config.ruler_side == "left" then
    return "left"
  end
  return "right"
end

function M.ruler_gap_width()
  if M.ruler_width() == 0 then
    return 0
  end

  local config = require("codewindow.config").get()
  local width = tonumber(config.ruler_gap) or 0
  return math.max(0, math.floor(width))
end

function M.left_ruler_width()
  if M.ruler_side() ~= "left" then
    return 0
  end
  return M.ruler_width()
end

function M.right_ruler_width()
  if M.ruler_side() ~= "right" then
    return 0
  end
  return M.ruler_width()
end

function M.content_start_byte()
  local left_ruler = M.left_ruler_width()
  if left_ruler == 0 then
    return 6
  end
  return 6 + left_ruler + M.ruler_gap_width()
end

function M.content_end_byte()
  local config = require("codewindow.config").get()
  return M.content_start_byte() + config.minimap_width * 3
end

function M.minimap_col_start_byte(x)
  return M.content_start_byte() + (x - 1) * 3
end

function M.minimap_col_end_byte(x)
  return M.content_start_byte() + x * 3
end

function M.git_start_byte()
  return M.content_end_byte()
end

function M.git_end_byte()
  return M.git_start_byte() + 6
end

function M.ruler_start_byte()
  local width = M.ruler_width()
  if width == 0 then
    return nil
  end

  if M.ruler_side() == "left" then
    return 6
  end

  return M.git_end_byte() + M.ruler_gap_width()
end

function M.ruler_end_byte()
  local start = M.ruler_start_byte()
  if start == nil then
    return nil
  end
  return start + M.ruler_width()
end

function M.window_width()
  local config = require("codewindow.config").get()
  return config.minimap_width + 4 + M.ruler_width() + M.ruler_gap_width()
end

local braille_chars = "⠀⠁⠂⠃⠄⠅⠆⠇⡀⡁⡂⡃⡄⡅⡆⡇⠈⠉⠊⠋⠌⠍⠎⠏⡈⡉⡊⡋⡌⡍⡎⡏"
  .. "⠐⠑⠒⠓⠔⠕⠖⠗⡐⡑⡒⡓⡔⡕⡖⡗⠘⠙⠚⠛⠜⠝⠞⠟⡘⡙⡚⡛⡜⡝⡞⡟"
  .. "⠠⠡⠢⠣⠤⠥⠦⠧⡠⡡⡢⡣⡤⡥⡦⡧⠨⠩⠪⠫⠬⠭⠮⠯⡨⡩⡪⡫⡬⡭⡮⡯"
  .. "⠰⠱⠲⠳⠴⠵⠶⠷⡰⡱⡲⡳⡴⡵⡶⡷⠸⠹⠺⠻⠼⠽⠾⠿⡸⡹⡺⡻⡼⡽⡾⡿"
  .. "⢀⢁⢂⢃⢄⢅⢆⢇⣀⣁⣂⣃⣄⣅⣆⣇⢈⢉⢊⢋⢌⢍⢎⢏⣈⣉⣊⣋⣌⣍⣎⣏"
  .. "⢐⢑⢒⢓⢔⢕⢖⢗⣐⣑⣒⣓⣔⣕⣖⣗⢘⢙⢚⢛⢜⢝⢞⢟⣘⣙⣚⣛⣜⣝⣞⣟"
  .. "⢠⢡⢢⢣⢤⢥⢦⢧⣠⣡⣢⣣⣤⣥⣦⣧⢨⢩⢪⢫⢬⢭⢮⢯⣨⣩⣪⣫⣬⣭⣮⣯"
  .. "⢰⢱⢲⢳⢴⢵⢶⢷⣰⣱⣲⣳⣴⣵⣶⣷⢸⢹⢺⢻⢼⢽⢾⢿⣸⣹⣺⣻⣼⣽⣾⣿"

function M.flag_to_char(flag)
  return braille_chars:sub(flag * 3 + 1, (flag + 1) * 3)
end

function M.get_top_line(window)
  if window then
    return get_line("w0", window)
  end
  return get_line("w0")
end

function M.get_bot_line(window)
  if window then
    return get_line("w$", window)
  end
  return get_line("w$")
end

function M.get_buf_height(buffer)
  return api.nvim_buf_line_count(buffer)
end

function M.scroll_window(window, amount)
  if not api.nvim_win_is_valid(window) then
    return
  end

  api.nvim_win_call(window, function()
    if amount > 0 then
      local botline = M.get_bot_line()
      local buffer = api.nvim_win_get_buf(window)
      local height = M.get_buf_height(buffer)
      if botline >= height then
        return
      end
      local max_move_down = math.min(amount, height - botline)
      exe(string.format('"normal! %d\\<C-e>"', max_move_down))
    else
      amount = -amount
      if window == nil then
        return
      end
      local topline = M.get_top_line()
      if topline <= 1 then
        return
      end
      local max_move_up = math.min(amount, topline - 1)
      exe(string.format('"normal! %d\\<C-y>"', max_move_up))
    end
  end)
end

return M
