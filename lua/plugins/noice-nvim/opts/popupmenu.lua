local popupmenu = {
  -- enables the Noice popupmenu UI
  enabled = true,

  -- backend to use to show regular cmdline completions
  ---@type string | "nui" | "cmp"
  backend = "nui",

  -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
  -- set to `false` to disable icons
  ---@type NoicePopupmenuItemKind | false
  kind_icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = "了 ",
    EnumMember = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Keyword = " ",
    Method = "ƒ ",
    Module = " ",
    Property = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}

return popupmenu
