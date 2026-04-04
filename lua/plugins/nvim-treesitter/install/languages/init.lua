---@type table
local languages = {
  all = { "all" },
  stable = require("plugins.nvim-treesitter.install.languages.stable"),
  unstable = require("plugins.nvim-treesitter.install.languages.unstable"),
  unmaintained = { "unmaintained" },
  unsupported = { "unsupported" },
  using = require("plugins.nvim-treesitter.install.languages.using"),
}

languages = languages.all

return languages
