---@type LspsagaConfig.CodeAction
local code_action = {
  -- Enable number shortcuts to execute code action quickly
  ---@type boolean
  num_shortcut = true,

  ---show language server name
  ---@type boolean
  show_server_name = false,

  ---extend gitsigns plugin diff action
  ---@type boolean
  extend_gitsigns = false,

  ---only execute code action in current cursor position
  ---@type boolean
  only_in_cursor = true,

  ---code action window max height
  ---@type number
  max_height = 0.3,

  ---code action window highlight cursor line
  ---@type boolean
  cursorline = true,

  ---@type LspsagaConfig.CodeAction.Keys
  keys = {
    ---quit the float window
    ---@type string | string[]
    quit = "q",

    ---execute action
    ---@type string | string[]
    exec = "<CR>",
  },
}

return code_action
