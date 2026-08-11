---@type LazySpec
local spec = {
  "L3MON4D3/LuaSnip",
  --lazy = false,
  -- No trigger of its own:
  -- blink.cmp pulls this in through its dependencies, and drives expansion and jumping through `snippets.preset = "luasnip"`.
  -- NO TE: `make install_jsregexp` is only needed for regex transformations in VSCode-style snippets (`${1/foo/bar/}`), which lua snippets do not use.
  --build = "make install_jsregexp",
  --url = "",
  --name = "",
  --dev = false,
  --dir = "",
  --build = "",
  --branch = "",
  --tag = "",
  --version = "",
  --commit = "",
  --main = "",
  --pin = false,
  --submodules = false,
  --module = false,
  --optional = false,
  --ft = require("plugins.luasnip.ft"),
  cmd = require("plugins.luasnip.cmds"),
  --keys = require("plugins.luasnip.keys"),
  --event = require("plugins.luasnip.events"),
  --dependencies = require("plugins.luasnip.dependencies"),
  --init = function()
  --  -- NOTE: INIT
  --end,
  --opts = require("plugins.luasnip.opts"),
  config = function()
    local opts = require("plugins.luasnip.opts")
    require("luasnip").setup(opts)

    -- Lua snippets live in luasnippets/ at the config root, one file per filetype (all.lua applies everywhere).
    -- lazy_load only reads a file the first time its filetype is opened.
    require("luasnip.loaders.from_lua").lazy_load({
      paths = {
        vim.fs.joinpath(vim.fn.stdpath("config"), "luasnippets"),
      },
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
