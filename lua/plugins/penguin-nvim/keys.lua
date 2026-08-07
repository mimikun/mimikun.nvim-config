---@type LazyKeysSpec[]
local keys = {
  {
    "<M-Space>",
    function()
      require("penguin").open()
    end,
    mode = {
      "n",
    },
    desc = "Open penguin.nvim",
    silent = true,
  },
}

return keys
