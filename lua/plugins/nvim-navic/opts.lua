---@type table | nil
local default_icons = {
  enabled = true,
  File = "󰈙 ",
  Module = " ",
  Namespace = "󰌗 ",
  Package = " ",
  Class = "󰌗 ",
  Method = "󰆧 ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = "󰕘",
  Interface = "󰕘",
  Function = "󰊕 ",
  Variable = "󰆧 ",
  Constant = "󰏿 ",
  String = "󰀬 ",
  Number = "󰎠 ",
  Boolean = "◩ ",
  Array = "󰅪 ",
  Object = "󰅩 ",
  Key = "󰌋 ",
  Null = "󰟢 ",
  EnumMember = " ",
  Struct = "󰌗 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
}

---@type table | nil
local vscode_like_icons = {
  enabled = true,
  File = " ",
  Module = " ",
  Namespace = " ",
  Package = " ",
  Class = " ",
  Method = " ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = " ",
  Interface = " ",
  Function = " ",
  Variable = " ",
  Constant = " ",
  String = " ",
  Number = " ",
  Boolean = " ",
  Array = " ",
  Object = " ",
  Key = " ",
  Null = " ",
  EnumMember = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

---@type Options
local opts = {
  ---@type table | nil
  icons = default_icons,

  ---@type LspOptions | nil
  lsp = {
    ---@type boolean | nil
    auto_attach = false,
    ---@type table | nil
    preference = nil,
  },

  ---@type boolean | nil
  highlight = false,

  ---@type string | nil
  separator = " > ",

  ---@type number | nil
  depth_limit = 0,

  ---@type string | nil
  depth_limit_indicator = "..",

  ---@type boolean | nil
  safe_output = true,

  ---@type boolean | nil
  lazy_update_context = false,

  ---@type boolean | nil
  click = false,

  ---@type function | nil
  format_text = function(text)
    return text
  end,
}

return opts
