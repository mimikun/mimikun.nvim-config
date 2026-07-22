---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>v",
    "<cmd>Vallow<cr>",
    mode = {
      "n",
    },
    desc = "Vallow: toggle",
    silent = true,
  },
  {
    "<leader>vr",
    "<cmd>VallowRefresh<cr>",
    mode = {
      "n",
    },
    desc = "Vallow: refresh",
    silent = true,
  },
  {
    "<leader>vs",
    "<cmd>VallowSearch<cr>",
    mode = {
      "n",
    },
    desc = "Vallow: search findings",
    silent = true,
  },
}

return keys
