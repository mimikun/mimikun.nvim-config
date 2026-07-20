---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>st",
    "<cmd>SquixRun<cr>",
    mode = {
      "n",
    },
    desc = "Squix: run SQL in TUI",
    silent = true,
  },
  {
    -- <Esc> first so '<,'> reflect THIS selection, not the previous one.
    "<leader>st",
    "<Esc><cmd>'<,'>SquixRun<cr>",
    mode = {
      "v",
    },
    desc = "Squix: run SQL in TUI",
    silent = true,
  },
  {
    "<leader>ss",
    "<cmd>SquixSwitch<cr>",
    mode = {
      "n",
    },
    desc = "Squix: switch connection",
    silent = true,
  },
  {
    "<leader>si",
    "<cmd>SquixInit<cr>",
    mode = {
      "n",
    },
    desc = "Squix: create connection",
    silent = true,
  },
  {
    "<leader>sS",
    "<cmd>SquixStatus<cr>",
    mode = {
      "n",
    },
    desc = "Squix: connection status",
    silent = true,
  },
  {
    "<leader>sT",
    "<cmd>SquixTables<cr>",
    mode = {
      "n",
    },
    desc = "Squix: browse tables",
    silent = true,
  },
  {
    "<leader>sq",
    "<cmd>SquixRunNamedQuery<cr>",
    mode = {
      "n",
    },
    desc = "Squix: run saved query",
    silent = true,
  },
  {
    "<leader>sa",
    "<cmd>SquixAdd<cr>",
    mode = {
      "n",
    },
    desc = "Squix: save SQL as query",
    silent = true,
  },
  {
    "<leader>sa",
    "<Esc><cmd>'<,'>SquixAdd<cr>",
    mode = {
      "v",
    },
    desc = "Squix: save SQL as query",
    silent = true,
  },
}

return keys
