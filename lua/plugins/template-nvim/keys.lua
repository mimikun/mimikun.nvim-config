---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>I",
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
