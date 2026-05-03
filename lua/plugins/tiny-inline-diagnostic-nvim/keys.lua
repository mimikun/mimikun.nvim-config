---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>de",
    function()
      require("tiny-inline-diagnostic").enable()
    end,
    mode = "n",
    desc = "Enable diagnostics",
    silent = true,
  },
  {
    "<leader>dd",
    function()
      require("tiny-inline-diagnostic").disable()
    end,
    mode = "n",
    desc = "Disable diagnostics",
    silent = true,
  },
  {
    "<leader>dt",
    function()
      require("tiny-inline-diagnostic").toggle()
    end,
    mode = "n",
    desc = "Toggle diagnostics",
    silent = true,
  },
  {
    "<leader>dc",
    function()
      require("tiny-inline-diagnostic").toggle_cursor_only()
    end,
    mode = "n",
    desc = "Toggle cursor-only diagnostics",
    silent = true,
  },
  {
    "<leader>dr",
    function()
      require("tiny-inline-diagnostic").reset()
    end,
    mode = "n",
    desc = "Reset diagnostic options",
    silent = true,
  },
}

return keys
