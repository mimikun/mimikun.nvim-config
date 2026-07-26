# With Vim/Neovim

First, create `~/vimrc.min` with the following content

```vim
" Disable Vim's native pack feature
set packpath=

" Clone https://github.com/lambdalisue/fern.vim in somewhere
" and specify that directory to the below
set runtimepath^=~/ghq/github.com/lambdalisue/fern.vim

filetype plugin indent on
syntax on
"----------------------------------------------------------------

" Add extra settings here to reproduce the issue...

"----------------------------------------------------------------
echomsg "Custom minimal vimrc has loaded"
```

Then launch Vim/Neovim with

```
vim -N -u ~/vimrc.min
```

```
nvim -u ~/vimrc.min
```

Then add extra settings to reproduce the issue.

# With Docker (Vim)

Create `vimrc` file like

```vim
if has('nvim')
  set runtimepath^=~/.vim
  set runtimepath+=~/.vim/after
  set packpath^=~/.vim
endif

packloadall

filetype plugin indent on
syntax on
"----------------------------------------------------------------

" Add extra settings here to reproduce the issue...

"----------------------------------------------------------------
echomsg "Custom minimal vimrc has loaded"
```

Then create `Dockerfile` like

```Dockerfile
FROM thinca/vim:v8.1.0451

ENV VIMPATH=/root/.vim \
    PACKPATH=/root/.vim/pack/test/start

RUN apk --no-cache add git
RUN git clone https://github.com/lambdalisue/fern.vim $PACKPATH/fern.vim

COPY vimrc /root/.vim/
```

Then build and run the `Dockerfile` like

```
docker build . -t fern-test
docker run --rm -it fern-test
```