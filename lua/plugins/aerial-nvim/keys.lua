---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>a",
    function()
      require("aerial").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Aerial: toggle outline",
    silent = true,
  },
}

return keys
