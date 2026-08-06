-- NOTE: listing conform.nvim here makes it load when this plugin loads, which
-- is earlier than its own BufWritePre/cmd/keys triggers. That is required:
-- mason-conform reads `formatters_by_ft` out of a configured conform, and an
-- unloaded conform has an empty one.
---@type LazySpec[]
local dependencies = {
  "mason-org/mason.nvim",
  "stevearc/conform.nvim",
}

return dependencies
