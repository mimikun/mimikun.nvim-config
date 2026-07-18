A common question may be how to try this out without conflicting with `coc-metals`. That's a valid concern, and one that I also have since I maintain both. I don't want to have to disable and enable all the time. The following is what I do to allow me to have both exist and to simply choose which I'm using by how I start nvim.

Firstly, depending on what I'm using, I start nvim in different ways using aliases. I have the following:

```sh
alias vc="nvim --cmd 'let coc=1'"
alias vn="nvim --cmd 'let vnative=1'"
``` 
Then in my plug file I have the following:

```vim
if exists("vnative") && has("nvim")
  Plug 'neovim/nvim-lsp'
  Plug 'ckipp01/nvim-metals'
  Plug 'haorenW1025/completion-nvim'
  Plug 'haorenW1025/diagnostic-nvim'
else
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
endif
```
This will only load the the `coc.nvim` related plugins if I start nvim via `vc`, and the built-in related ones if I use `vn`. I also do the same thing for my configuration files. Instead of including everything in one file, I include my `coc-metals` mappings in one file, and my `nvim-metals` once in another and source them from my `.vimrc` like below:

```vim
if exists("vnative")
  if filereadable(expand("~/.flavor/nvim-lsp-mappings.vim"))
    source ~/.flavor/nvim-lsp-mappings.vim
  endif
elseif exists("coc")
  if filereadable(expand("~/.flavor/coc-mappings.vim"))
    source ~/.flavor/coc-mappings.vim
  endif
endif
```

Again, this will only load up the relevant mappings needed for each plugin depending on how I start nvim.

Hope this helps!

