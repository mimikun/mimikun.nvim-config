---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ps",
    --"<cmd>Pomodoro start<cr>",
    function()
      require("pomodoro").start(nil)
    end,
    mode = {
      "n",
    },
    desc = "Pomodoro: start",
    silent = true,
  },
  {
    "<leader>pp",
    --"<cmd>Pomodoro pause<cr>",
    function()
      require("pomodoro").pause()
    end,
    mode = {
      "n",
    },
    desc = "Pomodoro: pause",
    silent = true,
  },
  {
    "<leader>pr",
    --"<cmd>Pomodoro resume<cr>",
    function()
      require("pomodoro").resume()
    end,
    mode = {
      "n",
    },
    desc = "Pomodoro: resume",
    silent = true,
  },
  {
    "<leader>px",
    --"<cmd>Pomodoro stop<cr>",
    function()
      require("pomodoro").stop()
    end,
    mode = {
      "n",
    },
    desc = "Pomodoro: stop",
    silent = true,
  },
  {
    "<leader>pw",
    --"<cmd>Pomodoro status<cr>",
    function()
      require("pomodoro").status()
    end,
    mode = {
      "n",
    },
    desc = "Pomodoro: window",
    silent = true,
  },
  {
    "<leader>pS",
    --"<cmd>Pomodoro stats<cr>",
    function()
      require("pomodoro").stats_summary()
    end,
    mode = {
      "n",
    },
    desc = "Pomodoro: stats",
    silent = true,
  },
}

return keys
