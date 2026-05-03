---@type table
local keymaps = {
  -- Set to false to disable all default keymaps
  enabled = true,

  -- Toggle dashboard
  dashboard = "<leader>hd",

  -- Open entity picker (requires telescope)
  picker = "<leader>hp",

  -- Reload LSP cache
  reload_cache = "<leader>hr",

  -- Show debug info
  debug = "<leader>hD",

  -- Edit HA Lovelace dashboards
  edit_dashboard = "<leader>he",
}

return keymaps
