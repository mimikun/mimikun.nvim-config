```lua
-- optional cmp completion source for require statements and module annotations
return { 
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, {
      name = "lazydev",
      -- set group index to 0 to skip loading LuaLS completions
      group_index = 0,
    })
  end,
}
```

```lua
-- optional blink completion source for require statements and module annotations
return { 
  "saghen/blink.cmp",
  opts = {
    sources = {
      -- add lazydev to your completion providers
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  },
}
```
