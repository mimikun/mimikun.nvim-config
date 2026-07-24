# The NERDTree

## NERDTree Plugins

NERDTree can be extended with custom mappings and functions using its built-in API. The details of this API are described in the included documentation. Several plugins have been written, and are available on Github for installation like any other plugin. The plugins in this list are maintained (or not) by their respective owners, and certain combinations may be incompatible.

* [Xuyuanp/nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin): Shows Git status flags for files and folders in NERDTree.
* [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons): Adds filetype-specific icons to NERDTree files and folders.
* [tiagofumo/vim-nerdtree-syntax-highlight](https://github.com/tiagofumo/vim-nerdtree-syntax-highlight): Adds syntax highlighting to NERDTree based on filetype.
* [scrooloose/nerdtree-project-plugin](https://github.com/scrooloose/nerdtree-project-plugin): Saves and restores the state of the NERDTree between sessions.
* [PhilRunninger/nerdtree-buffer-ops](https://github.com/PhilRunninger/nerdtree-buffer-ops): 1) Highlights open files in a different color. 2) Closes a buffer directly from NERDTree.
* [PhilRunninger/nerdtree-visual-selection](https://github.com/PhilRunninger/nerdtree-visual-selection): Enables NERDTree to open, delete, move, or copy multiple Visually-selected files at once.

If any others should be listed, mention them in an issue or pull request.

## Frequently Asked Questions

In the answers to these questions, you will see code blocks that you can put in your `vimrc` file.

### How can I map a specific key or shortcut to open NERDTree?

NERDTree doesn't create any shortcuts outside of the NERDTree window, so as not to overwrite any of your other shortcuts. Use the `nnoremap` command in your `vimrc`. You, of course, have many keys and NERDTree commands to choose from. Here are but a few examples.

```vim
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
```

### How do I open NERDTree automatically when Vim starts?

Each code block below is slightly different, as described in the `" Comment lines`.

```vim
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
```

---

```vim
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
```

---

```vim
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
```

---

```vim
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
```

---

```vim
" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
```

---

```vim
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
```

### How can I close Vim or a tab automatically when NERDTree is the last window?

Because of the changes in how Vim handles its `autocmd` and layout locking `quit` command is no longer available in Vim9 auto commands, Depending on which version you're running select one of these solutions.

__NeoVim users should be able to choose either one of them!__

#### Vim9

```vim
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
```

---

```vim
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
```

#### Vim8 or older

```vim
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
```

---

```vim
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
```

### How can I prevent other buffers replacing NERDTree in its window?

```vim
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
```

### Can I have the same NERDTree on every tab automatically?

```vim
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
```

or change your NERDTree-launching shortcut key like so:

```vim
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
```

### How can I change the default arrows?

```vim
let g:NERDTreeDirArrowExpandable = '?'
let g:NERDTreeDirArrowCollapsible = '?'
```

The preceding values are the non-Windows default arrow symbols. Setting these variables to empty strings will remove the arrows completely and shift the entire tree two character positions to the left. See `:h NERDTreeDirArrowExpandable` for more details.

### How can I show lines of files?

```vim
let g:NERDTreeFileLines = 1
```

Lines in the file are displayed as shown below.

```text
</pack/packer/start/nerdtree/
▸ autoload/
▸ doc/
▸ lib/
▸ nerdtree_plugin/
▸ plugin/
▸ syntax/
  _config.yml (1)
  CHANGELOG.md (307)
  LICENCE (13)
  README.markdown (234)
  screenshot.png (219)
```

### Can NERDTree access remote files via scp or ftp?

Short answer: No, and there are no plans to add that functionality. However, Vim ships with a plugin that does just that. It's called netrw, and by adding the following lines to your `.vimrc`, you can use it to open files over the `scp:`, `ftp:`, or other protocols, while still using NERDTree for all local files. The function seamlessly makes the decision to open NERDTree or netrw, and other supported protocols can be added to the regular expression.

```vim
" Function to open the file or NERDTree or netrw.
"   Returns: 1 if either file explorer was opened; otherwise, 0.
function! s:OpenFileOrExplorer(...)
    if a:0 == 0 || a:1 == ''
        NERDTree
    elseif filereadable(a:1)
        execute 'edit '.a:1
        return 0
    elseif a:1 =~? '^\(scp\|ftp\)://' " Add other protocols as needed.
        execute 'Vexplore '.a:1
    elseif isdirectory(a:1)
        execute 'NERDTree '.a:1
    endif
    return 1
endfunction

" Auto commands to handle OS commandline arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc()==1 && !exists('s:std_in') | if <SID>OpenFileOrExplorer(argv()[0]) | wincmd p | enew | wincmd p | endif | endif

" Command to call the OpenFileOrExplorer function.
command! -n=? -complete=file -bar Edit :call <SID>OpenFileOrExplorer('<args>')

" Command-mode abbreviation to replace the :edit Vim command.
cnoreabbrev e Edit
```
