---@type LazyKeysSpec[]
local keys = {
  {
    "<C-a>",
    function()
      require("dial.map").manipulate("increment", "normal")
    end,
    mode = {
      "n",
    },
    desc = "Increment under cursor",
    silent = true,
  },
  {
    "<C-x>",
    function()
      require("dial.map").manipulate("decrement", "normal")
    end,
    mode = {
      "n",
    },
    desc = "Decrement under cursor",
    silent = true,
  },
  {
    "g<C-a>",
    function()
      require("dial.map").manipulate("increment", "gnormal")
    end,
    mode = {
      "n",
    },
    desc = "Increment under cursor (additive)",
    silent = true,
  },
  {
    "g<C-x>",
    function()
      require("dial.map").manipulate("decrement", "gnormal")
    end,
    mode = {
      "n",
    },
    desc = "Decrement under cursor (additive)",
    silent = true,
  },
  {
    "<C-a>",
    function()
      require("dial.map").manipulate("increment", "visual", "visual")
    end,
    mode = {
      "x",
    },
    desc = "Increment selection",
    silent = true,
  },
  {
    "<C-x>",
    function()
      require("dial.map").manipulate("decrement", "visual", "visual")
    end,
    mode = {
      "x",
    },
    desc = "Decrement selection",
    silent = true,
  },
  {
    "g<C-a>",
    function()
      require("dial.map").manipulate("increment", "gvisual", "visual")
    end,
    mode = {
      "x",
    },
    desc = "Increment selection (additive)",
    silent = true,
  },
  {
    "g<C-x>",
    function()
      require("dial.map").manipulate("decrement", "gvisual", "visual")
    end,
    mode = {
      "x",
    },
    desc = "Decrement selection (additive)",
    silent = true,
  },
}

return keys
