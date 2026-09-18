---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Kb",
    function()
      require("bloocky.ui").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Bloocky: toggle calendar",
    noremap = true,
    silent = true,
  },
}

return keys
