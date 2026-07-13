-- general settings
vim.o.autoindent = false
vim.o.laststatus = 0
vim.o.ruler = false

-- line settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '
vim.o.wrap = false

vim.pack.add({
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-mini/mini.nvim',
})

vim.cmd.packadd('render-markdown.nvim')

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup({ style = 'night' })
vim.cmd.colorscheme('tokyonight')

require('nvim-treesitter')
    .install({ 'html', 'latex', 'markdown', 'markdown_inline', 'yaml' })
    :wait()

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('Highlighter', {}),
    pattern = 'markdown',
    callback = function(args)
        vim.treesitter.start(args.buf)
    end,
})

require('mini.icons').setup({})

require('render-markdown').setup(
    --CONFIG_HERE
)
