---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>el",
    function()
      require("ecolog").list()
    end,
    mode = {
      "n",
    },
    desc = "Ecolog List env variables",
    silent = true,
  },
  -- Files
  {
    "<leader>ef",
    "<cmd>Ecolog files<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog toggle file module",
    silent = true,
  },
  {
    "<leader>efs",
    "<cmd>Ecolog files select<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog Select active env file",
    silent = true,
  },
  {
    "<leader>efo",
    "<cmd>Ecolog files open_active<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog Open active env file",
    silent = true,
  },
  -- Remote
  {
    "<leader>er",
    "<cmd>Ecolog remote<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog toggle remote source",
    silent = true,
  },
  {
    "<leader>ers",
    "<cmd>Ecolog remote setup<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog remote setup",
    silent = true,
  },
  -- Generate
  {
    "<leader>ege",
    "<cmd>Ecolog generate .env.example<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog generate .env.example",
    silent = true,
  },
  {
    "<leader>eg",
    "<cmd>Ecolog generate<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog generate",
    silent = true,
  },
  -- Other
  {
    "<leader>eR",
    function()
      require("ecolog").refresh()
    end,
    mode = {
      "n",
    },
    desc = "Refresh env variables",
    silent = true,
  },
  {
    "<leader>ei",
    "<cmd>Ecolog interpolation<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog toggle interpolation",
    silent = true,
  },
  {
    "<leader>eh",
    "<cmd>Ecolog shell<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog toggle shell module",
    silent = true,
  },
  {
    "<leader>ey",
    "<cmd>Ecolog copy value<cr>",
    mode = {
      "n",
    },
    desc = "Ecolog copy value",
    silent = true,
  },
}

return keys
