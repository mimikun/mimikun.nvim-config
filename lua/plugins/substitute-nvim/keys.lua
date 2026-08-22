---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>rr",
    function()
      require("substitute").operator()
    end,
    mode = {
      "n",
    },
    desc = "Substitute over motion",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rl",
    function()
      require("substitute").line()
    end,
    mode = {
      "n",
    },
    desc = "Substitute line",
    noremap = true,
    silent = true,
  },
  {
    "<leader>re",
    function()
      require("substitute").eol()
    end,
    mode = {
      "n",
    },
    desc = "Substitute to end of line",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rr",
    function()
      require("substitute").visual()
    end,
    mode = {
      "x",
    },
    desc = "Substitute selection",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rs",
    function()
      require("substitute.range").operator()
    end,
    mode = {
      "n",
    },
    desc = "Substitute over range (motion)",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rs",
    function()
      require("substitute.range").visual()
    end,
    mode = {
      "x",
    },
    desc = "Substitute over range (selection)",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rw",
    function()
      require("substitute.range").word()
    end,
    mode = {
      "n",
    },
    desc = "Substitute word over range",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rx",
    function()
      require("substitute.exchange").operator()
    end,
    mode = {
      "n",
    },
    desc = "Exchange over motion",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rX",
    function()
      require("substitute.exchange").line()
    end,
    mode = {
      "n",
    },
    desc = "Exchange line",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rx",
    function()
      require("substitute.exchange").visual()
    end,
    mode = {
      "x",
    },
    desc = "Exchange selection",
    noremap = true,
    silent = true,
  },
  {
    "<leader>rc",
    function()
      require("substitute.exchange").cancel()
    end,
    mode = {
      "n",
    },
    desc = "Cancel pending exchange",
    noremap = true,
    silent = true,
  },
}

return keys
