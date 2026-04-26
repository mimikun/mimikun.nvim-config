---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>a",
    function()
      require("aerial").toggle()
    end,
    mode = "n",
    desc = "",
    silent = true,
  },
}

return keys
