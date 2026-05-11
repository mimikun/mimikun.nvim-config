Simple hydra to scroll screen to the side with auto generated hint.

![](https://user-images.githubusercontent.com/13056013/174493857-eb30b9a9-9078-40f8-a076-bc290acc26bf.png)

```lua
local Hydra = require('hydra')

Hydra({
   name = 'Side scroll',
   mode = 'n',
   body = 'z',
   heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = '←/→' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen ←/→' } },
   }
})
```