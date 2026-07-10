---@type LazyKeysSpec[]
local keys = {
  {
    "<leader><C-j>",
    "<Plug>(skkelua-toggle)",
    mode = {
      "i",
      "c",
      "t",
    },
    desc = "Toggle Skkelua",
    silent = true,
  },
}

return keys
