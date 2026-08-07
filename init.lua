if vim.loader then
  vim.loader.enable()
end

require("config.variables")
require("config.tool_cache")
require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.mappings")
require("config.usercmds")
require("config.neovide")
vim.cmd.colorscheme("tokyonight")
