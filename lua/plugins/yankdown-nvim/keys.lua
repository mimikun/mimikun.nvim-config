---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>pd",
    function()
      require("yankdown").paste({
        direction = "after",
        --direction = "before",
      })
    end,
    mode = {
      "n",
      "x",
      "i",
    },
    desc = "Yankdown: paste",
    silent = true,
  },
}

return keys
