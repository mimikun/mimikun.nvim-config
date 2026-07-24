Welcome to the NERDTree Wiki!

Feel free to contribute any tips you have learned while using NERDTree.

# Starting NERDTree
## Suppress starting NERDTree if this is a quickfix

### Background

I noticed that some of the snippets used `if &buftype != 'quickfix' lalala`, but for some reason, this doesn't work. Even `:set buftype?` after starting a quickfix (`vim -q errorfile`), it didn't return a value.

So I nosed around and found this construct, which gets us a list of command line options -- and the next line, which is 0 or 1 depending on whether `-q` was thrown on the command line:

```vimscript
let s:options = split(system("ps -o command= -p " . getpid()))
let s:q_opt = count(s:options, '-q')
```

### Quickfix and NERDTree

So if you start vim with any of the usual snippets of code, but enter quickfix mode: `vim -q errorfile`, you wind up with:

* the error file as requested
* NERDTree started, which for quickfix operations is less desirable
* the cursor in the NERDTree, which is _really_ less than desirable
* the first error on the list missing. Sure, you can use `:cc` to get at it, but fingers are tired.

The code to end this misery is:
```vimscript
autocmd StdinReadPre * let s:std_in=1
" kludgy way of getting the command line:
let s:options = split(system("ps -o command= -p " . getpid()))
let s:q_opt = count(s:options, '-q')

" Start NERDTree. If a file is specified, move the cursor to its window.
" Do not start NERDTree if this is a quickfix operation.
autocmd VimEnter * if s:q_opt == 0 | NERDTree | endif | if argc() > 0 || exists("s:std_in") | wincmd p | endif
```

Credits
---
[Vimscripts: check if item in list](https://vi.stackexchange.com/questions/27232/vimscripts-check-if-item-in-list) For the `count(g:foo, a:bar)` idea

[Is it possible to access vim's command-line arguments in vimscript?](https://stackoverflow.com/questions/10357374/is-it-possible-to-access-vims-command-line-arguments-in-vimscript) For the `split(system("ps...` idea for getting at command line options