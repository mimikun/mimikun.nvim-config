-- Key mapping configuration
---@type IWE.Config.Mappings
local mappings = {
  -- Core markdown editing keybindings
  -- Whether to enable core markdown editing key mappings
  ---@type boolean
  enable_markdown_mappings = true,

  -- Set to true to enable gf, gs, ga, g/, gb, gR, go
  -- Whether to enable picker keybindings (gf, gs, ga, etc.)
  ---@type boolean
  enable_picker_keybindings = false,

  -- Set to true to enable IWE-specific LSP keybindings
  -- Whether to enable IWE-specific LSP keybindings
  ---@type boolean
  enable_lsp_keybindings = false,

  -- Set to true to enable preview keybindings
  -- Whether to enable preview keybindings
  ---@type boolean
  enable_preview_keybindings = false,

  -- Leader key for mappings
  ---@type string
  leader = "<leader>",

  -- Local leader key for mappings
  ---@type string
  localleader = "<localleader>",
}

return mappings
