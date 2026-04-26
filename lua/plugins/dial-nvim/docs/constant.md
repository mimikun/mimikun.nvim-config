## `constant`

Predefined sequence of strings. You can use this rule with `augend.constant.new{ ...opts }`.

```lua
require("dial.config").augends:register_group{
  default = {
    -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
    augend.constant.new{
      elements = {"and", "or"},
      word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
      cyclic = true,  -- "or" is incremented into "and".
    },
    augend.constant.new{
      elements = {"&&", "||"},
      word = false,
      cyclic = true,
    },
  },
}
```

### `hexcolor`

RGB color code such as `#000000` and `#ffffff`.

```lua
require("dial.config").augends:register_group{
  default = {
    -- hex colors (e.g. #1A1A1A, #EEFEFE, etc.)
    augend.hexcolor.new{
      case = "upper", -- or "lower", "prefer_upper", "prefer_lower", see below
    },
  },
}
```

Supported options for `case` are:

* `upper`: use uppercase letters `A`-`F`
* `lower`: use lowercase letters `a`-`f`
* `prefer_upper`: try to keep the case, use uppercase as fallback
  * `#0a1bfe` will be incremented to `#0b1cff` (keep existing case)
  * `#0A1BFE` will be incremented to `#0B1CFF` (keep existing case)
  * `#059799` will be incremented to `#06989A` (no letter, use uppercase)
  * `#0a1BFf` will be incremented to `#0B1CFF` (mixed casing, use uppercase)
* `prefer_lower`: try to keep the case, use lowercase as fallback
  * `#0a1bfe` will be incremented to `#0b1cff` (keep existing case)
  * `#0A1BFE` will be incremented to `#0B1CFF` (keep existing case)
  * `#059799` will be incremented to `#06989a` (no letter, use lowercase)
  * `#0a1BFf` will be incremented to `#0b1cff` (mixed casing, use lowercase)

### `semver`

Semantic versions. You can use this rule by augend alias described below.

It differs from a simple nonnegative integer increment/decrement in these ways:

* When the cursor is before the semver string, the patch version is incremented.
* When the minor version is incremented, the patch version is reset to zero.
* When the major version is incremented, the minor and patch versions are reset to zero.

### `user`

Custom augends.

```lua
require("dial.config").augends:register_group{
  default = {
    -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
    augend.user.new{
      find = require("dial.augend.common").find_pattern("%d+"),
      add = function(text, addend, cursor)
          local n = tonumber(text)
          n = math.floor(n * (2 ^ addend))
          text = tostring(n)
          cursor = #text
          return {text = text, cursor = cursor}
      end
    },
  },
}
```

