---@type LazySpec
local spec = {
  "romus204/tree-sitter-manager.nvim",
  --lazy = false,
  cmd = require("plugins.tree-sitter-manager-nvim.cmds"),
  event = require("plugins.tree-sitter-manager-nvim.events"),
  --opts = require("plugins.tree-sitter-manager-nvim.opts"),
  config = function()
    local opts = require("plugins.tree-sitter-manager-nvim.opts")
    require("tree-sitter-manager").setup(opts)

    -- Update all installed parsers at once (wrapper around `:TSUpdate!`).
    -- The plugin's `:TSUpdate` requires either an argument or a bang;
    -- this provides a memorable, argument-less command for a full update.
    vim.api.nvim_create_user_command("TSUpdateAll", function()
      vim.cmd.TSUpdate({
        bang = true,
      })
    end, {
      desc = "Update all installed treesitter parsers",
    })
  end,
  cond = false,
  enabled = false,
}

return spec
