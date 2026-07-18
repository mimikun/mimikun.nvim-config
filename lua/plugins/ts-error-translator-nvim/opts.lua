---@type Config
local opts = {
  -- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
  ---@type boolean
  auto_attach = true,

  -- LSP server names to translate diagnostics for (default shown below)
  ---@type string[]
  servers = {
    "astro",
    "svelte",
    "ts_ls",
    "typescript-tools",
    "volar",
    "vtsls",
  },
}

return opts
