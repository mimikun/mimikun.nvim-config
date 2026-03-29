---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>p",
    "<cmd>PasteImage<cr>",
    mode = "n",
    desc = "Paste image from system clipboard",
    { silent = true },
  },
}

return keys
