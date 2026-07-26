## Please share your screenshot/screencast !

#### With some custom symbols

![](https://user-images.githubusercontent.com/546312/92318773-f1a5eb80-efc5-11ea-8e39-e2d4d7dba260.png)

```vim
let g:fern#renderer#default#leading = "│"
let g:fern#renderer#default#root_symbol = "┬ "
let g:fern#renderer#default#leaf_symbol = "├─ "
let g:fern#renderer#default#collapsed_symbol = "├─ "
let g:fern#renderer#default#expanded_symbol = "├┬ "
```

#### fern.vim + fern-renderer-nerdfont.vim + nerdfont.vim + glyph-palette.vim by @lambdalisue
![](https://user-images.githubusercontent.com/546312/89217137-9e2b3100-d606-11ea-872f-f6c9dcbe2c93.png)

- https://github.com/lambdalisue/fern-renderer-nerdfont.vim
- https://github.com/lambdalisue/nerdfont.vim
- https://github.com/lambdalisue/glyph-palette.vim

#### fern.vim with user customization to make it look like a vimfiler by @bluz71
https://github.com/lambdalisue/fern.vim/issues/127#issuecomment-667813042
https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html#fernvim

![](https://user-images.githubusercontent.com/11382509/89149076-e57dd700-d59e-11ea-9895-999900c1ce9a.png)

```vim
let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '
```

#### vim-fern with a [custom nerdfont renderer](https://github.com/brandon1024/fern-renderer-nf.vim) by @brandon1024

![image](https://github.com/user-attachments/assets/41d73526-9d67-4909-96c3-62335ce0d2f7)

- [brandon1024/.dotfiles](https://github.com/brandon1024/.dotfiles/blob/master/.vim/pack/config/opt/plugins/plugin/vim-fern.vim)