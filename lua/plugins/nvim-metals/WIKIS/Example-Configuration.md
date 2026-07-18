These settings are a work in progress for using https://scalameta.org/metals with the built-in LSP support of Nvim. They are also meant to serve as an example of what a setup can look like. They aren't necessarily meant to be copied verbatim, but rather referenced, improved, tweaked, etc.

Some of the examples also assume that you a few other plugins installed to show you how to utilize some of the other common plugins in the ecosystem. More than likely you'll want to use these as some of the Nvim LSP internal implementations for things like completions are a bit unpolished, especially if you're coming from other LSP implementations, like coc.nvim.

**Also ensure that you have Nvim nightly installed. The latest stable release does not yet have built-in LSP support.**

Here are a few other plugins that you'll often see paired with LSP configs for Nvim.

* https://github.com/neovim/nvim-lspconfig (automated installation and basic setup info)
* https://github.com/nvim-lua/completion-nvim (completions much like your familiar to with other LSP clients)
* https://github.com/nvim-lua/telescope.nvim (offers a more interactive find references and workspace symbols)

```vim
"-----------------------------------------------------------------------------
" nvim-lsp example Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
" Here is an example of how to use telescope as an alternative to the default references
" nnoremap <silent> <leader>s   <cmd>lua require'telescope.builtin'.lsp_references{}<CR> 
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require 'metals.decoration'.show_hover_message()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>


"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------
" If you just use the latest stable version, then this setting isn't necessary
let g:metals_server_version = '0.9.4+18-744ffa6f-SNAPSHOT'

" Decoration color. Available options shown by :highlights
let g:metals_decoration_color = 'Conceal'

"-----------------------------------------------------------------------------
" lua handlers
"-----------------------------------------------------------------------------
:lua << EOF
  local lspconfig = require'lspconfig'
  local metals    = require'metals'
  local setup     = require'metals.setup'
  local M         = {}

  M.on_attach = function()
      " Note that both of these are for external plugins
      require'completion'.on_attach()
      setup.auto_commands()
    end

  lspconfig.metals.setup{
    on_attach    = M.on_attach;
    root_dir     = metals.root_pattern("build.sbt", "build.sc", ".git");
    init_options = {
      -- If you set this, make sure to have the `metals#status()` function
      -- in your statusline, or you won't see any status messages
      statusBarProvider            = "on";
      inputBoxProvider             = true;
      quickPickProvider            = true;
      executeClientCommandProvider = true;
      decorationProvider           = true;
      didFocusProvider             = true;
    };

    handlers = {
      ["textDocument/hover"]          = metals['textDocument/hover'];
      ["metals/status"]               = metals['metals/status'];
      ["metals/inputBox"]             = metals['metals/inputBox'];
      ["metals/quickPick"]            = metals['metals/quickPick'];
      ["metals/executeClientCommand"] = metals["metals/executeClientCommand"];
      ["metals/publishDecorations"]   = metals["metals/publishDecorations"];
      ["metals/didFocusTextDocument"] = metals["metals/didFocusTextDocument"];
    };
  }

EOF

"-----------------------------------------------------------------------------
" completion-nvim settings
"-----------------------------------------------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"-----------------------------------------------------------------------------
" Helpful general settings, I recommend making sure these are set
"-----------------------------------------------------------------------------
" This is needed to enable completions
autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Needed if you want to set your own gutter signs
" NOTE: the `texthl` groups I created. You can use the defaults or create your
" own to match your statusline for example
call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspGutterError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspGutterWarning"})

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" always show signcolumns
set signcolumn=yes
```
