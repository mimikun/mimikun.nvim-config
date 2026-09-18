---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>es",
    "<cmd>Shelter toggle<cr>",
    mode = {
      "n",
    },
    desc = "Toggle masking",
    silent = true,
  },
}

return keys
