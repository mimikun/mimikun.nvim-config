-- UI settings (Neovim-specific)
---@type table
local ui = {
  dashboard = {
    -- 80% of screen width
    width = 0.8,
    height = 0.8,
    border = "rounded",

    -- List of favorite entity IDs
    favorites = {},
  },
  state_viewer = {
    border = "rounded",
    show_attributes = true,
  },
}

return ui
