---@type LazySpec
local spec = {
  "s0cks/taskfile.nvim",
  --lazy = false,
  --version = "*",
  cmd = require("plugins.taskfile-nvim.cmds"),
  dependencies = require("plugins.taskfile-nvim.dependencies"),
  opts = require("plugins.taskfile-nvim.opts"),
  config = function()
    vim.api.nvim_create_user_command("TaskfilePicker", function()
      require("taskfile.picker").task_picker()
    end, {})
  end,
  --cond = false,
  --enabled = false,
}

return spec
