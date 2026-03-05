---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ge",
    function()
      require("tiny-glimmer").enable()
    end,
    mode = "n",
    desc = "Enable animations",
    { silent = true },
  },
  {
    "<leader>gd",
    function()
      require("tiny-glimmer").disable()
    end,
    mode = "n",
    desc = "Disable animations",
    { silent = true },
  },
  {
    "<leader>gt",
    function()
      require("tiny-glimmer").toggle()
    end,
    mode = "n",
    desc = "Toggle animations",
    { silent = true },
  },
}

return keys
