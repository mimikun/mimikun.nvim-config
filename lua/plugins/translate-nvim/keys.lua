---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Rj",
    "<Cmd>Translate JA<CR>",
    mode = {
      "n",
      "x",
    },
    desc = "Translate into Japanese",
    silent = true,
  },
  {
    "<leader>Re",
    "<Cmd>Translate EN<CR>",
    mode = {
      "n",
      "x",
    },
    desc = "Translate into English",
    silent = true,
  },
}

return keys
