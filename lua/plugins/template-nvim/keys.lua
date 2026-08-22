---@type LazyKeysSpec[]
local keys = {
  {
    "<Leader>tp",
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
