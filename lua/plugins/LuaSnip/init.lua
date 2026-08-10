---@type LazySpec
local spec = {
  "L3MON4D3/LuaSnip",
  --lazy = false,
  -- No trigger of its own: blink.cmp pulls this in through its dependencies,
  -- and drives expansion and jumping through `snippets.preset = "luasnip"`.
  -- NOTE: `make install_jsregexp` is only needed for regex transformations in
  -- VSCode-style snippets (`${1/foo/bar/}`), which lua snippets do not use.
  --build = "make install_jsregexp",
  --opts = require("plugins.LuaSnip.opts"),
  config = function()
    local opts = require("plugins.LuaSnip.opts")
    local luasnip = require("luasnip")

    luasnip.setup(opts)

    -- Lua snippets live in luasnippets/ at the config root, one file per
    -- filetype (all.lua applies everywhere). lazy_load only reads a file the
    -- first time its filetype is opened.
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
