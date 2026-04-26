## Configuration

In this plugin, flexible increment/decrement rules can be set by using **augend** and **group**,
where **augend** represents the target of the increment/decrement operation,
and **group** represents a group of multiple augends.

```lua
local augend = require("dial.augend")
require("dial.config").augends:register_group{
  -- default augends used when no group name is specified
  default = {
    augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
    augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
    augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
  },

  -- augends used when group with name `mygroup` is specified
  mygroup = {
    augend.integer.alias.decimal,
    augend.constant.alias.bool,    -- boolean value (true <-> false)
    augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
  }
}
```

* To define a group, use the `augends:register_group` function in the `"dial.config"` module.
  The arguments is a dictionary whose keys are the group names and whose values are the list of augends.
* Various augends are defined `"dial.augend"` by default.

To specify the group of augends, you can use **expression register** ([`:h @=`](https://neovim.io/doc/user/change.html#quote_=)) as follows:

```
"=mygroup<CR><C-a>
```

If it is tedious to specify the expression register for each operation, you can "map" it:

```vim
nmap <Leader>a "=mygroup<CR><Plug>(dial-increment)
```

Alternatively, you can set the same mapping without expression register:

```lua
vim.keymap.set("n", "<Leader>a", require("dial.map").inc_normal("mygroup"))
```

When you don't specify any group name in the way described above, the addends in the `default` group is used instead.

### Example Configuration

```lua
local augend = require("dial.augend")
require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
  },
  only_in_visual = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
}

-- Use `only_in_visual` group only in VISUAL <C-a> / <C-x>
vim.keymap.set("x", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual", "only_in_visual")
end)
vim.keymap.set("x", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual", "only_in_visual")
end)

require("dial.config").augends:on_filetype {
  typescript = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.constant.new{ elements = {"let", "const"} },
  },
}
```

