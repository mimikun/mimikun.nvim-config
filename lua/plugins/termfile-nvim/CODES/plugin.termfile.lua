-- Auto-loaded when the plugin is on the runtimepath. This is what makes
-- termfile.nvim work with zero configuration and no commands: the autocommands
-- are installed as soon as Neovim starts.
--
-- Users who want to override defaults may still call
-- `require("termfile").setup({ ... })`; setup() takes precedence over this.

if vim.g.loaded_termfile then
  return
end
vim.g.loaded_termfile = true

require("termfile").init()
