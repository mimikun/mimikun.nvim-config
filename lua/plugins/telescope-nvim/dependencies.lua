---@type LazySpec[]
local dependencies = {
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

return dependencies
