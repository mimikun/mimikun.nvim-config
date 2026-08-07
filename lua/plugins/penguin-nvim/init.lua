---@type LazySpec
local spec = {
  "jamylak/penguin.nvim",
  --lazy = false,
  cmd = require("plugins.penguin-nvim.cmds"),
  keys = require("plugins.penguin-nvim.keys"),
  event = require("plugins.penguin-nvim.events"),
  init = function(plugin)
    vim.keymap.set("n", "<CR>", function()
      local filetype = vim.bo.filetype

      if vim.fn.getcmdwintype() ~= "" or vim.bo.buftype ~= "" then
        return "<CR>"
      end

      if filetype == "help" or filetype == "netrw" or filetype == "qf" then
        return "<CR>"
      end

      require("lazy").load({
        plugins = {
          plugin.name,
        },
      })
      return require("penguin").handle_bare_enter()
    end, {
      desc = "Open penguin.nvim on bare Enter",
      expr = true,
      silent = true,
    })
  end,
  --opts = require("plugins.penguin-nvim.opts"),
  config = function()
    local opts = require("plugins.penguin-nvim.opts")
    require("penguin").setup(opts)
  end,
  cond = false,
  enabled = false,
}

return spec
