---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>bn",
    "<Plug>(cokeline-focus-next)",
    mode = "n",
    desc = "Cokeline: focus next buffer",
    silent = true,
  },
  {
    "<leader>bp",
    "<Plug>(cokeline-focus-prev)",
    mode = "n",
    desc = "Cokeline: focus prev buffer",
    silent = true,
  },
}

return keys
