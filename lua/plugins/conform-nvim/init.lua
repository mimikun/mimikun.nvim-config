---@type LazySpec
local spec = {
  "stevearc/conform.nvim",
  --lazy = false,
  cmd = require("plugins.conform-nvim.cmds"),
  keys = require("plugins.conform-nvim.keys"),
  event = require("plugins.conform-nvim.events"),
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  --opts = require("plugins.conform-nvim.opts"),
  config = function()
    local opts = require("plugins.conform-nvim.opts")
    local conform = require("conform")

    conform.setup(opts)

    -- Define some user_commands
    -- Run async formatting
    vim.api.nvim_create_user_command("Conform", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = {
            args.line1,
            0,
          },
          ["end"] = {
            args.line2,
            end_line:len(),
          },
        }
      end
      conform.format({
        async = true,
        lsp_format = "fallback",
        range = range,
      })
    end, {
      range = true,
    })

    -- Run Enable/Disable
    vim.api.nvim_create_user_command("ConformDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("ConformEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
