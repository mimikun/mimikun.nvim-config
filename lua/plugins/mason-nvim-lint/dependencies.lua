-- NOTE: listing nvim-lint here makes it load when this plugin loads, which is
-- earlier than its own BufReadPost/BufWritePost triggers. That is required:
-- mason-nvim-lint reads `linters_by_ft` out of a configured nvim-lint, and an
-- unloaded nvim-lint has an empty one.
---@type LazySpec[]
local dependencies = {
  "mason-org/mason.nvim",
  "mfussenegger/nvim-lint",
}

return dependencies
