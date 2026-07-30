---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>sz",
    "<cmd>Chezmoi pick<cr>",
    mode = {
      "n",
    },
    desc = "Chezmoi source files",
    silent = true,
  },
}

return keys
