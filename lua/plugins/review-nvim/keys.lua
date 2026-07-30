---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>rv",
    function()
      require("review").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Toggle review",
    silent = true,
  },
}

return keys
