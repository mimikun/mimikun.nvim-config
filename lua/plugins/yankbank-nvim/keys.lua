---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>y",
    "<cmd>YankBank<CR>",
    mode = {
      "n",
    },
    desc = "YankBank: open",
    noremap = true,
    silent = true,
  },
}

return keys
