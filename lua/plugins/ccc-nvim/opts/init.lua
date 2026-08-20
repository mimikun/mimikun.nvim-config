---@type ccc.Options
local opts = {
  -- The default color used when a color cannot be picked.
  -- It must be HEX format.
  -- See also |ccc-option-preserve|.
  ---@type string
  default_color = "#000000",

  -- The character used for the sliders.
  ---@type string
  bar_char = "█",

  -- The character used for the cursor point on the sliders.
  ---@type string
  point_char = "◊",

  -- The color of the cursor point on the sliders.
  -- It must be HEX format.
  -- If it is empty string (""), like the other part of the sliders, it is dynamically highlighted.
  ---@type string
  point_color = "",

  -- Determine whether to display background of the points on the sliders.
  -- If it is false, the background color will be the color where the point steps on, which will make the bar look continuous.
  ---@type boolean
  empty_point_bg = true,

  -- The color of the cursor point on the sliders when the background color is dark.
  -- It must be HEX format.
  -- If point_color is not empty, this value will be overridden.
  ---@type string
  point_color_on_dark = "#ffffff",

  -- The color of the cursor point on the sliders when the background color is light.
  -- It must be HEX format.
  -- If point_color is not empty, this value will be overridden.
  ---@type string
  point_color_on_light = "#000000",

  -- The length of the slider (not byte length).
  -- This value number of bar_chars form a slider.
  ---@type integer
  bar_len = 30,

  -- The options passed to the |nvim_open_win|.
  -- 'width' and 'height' cannot be specified.
  ---@type vim.api.keyset.win_config
  win_opts = require("plugins.ccc-nvim.opts.win_opts"),

  -- If true, then leaving the ccc UI will automatically close the window.
  ---@type boolean
  auto_close = true,

  -- Whether to preserve the colors when the UI is closed.
  -- If this is true, you can start where you left off last time.
  ---@type boolean
  preserve = false,

  -- Whether to add colors to prev_colors when quit (|ccc-action-quit|).
  ---@type boolean
  save_on_quit = false,

  ---@type integer
  max_prev_colors = 10,

  -- This option determines whether the alpha slider is displayed when the UI is opened.
  -- "show" and "hide" mean as they are.
  -- "auto" makes the slider appear only when the alpha value can be picked up.
  ---@type ccc.Option.show_mode | string | "auto" | "show" | "hide"
  alpha_show = "auto",

  -- List of color system to be activated.
  -- |ccc-action-toggle_input_mode| toggles in this order.
  -- The first one is the default used at the first startup.
  -- Once activated, it will keep the previous input mode.
  -- The presets currently available are as follows:
  ---@type ccc.ColorInput[]
  inputs = require("plugins.ccc-nvim.opts.inputs"),

  -- List of output format to be activated.
  -- |ccc-action-toggle_ouotput_mode| toggles in this order.
  -- The first one is the default used at the first startup.
  -- Once activated, it will keep the previous output mode.
  -- The presets currently available are as follows:
  ---@type ccc.ColorOutput[]
  outputs = require("plugins.ccc-nvim.opts.outputs"),

  -- List of formats that can be detected by |:CccPick| to be activated.
  -- The presets currently available are as follows:
  ---@type ccc.ColorPicker[]
  pickers = require("plugins.ccc-nvim.opts.pickers"),

  -- Whether to enable nvim-lsp support.
  -- The color information is updated in the background and the result is used by |:CccPick| and highlighter.
  ---@type boolean
  lsp = true,

  -- This function is used to create a row below the slider that displays the colors before and after the change.
  -- See source code for details.
  ---@type fun(before_color: ccc.Color, after_color: ccc.Color, width: integer): string, integer, integer, integer, integer
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

  -- Option to highlight text foreground or background.
  -- It is used to output_line and highlighter.
  -- If "virtual", use colored virtual texts.
  ---@type ccc.Option.hl_mode | string | "fg" | "bg" | "foreground" | "background" | "virtual"
  highlight_mode = "bg",

  -- When |ccc-options-highlight_mode| is "virtual", this option controls the text of the virt_text.
  ---@type string
  virtual_symbol = " ● ",

  -- When |ccc-options-highlight_mode| is "virtual", this option controls where to put it out.
  -- You can choose whether to put the color inline on the left or right side of the color, or at the end of the line.
  ---@type ccc.Option.virtual_pos | string | "inline-left" | "inline-right" | "eol"
  virtual_pos = "inline-left",

  -- These are settings for CccHighlighter.
  ---@type ccc.Option.highlighter
  highlighter = require("plugins.ccc-nvim.opts.highlighter"),

  -- Specify the correspondence between picker and output.
  -- The default setting converts the color to css_rgb if it is in hex format, to css_hsl if it is in css_rgb format, and to hex if it is in css_hsl format.
  ---@type { [1]: ccc.ColorPicker, [2]: ccc.ColorOutput }[]
  convert = require("plugins.ccc-nvim.opts.convert"),

  -- These are settings for recognize color format.
  ---@type ccc.Option.recognize
  recognize = require("plugins.ccc-nvim.opts.recognize"),

  -- The mappings are set in the UI of ccc.
  -- The table where lhs is key and rhs is value.
  -- To disable all default mappings, use |ccc-option-disable-default-mappings|.
  -- To disable only some of the default mappings, set ccc.mapping.none.
  ---@type table<string, function>
  mappings = require("plugins.ccc-nvim.opts.mappings"),

  -- If true, all default mappings are disabled.
  ---@type boolean
  disable_default_mappings = false,
}

return opts
