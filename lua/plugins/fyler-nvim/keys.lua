---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>e",
    function()
      require("fyler").open({
        --kind = "split_left_most",
      })
    end,
    mode = {
      "n",
    },
    desc = "Fyler.nvim - Open",
    silent = true,
  },
}

return keys
