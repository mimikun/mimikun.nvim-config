---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ps",
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
