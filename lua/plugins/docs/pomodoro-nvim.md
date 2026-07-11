## Recipes

### Lualine — drop-in

```lua
require("lualine").setup({
  sections = {
    lualine_x = {
      function()
        return require("pomodoro.statusline").component()
      end,
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})
```

### Lualine — colored by phase

```lua
local function pomo()
  local s = require("pomodoro.statusline").component_lualine()
  if s.text == "" then
    return ""
  end
  return "%#" .. s.hl .. "#" .. s.text
end

require("lualine").setup({
  sections = {
    lualine_x = {
      pomo,
      "filetype",
    },
  },
})
```

### Native statusline (no plugin)

```lua
vim.o.statusline = "%f %m %= %{v:lua.require('pomodoro').statusline()} "
```

### System notification on break (macOS)

```lua
require("pomodoro").setup({
  hooks = {
    on_break_start = function(p)
      vim.fn.jobstart({
        "terminal-notifier",
        "-title",
        "Pomodoro",
        "-message",
        "Break time — " .. p.duration_min .. " min",
        "-sound",
        "Glass",
      })
    end,
  },
})
```

### System notification on break (Linux)

```lua
require("pomodoro").setup({
  hooks = {
    on_break_start = function(p)
      vim.fn.jobstart({
        "notify-send",
        "Pomodoro",
        "Break — " .. p.duration_min .. " min",
      })
    end,
  },
})
```

### Lock yourself out of distractions while working

```lua
require("pomodoro").setup({
  focus = {
    enabled = true,
    blocked_commands = {
      "Lazy",
      "Mason",
      "Telescope",
    },
    silent_diagnostics = true,
    -- dim non-current windows during work
    dim_inactive = true,
  },
})
```

### Ding when a phase ends

```lua
require("pomodoro").setup({
  sound = {
    -- macOS: system sound via afplay
    enabled = true,
    -- Linux; and belows
    --cmd = {
    --  "paplay",
    --  "/usr/share/sounds/freedesktop/stereo/complete.oga",
    --},
  },
})
```

## FAQ

### How do I turn persistence off, or move the stats file?

```lua
require("pomodoro").setup({
  persistence = {
    -- keep stats in memory only
    enabled = false,
    -- or:
    --path = vim.fn.expand("~/notes/pomodoro.json"),
  },
})
```

