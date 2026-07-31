---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>st",
    "<cmd>Shelter toggle<cr>",
    mode = {
      "n",
    },
    desc = "Toggle masking",
    silent = true,
  },
}

return keys
