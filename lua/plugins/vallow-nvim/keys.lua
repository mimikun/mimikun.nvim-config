---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>v",
    "<cmd>Vallow<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Vallow: toggle",
    silent = true,
  },
  {
    "<leader>vr",
    "<cmd>VallowRefresh<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Vallow: refresh",
    silent = true,
  },
  --{
  {
    "<leader>vs",
    "<cmd>VallowSearch<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Vallow: search findings",
    silent = true,
  },
}

return keys
