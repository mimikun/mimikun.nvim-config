-- To exclude certain servers from being automatically enabled:
---@type boolean | string[] | { exclude: string[] }
local automatic_enable = {
  --"lua_ls",
  --"vimls",
  exclude = {
    "rust_analyzer",
    "ts_ls",
  },
}

return automatic_enable
