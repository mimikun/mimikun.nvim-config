---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>T",
    function()
      vim.fn.feedkeys(":Template ")
    end,
    mode = {
      "n",
    },
    desc = "Insert Template",
    silent = true,
  },
}

return keys
