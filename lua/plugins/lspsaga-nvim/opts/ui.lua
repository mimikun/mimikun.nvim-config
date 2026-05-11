---@type LspsagaConfig.Ui
local ui = {
  ---@type string
  winbar_prefix = "",

  -- Border type, see `:help nvim_open_win`
  ---@type string[] | "none" | "single" | "double" | "rounded" | "solid" | "shadow"
  border = "rounded",

  -- Whether to use nvim-web-devicons
  ---@type boolean
  devicon = true,

  -- Show folder icon in breadcrumbs
  ---@type boolean
  foldericon = true,

  -- Show title in some float window
  ---@type boolean
  title = true,

  -- Expand (drop down) icon
  ---@type string
  expand = "⊞",

  -- Collapse (drop down) icon
  ---@type string
  collapse = "⊟",

  -- Code Action (lightbulb) icon
  ---@type string
  code_action = "💡",

  -- Symbols used in virtual text connect
  ---@type string[]
  lines = {
    "┗",
    "┣",
    "┃",
    "━",
    "┏",
  },

  -- LSP kind custom table
  ---@type table
  kind = nil,

  -- Button icon
  ---@type [string, string]
  button = {
    "",
    "",
  },

  -- Implement icon
  ---@type string
  imp_sign = "󰳛 ",

  ---@type boolean
  use_nerd = true,
}

return ui
