## How do I switch between the different windows?

Press `<C-W>w`.

Also you can switch between windows faster by their direction:

```vim
" Switch between different windows by their direction`
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
```

Put the above lines in your vimrc, so now you can switch between different windows by their direction easier and faster.

## What is a buffer, a window, a tab?

This isn't a NERDTree-specific question, but misunderstanding these Vim "objects" will negatively affect your user experience. Vim is not like other text editors or IDEs, and it shouldn't be made to fit their molds. There is great power in the way Vim handles files (buffers), splits (windows), and layouts (tabs), power that you can't get in other editors. For an in-depth explanation, read the following blog post: http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/ or this StackOverflow discussion: http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers.

## Is there any support for `git` flags?

Yes, install [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin).

## How can I open files, directories, and bookmarks in new tabs?

Use the `t` and `T` mappings in the NERDTree window.

## How can I close NERDTree window after opening a file from it?
Use this NERDTree setting: `let NERDTreeQuitOnOpen = 1`. However if you usually want NERDTree to stay open, but sometimes want it to close after opening a file, you can use one of these option.
1. Use the NERDTree keys: `go` followed by `q`.
1. You can map another key to do `goq` for you: `autocmd FileType nerdtree nmap d goq`

## How can I make sure vim does not open files and other buffers on NerdTree window?

```vim
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
```
If you are using vim-plug, you'll also need to add these lines to avoid crashes when calling vim-plug functions while the cursor is on the NERDTree window: 
```vim
let g:plug_window = 'noautocmd vertical topleft new'
```

## How do I show hidden files?
You can use `I` to toggle the display of dot files (also call hidden files). To display them by default when you start NERDTree, add this line to your .vimrc :
```vim
let NERDTreeShowHidden=1
```