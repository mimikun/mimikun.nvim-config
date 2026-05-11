---@type LspsagaConfig.Diagnostic
local diagnostic = {
  -- LayoutOption Config layout of diagnostic window not jump window
  ---@type string | "float" | "normal"
  show_layout = "float",

  ---Show window height when diagnostic show window layout is normal
  ---@type integer
  show_normal_height = 10,

  ---Enable number shortcuts to execute code action quickly
  ---@type boolean
  jump_num_shortcut = true,

  ---Auto preview result after change
  ---@type boolean
  auto_preview = false,

  -- Diagnostic jump window max width
  ---@type integer
  max_width = 0.8,

  -- Diagnostic jump window max height
  ---@type integer
  max_height = 0.6,

  -- Show window max width when layout is float
  ---@type integer
  max_show_width = 0.9,

  -- Show window max height when layout is float
  ---@type integer
  max_show_height = 0.6,

  -- Wrap long lines
  ---@type boolean
  wrap_long_lines = true,

  -- When have relatedInformation, diagnostic message is extended to show it
  ---@type boolean
  extend_relatedInformation = false,

  -- Only show diagnostic virtual text on the current line
  ---@type boolean
  diagnostic_only_current = false,

  ---@type LspsagaConfig.Diagnostic.Keys
  keys = {
    -- execute action (in jump window)
    ---@type string | string[]
    exec_action = "o",

    -- quit key for the jump window
    ---@type string | string[]
    quit = "q",

    -- toggle or jump to position when in `diagnostic_show` window
    ---@type string | string[]
    toggle_or_jump = "<CR>",

    -- quit key for the `diagnostic_show` window
    ---@type string | string[]
    quit_in_show = {
      "q",
      "<ESC>",
    },
  },
}

return diagnostic
