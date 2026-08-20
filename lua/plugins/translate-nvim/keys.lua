---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>tj",
    "<Cmd>Translate JA<CR>",
    mode = {
      "n",
      "x",
    },
    desc = "Translate into Japanese",
    silent = true,
  },
  {
    "<leader>te",
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
