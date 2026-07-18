let s:plugin_dir = expand('~/.local/share/nvim/site/pack/vendor/start')
set rtp+=.
execute 'set rtp^=' . s:plugin_dir . '/plenary.nvim'
execute 'set rtp^=' . s:plugin_dir . '/nvim-treesitter'
execute 'set rtp^=' . s:plugin_dir . '/nvim-lspconfig'

runtime! plugin/plenary.vim
runtime! plugin/nvim-treesitter.vim
runtime! plugin/playground.vim
runtime! plugin/nvim-lspconfig.vim

set noswapfile
set nobackup

filetype indent off
set nowritebackup
set noautoindent
set nocindent
set nosmartindent
set indentexpr=
set shada="NONE"

lua << EOF
_G.test_rename = true
_G.test_close = true
require("plenary/busted")
require("go").setup({
  gofmt = 'gofumpt',
  goimports = "goimports",
  verbose = true,
  log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
  lsp_cfg = true,
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  }
}
EOF
