## How to map a command to open a buffer parent directory or current working directory when the buffer is not a file

Use `<C-r>=...<CR>` to specify a special function like below:

```vim
nnoremap <silent> <Leader>ee :<C-u>Fern <C-r>=<SID>smart_path()<CR><CR>

" Return a parent directory of the current buffer when the buffer is a file.
" Otherwise it returns a current working directory.
function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnamemodify('.', ':p')
  endif
  return fnamemodify(expand('%'), ':p:h')
endfunction
```

## How to customize fern buffer

Use `FileType` autocmd to initialize fern buffer like:

```vim
function! s:init_fern() abort
  echo "This function is called ON a fern buffer WHEN initialized"

  " Open node with 'o'
  nmap <buffer> o <Plug>(fern-action-open)

  " Add any code to customize fern buffer
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
```

## Define NERDTree like mappings

Use `s:init_fern()` above like:

```vim
function! s:init_fern() abort
  " Define NERDTree like mappings
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  nmap <buffer> ma <Plug>(fern-action-new-path)
  nmap <buffer> P gg

  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  nmap <buffer> cd <Plug>(fern-action-cd)
  nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>

  nmap <buffer> I <Plug>(fern-action-hidden-toggle)

  nmap <buffer> q :<C-u>quit<CR>
endfunction
```

https://github.com/preservim/nerdtree/blob/master/doc/NERDTree.txt#L247-L293

Note that some features are missing.

## Perform `expand or collapse directory`

Use `fern#smart#leaf` like below:

```vim
function! s:init_fern() abort
  nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer><nowait> l <Plug>(fern-my-expand-or-collapse)
endfunction
```

## Perform `enter` in explorer style but `expand` in drawer style

Use `fern#smart#drawer` like below:

```vim
function! s:init_fern() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-expand-or-enter)
        \ fern#smart#drawer(
        \   "\<Plug>(fern-open-or-expand)",
        \   "\<Plug>(fern-open-or-enter)",
        \ )
  nmap <buffer><expr>
        \ <Plug>(fern-my-collapse-or-leave)
        \ fern#smart#drawer(
        \   "\<Plug>(fern-action-collapse)",
        \   "\<Plug>(fern-action-leave)",
        \ )
  nmap <buffer><nowait> l <Plug>(fern-my-expand-or-enter)
  nmap <buffer><nowait> h <Plug>(fern-my-collapse-or-leave)
endfunction
```

## Perform `tcd` on the root node after `enter` or `leave` action

Use `<Plug>(fern-wait)` to wait `enter` or `leave` action like:

```vim
nmap <buffer> <Plug>(fern-my-enter-and-tcd)
      \ <Plug>(fern-action-enter)
      \ <Plug>(fern-wait)
      \ <Plug>(fern-action-tcd:root)

nmap <buffer> <Plug>(fern-my-leave-and-tcd)
      \ <Plug>(fern-action-leave)
      \ <Plug>(fern-wait)
      \ <Plug>(fern-action-tcd:root)
```

## Perform `tcd` on the root node on BufEnter autocmd

Use `feedkeys()` to execute the `<Plug>(fern-action-tcd:root)` like:

```vim
  augroup my_fern_tcd
    autocmd! * <buffer>
    autocmd BufEnter <buffer> call feedkeys("\<Plug>(fern-action-tcd:root)")
  augroup END
```

## Enter a project root via `^`

See https://github.com/lambdalisue/fern-mapping-project-top.vim

```vim
function! s:fern_init() abort
  " Find and enter project root
  nnoremap <buffer><silent>
        \ <Plug>(fern-my-enter-project-root)
        \ :<C-u>call fern#helper#call(funcref('<SID>map_enter_project_root'))<CR>
  nmap <buffer><expr><silent>
        \ ^
        \ fern#smart#scheme(
        \   "^",
        \   {
        \     'file': "\<Plug>(fern-my-enter-project-root)",
        \   }
        \ )
endfunction


function! s:map_enter_project_root(helper) abort
  " NOTE: require 'file' scheme
  let root = a:helper.get_root_node()
  let path = root._path
  let path = finddir('.git/..', path . ';')
  execute printf('Fern %s', fnameescape(path))
endfunction
```

## Open [bookmark:///](https://github.com/lambdalisue/fern-bookmark.vim) and return via `<C-^>`

```vim
function! s:fern_init() abort
  " Open bookmark:///
  nnoremap <buffer><silent>
        \ <Plug>(fern-my-enter-bookmark)
        \ :<C-u>Fern bookmark:///<CR>
  nmap <buffer><expr><silent>
        \ <C-^>
        \ fern#smart#scheme(
        \   "\<Plug>(fern-my-enter-bookmark)",
        \   {
        \     'bookmark': "\<C-^>",
        \   },
        \ )
endfunction
```

## Use fern as a default directory browser (hijack netrw)
Use https://github.com/lambdalisue/fern-hijack.vim

## Stay after open

Use `<C-w><C-p>` like

```vim
nmap <buffer> <Plug>(my-fern-open-and-stay) <Plug>(fern-action-open)<C-w><C-p>
```

## Close fern after open

Use `:FernDo` to execute `close` command after open.
Note that `<Plug>(fern-close-drawer)` is a **global** mapping.

```vim
  nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
  nmap <buffer><silent> <Plug>(fern-action-open-and-close)
      \ <Plug>(fern-action-open)
      \ <Plug>(fern-close-drawer)
```

## Start fern.vim on Vim startup with a particular directory

```vim
augroup my-fern-startup
  autocmd! *
  autocmd VimEnter * ++nested Fern ~/
augroup END
```

## Preview leaf content by `j/k` like VS code

![Screencast](https://user-images.githubusercontent.com/546312/92317820-d59c4d00-efb9-11ea-826e-35bf638f3dc5.gif)

```vim
function! s:fern_preview_init() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-preview-or-nop)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:edit)\<C-w>p",
        \   "",
        \ )
  nmap <buffer><expr> j
        \ fern#smart#drawer(
        \   "j\<Plug>(fern-my-preview-or-nop)",
        \   "j",
        \ )
  nmap <buffer><expr> k
        \ fern#smart#drawer(
        \   "k\<Plug>(fern-my-preview-or-nop)",
        \   "k",
        \ )
endfunction

augroup my-fern-preview
  autocmd! *
  autocmd FileType fern call s:fern_preview_init()
augroup END

" You need this otherwise you cannot switch modified buffer
set hidden
```

See https://github.com/lambdalisue/fern.vim/issues/193 for more detail