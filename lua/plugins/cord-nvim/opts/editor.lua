-- Editor configuration
---@type CordEditorConfig
local editor = {
  -- Editor client name, one of "vim", "neovim", "lunarvim", "nvchad", "astronvim", "lazyvim" or a custom Discord application ID
  ---@type string | "vim" | "neovim" | "lunarvim" | "nvchad" | "astronvim" | "lazyvim"
  client = "neovim",

  -- Editor tooltip text
  ---@type string
  tooltip = "The Superior Text Editor",

  -- Optional editor icon
  ---@type string
  icon = nil,
}

return editor
