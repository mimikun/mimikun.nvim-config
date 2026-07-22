local integrations = {
  -- Fixes vim.lsp.config workspace management for LuaLS Only create a new workspace if the buffer is not part of an existing workspace or one of its libraries.
  -- Only works on Neovim 0.11+.
  lspconfig = true,

  -- add the cmp source for completion of:
  -- `require "modname"`
  -- `---@module "modname"`
  cmp = true,

  -- same, but for Coq
  coq = false,
}

return integrations
