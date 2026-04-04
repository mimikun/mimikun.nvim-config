---@type table
local opts = {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath("data") .. "/site",
}

return opts
