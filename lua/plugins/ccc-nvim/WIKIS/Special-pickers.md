# custom_entries

You can define a table to convert from any word to a specific RGB color.


```lua
local ccc = require("ccc")

ccc.setup({
  pickers = {
    ccc.picker.custom_entries({
      red = "#BF616A",
      green = "#A3BE8C",
      blue = "#81A1C1",
      ……
    })
  },
})
```

<img width="548" alt="スクリーンショット 2023-02-26 19 18 46" src="https://user-images.githubusercontent.com/1239245/221404713-d7acabbd-8587-4869-8c5c-06a933e6faab.png">

# ansi_escape

You can define colors corresponding to ANSI escape code (16 colors).

Note that this picker is only used for highlights. The reason is that foreground and background colors can be set at the same time, and the color to be picked cannot be determined.

```lua
local ccc = require("ccc")

ccc.setup({
  pickers = {
    -- Default colors came from Campbell (WindowsTerminal)
    ccc.picker.ansi_escape()
  }
})
```

![image](https://user-images.githubusercontent.com/82267684/234368642-980b93fd-4fa4-45e0-b8d2-5da411954906.png)
