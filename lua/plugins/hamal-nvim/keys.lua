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
    desc = "Hamal Jump (split screen)",
    silent = true,
  },
}

return keys
