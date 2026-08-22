---@type LazySpec
local spec = {
  "mrjones2014/codesettings.nvim",
  -- You don't need to lazy load this plugin since it already
  -- lazy loads its constituent parts via `plugin/*` and `ftplugin/*` files
  lazy = false,
  -- Must beat mason-lspconfig (VeryLazy) so the `*` hook below is registered before any server is enabled.
  priority = 100,
  cmd = require("plugins.codesettings-nvim.cmds"),
  event = require("plugins.codesettings-nvim.events"),
  --opts = require("plugins.codesettings-nvim.opts"),
  config = function()
    local opts = require("plugins.codesettings-nvim.opts")
    local codesettings = require("codesettings")
    codesettings.setup(opts)

    -- Global hook: every server picks up project-local settings.
    -- `with_local_settings` mutates `config` in place, which is what `vim.lsp` needs to see the merged result.
    vim.lsp.config("*", {
      before_init = function(_, config)
        codesettings.with_local_settings(config.name, config)
      end,
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
