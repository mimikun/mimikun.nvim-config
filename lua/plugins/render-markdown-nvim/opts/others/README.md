# Info

## vimwiki

> [!NOTE]
>
> [vimwiki](https://github.com/vimwiki/vimwiki) overrides the `filetype` of
> `markdown` files, as such there are additional setup steps.
>
> - Add `vimwiki` to the `file_types` configuration of this plugin
>
> ```lua
> require('render-markdown').setup({
>     file_types = { 'markdown', 'vimwiki' },
> })
> ```
>
> - Register `markdown` as the parser for `vimwiki` files
>
> ```lua
> vim.treesitter.language.register('markdown', 'vimwiki')
> ```


