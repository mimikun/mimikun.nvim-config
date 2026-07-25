---@type LazySpec
local spec = {
  "m00qek/baleia.nvim",
  --lazy = false,
  --version = "*",
  cmd = require("plugins.baleia-nvim.cmds"),
  event = require("plugins.baleia-nvim.events"),
  --opts = require("plugins.baleia-nvim.opts"),
  config = function()
    local opts = require("plugins.baleia-nvim.opts")
    vim.g.baleia = require("baleia").setup(opts)

    -- Command to colorize the current buffer
    vim.api.nvim_create_user_command("BaleiaColorize", function()
      vim.g.baleia.once(vim.api.nvim_get_current_buf())
    end, {
      bang = true,
    })

    -- Command to show logs
    vim.api.nvim_create_user_command("BaleiaLogs", vim.cmd.messages, {
      bang = true,
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
