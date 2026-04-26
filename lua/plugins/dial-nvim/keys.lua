---@type LazyKeysSpec[]
local keys = {
  {
    "<C-a>",
    function()
      require("dial.map").manipulate("increment", "normal")
    end,
    mode = "n",
    desc = "",
    { silent = true },
  },
  {
    "<C-x>",
    function()
      require("dial.map").manipulate("decrement", "normal")
    end,
    mode = "n",
    desc = "",
    { silent = true },
  },
  {
    "g<C-a>",
    function()
      require("dial.map").manipulate("increment", "gnormal")
    end,
    mode = "n",
    desc = "",
    { silent = true },
  },
  {
    "g<C-x>",
    function()
      require("dial.map").manipulate("decrement", "gnormal")
    end,
    mode = "n",
    desc = "",
    { silent = true },
  },
  {
    "<C-a>",
    function()
      require("dial.map").manipulate("increment", "visual")
    end,
    mode = "x",
    desc = "",
    { silent = true },
  },
  {
    "<C-x>",
    function()
      require("dial.map").manipulate("decrement", "visual")
    end,
    mode = "x",
    desc = "",
    { silent = true },
  },
  {
    "g<C-a>",
    function()
      require("dial.map").manipulate("increment", "gvisual")
    end,
    mode = "x",
    desc = "",
    { silent = true },
  },
  {
    "g<C-x>",
    function()
      require("dial.map").manipulate("decrement", "gvisual")
    end,
    mode = "x",
    desc = "",
    { silent = true },
  },
}

return keys
