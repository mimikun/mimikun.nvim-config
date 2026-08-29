### which-key Integration

If you use [which-key.nvim](https://github.com/folke/which-key.nvim), you can group the keys:

```lua
local wk = require('which-key')
wk.add({
  { '<leader>c', group = 'Camouflage' },
})
```
