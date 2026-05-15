local ccc = require("ccc")
local input = ccc.input
local output = ccc.output
local picker = ccc.picker
local mapping = ccc.mapping
local utils = require("ccc.utils")
local ui = require("ccc.ui.float")

---@type ccc.Options
local opts = {
  default_color = "#000000",
  bar_char = "█",
  point_char = "◊",
  point_color = "",
  empty_point_bg = true,
  point_color_on_dark = "#ffffff",
  point_color_on_light = "#000000",
  bar_len = 30,
  --win_opts = require("plugins.ccc-nvim.opts.win_opts"),
  auto_close = true,
  preserve = false,
  save_on_quit = false,
  max_prev_colors = 10,
  alpha_show = "auto",
  --inputs = require("plugins.ccc-nvim.opts.inputs"),
  --outputs = require("plugins.ccc-nvim.opts.outputs"),
  pickers = require("plugins.ccc-nvim.opts.pickers"),
  ui = ui,
  output_line = function(before_color, after_color, width)
    local b_hex = before_color:hex()
    local a_str = after_color:str()
    local line = b_hex .. " =>" .. (" "):rep(width - #b_hex - 3 - #a_str) .. a_str
    -- Range for highlight
    local b_start_col = 0
    local b_end_col = #b_hex
    local a_start_col = width - #a_str
    local a_end_col = width
    return line, b_start_col, b_end_col, a_start_col, a_end_col
  end,
  highlight_mode = "bg",
  virtual_symbol = " ● ",
  virtual_pos = "inline-left",
  lsp = true,
  highlighter = require("plugins.ccc-nvim.opts.highlighter"),
  --convert = require("plugins.ccc-nvim.opts.convert"),
  --recognize = require("plugins.ccc-nvim.opts.recognize"),
  --mappings = require("plugins.ccc-nvim.opts.mappings"),
  disable_default_mappings = false,
}

return opts
