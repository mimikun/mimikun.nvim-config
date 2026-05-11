# [fzf-lua](https://github.com/ibhagwan/fzf-lua)

By default, fzf-lua makes LSP requests asynchronously within an FZF popup, which causes issues for null-ls. It works perfectly with the following config option:

```lua
require("fzf-lua").setup({
    lsp = {
        -- make lsp requests synchronous so they work with null-ls
        async_or_timeout = 3000,
    },
})
```

# [auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)

See [this comment](https://github.com/jose-elias-alvarez/null-ls.nvim/issues/879#issuecomment-1133925084). 