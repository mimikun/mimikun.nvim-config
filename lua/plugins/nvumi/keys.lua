---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>on",
    function()
      require("nvumi.main").open()
    end,
    mode = {
      "n",
    },
    desc = "Open nvumi",
    silent = true,
  },
}

return keys
