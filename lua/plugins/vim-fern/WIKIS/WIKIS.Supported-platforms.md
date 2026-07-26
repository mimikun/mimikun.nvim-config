# Windows

Supported but

- UNC path is not supported

# macOS

Supported

# Linux

Supported

# BSD

Not sure. While some BSD distribution does not support `-maxdepth` option on `find` command, you may need to overwrite `g:fern#scheme#file#provider#impl` manually like

```vim
let g:fern#scheme#file#provider#impl = 'ls'
```
```vim
let g:fern#scheme#file#provider#impl = 'readdir'
```
```vim
let g:fern#scheme#file#provider#impl = 'glob'
```

https://github.com/lambdalisue/fern.vim/issues/237#issuecomment-703719289