---@type CodexNvimTerminalConfig
local terminal = {
  ---@type CodexNvimSplitSide | string | "left" | "right"
  split_side = "right",

  ---@type number
  split_width_percentage = 0.35,

  ---@type boolean
  auto_insert = true,

  ---@type boolean
  auto_close = true,

  ---@type false | CodexNvimWindowNavigation
  window_navigation = {
    ---@type string
    left = "<M-h>",

    ---@type string
    down = "<M-j>",

    ---@type string
    up = "<M-k>",

    ---@type string
    right = "<M-l>",
  },
}

return terminal
