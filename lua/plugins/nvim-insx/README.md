
```lua
require('insx.preset.standard').setup()
```

#### Recipe

```lua
local insx = require('insx')

insx.add(
  "'",
  insx.with(require('insx.recipe.auto_pair')({
    open = "'",
    close = "'"
  }), {
    insx.with.in_string(false),
    insx.with.in_comment(false),
    insx.with.nomatch([[\\\%#]]),
    insx.with.nomatch([[\a\%#]])
  })
)
```
