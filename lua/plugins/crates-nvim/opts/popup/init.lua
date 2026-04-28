---@type crates.UserPopupConfig
local popup = {
  ---@type boolean
  autofocus = false,

  ---@type boolean
  hide_on_select = false,

  ---@type string
  copy_register = '"',

  ---@type string
  style = "minimal",

  ---@type string | string[]
  border = nil,

  ---@type boolean
  show_version_date = false,

  ---@type boolean
  show_dependency_version = true,

  ---@type integer
  max_height = 30,

  ---@type integer
  min_width = 20,

  ---@type integer
  padding = 1,

  ---@type crates.UserPopupTextConfig
  text = require("plugins.crates-nvim.opts.popup.text"),

  ---@type crates.UserPopupHighlightConfig
  highlight = require("plugins.crates-nvim.opts.popup.highlight"),

  ---@type crates.UserPopupKeyConfig
  keys = require("plugins.crates-nvim.opts.popup.keys"),
}

return popup
