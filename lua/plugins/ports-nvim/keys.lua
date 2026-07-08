---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>p",
    "<cmd>Ports<cr>",
    --function()
    --end,
    mode = {
      "n",
    },
    desc = "Ports",
    silent = true,
  },
}

return keys
