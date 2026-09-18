---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Qt",
    "<cmd>SquixRun<cr>",
    mode = {
      "n",
    },
    desc = "Squix: run SQL in TUI",
    silent = true,
  },
  {
    -- <Esc> first so '<,'> reflect THIS selection, not the previous one.
    "<leader>Qt",
    "<Esc><cmd>'<,'>SquixRun<cr>",
    mode = {
      "v",
    },
    desc = "Squix: run SQL in TUI",
    silent = true,
  },
  {
    "<leader>Qs",
    "<cmd>SquixSwitch<cr>",
    mode = {
      "n",
    },
    desc = "Squix: switch connection",
    silent = true,
  },
  {
    "<leader>Qi",
    "<cmd>SquixInit<cr>",
    mode = {
      "n",
    },
    desc = "Squix: create connection",
    silent = true,
  },
  {
    "<leader>QS",
    "<cmd>SquixStatus<cr>",
    mode = {
      "n",
    },
    desc = "Squix: connection status",
    silent = true,
  },
  {
    "<leader>QT",
    "<cmd>SquixTables<cr>",
    mode = {
      "n",
    },
    desc = "Squix: browse tables",
    silent = true,
  },
  {
    "<leader>Qq",
    "<cmd>SquixRunNamedQuery<cr>",
    mode = {
      "n",
    },
    desc = "Squix: run saved query",
    silent = true,
  },
  {
    "<leader>Qa",
    "<cmd>SquixAdd<cr>",
    mode = {
      "n",
    },
    desc = "Squix: save SQL as query",
    silent = true,
  },
  {
    "<leader>Qa",
    "<Esc><cmd>'<,'>SquixAdd<cr>",
    mode = {
      "v",
    },
    desc = "Squix: save SQL as query",
    silent = true,
  },
}

return keys
