---@type LazyKeysSpec[]
local keys = {
  {
    "<leader><leader>",
    function()
      require("hamal").split()
    end,
    mode = {
      "n",
      "v",
    },
    desc = "",
    silent = true,
  },
}

return keys
