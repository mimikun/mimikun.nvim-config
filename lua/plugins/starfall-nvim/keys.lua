---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ss",
    "<cmd>StarfallToggle<CR>",
    mode = {
      "n",
    },
    desc = "Toggle starfall",
    silent = true,
  },
}

return keys
