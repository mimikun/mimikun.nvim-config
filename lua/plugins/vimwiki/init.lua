---@type LazySpec
local spec = {
  'vimwiki/vimwiki',
  --lazy = false,
  --dir = ""
  --url = ""
  --name = ""
  --dev = false
  --build = "",
  --branch = "",
  --tag = "",
  --commit = "",
  --version = "",
  --ft = require("plugins.vimwiki.ft"),
  --cmd = require("plugins.vimwiki.cmds"),
  --keys = require("plugins.vimwiki.keys"),
  --event = require("plugins.vimwiki.events"),
  --dependencies = require("plugins.vimwiki.dependencies"),
  init = function()
    vim.g.vimwiki_path = '~/vimwiki/'
    vim.g.vimwiki_syntax = 'markdown'
    vim.g.vimwiki_ext = 'md'
  end,
  --opts = require("plugins.vimwiki.opts"),
  --config = function()
  --    INIT
  --end,
  --main = ""
  --pin = false,
  --submodules = false,
  --module = false,
  --priority = 1000,
  --optional = false,
  cond = false,
  enabled = false,
}

return spec
