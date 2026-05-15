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
