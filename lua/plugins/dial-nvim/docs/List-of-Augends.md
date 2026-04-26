## List-of-Augends

For simplicity, we define the variable `augend` as follows.

```lua
local augend = require("dial.augend")
```

### `integer`

`n`-based integer (`2 <= n <= 36`). You can use this rule with `augend.integer.new{ ...opts }`.

```lua
require("dial.config").augends:register_group{
  default = {
    -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
    augend.integer.new{
      radix = 16,
      prefix = "0x",
      natural = true,
      case = "upper",
    },
  },
}
```

