![Screenshot from 2022-07-17 18-20-53 (01)](https://user-images.githubusercontent.com/13056013/179423921-f4840df2-ebf9-4d87-9f48-b694ac7395a9.png)

Next plugins are required:

- [vim-wordmotion](https://github.com/chaoren/vim-wordmotion)
- [vim-smartword](https://github.com/anuvyklack/vim-smartword)

You just need to install this plugins, no setup is required.
The first plugin makes default word motions more frequent (supports snake_case
and CamelCase). The second plugin make word motions jump only on letters
ignoring all other characters. This hydra makes "submode" for the "quick words".
When you need it, you press `,` + any word motion and all word motions become
"quick" while all other remains the same. Even operator mode is supported, so you can
press `c,w` in normal mode to execute change on "quick word" and simultaneously enter
the "quick words submode". `Esc` exit key is bind only in normal mode, so if you press
it in visual mode, you will return to normal mode, but "quick workds submode" won't be
exited.

```lua
local Hydra = require("hydra")

Hydra({
   name = 'Quick words',
   config = {
      color = 'pink',
      hint = 'statusline',
   },
   mode = {'n','x','o'},
   body = ',',
   heads = {
      { 'w',  '<Plug>(smartword-w)'  },
      { 'b',  '<Plug>(smartword-b)'  },
      { 'e',  '<Plug>(smartword-e)'  },
      { 'ge', '<Plug>(smartword-ge)' },
      { '<Esc>', nil, { exit = true, mode = 'n' } }
   }
})
```
