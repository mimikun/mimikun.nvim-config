nvim-jdtls uses `vim.ui.select`, that means plugins providing a `vim.ui.select` implementation are used.

## Telescope

If you want to use [telescope.nvim][2], you can add [telescope-ui-select.nvim][3]

## fzy

If using [nvim-fzy][1]:

```vimL
lua require('fzy').setup()
```




[1]: https://github.com/mfussenegger/nvim-fzy
[2]: https://github.com/nvim-telescope/telescope.nvim
[3]: https://github.com/nvim-telescope/telescope-ui-select.nvim
