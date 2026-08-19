---@type LazyKeysSpec[]
local keys = {
  {
    "K",
    function()
      require("hover").open()
    end,
    mode = {
      "n",
    },
    desc = "hover.nvim (open)",
    silent = true,
  },
  {
    "gK",
    function()
      require("hover").enter()
    end,
    mode = {
      "n",
    },
    desc = "hover.nvim (enter)",
    silent = true,
  },
  {
    "<leader>kp",
    function()
      require("hover").switch("previous")
    end,
    mode = {
      "n",
    },
    desc = "hover.nvim (previous source)",
    silent = true,
  },
  {
    "<leader>kn",
    function()
      require("hover").switch("next")
    end,
    mode = {
      "n",
    },
    desc = "hover.nvim (next source)",
    silent = true,
  },
}

return keys
