# Integrations

## amansingh-afk/milli.nvim

Pick your dashboard plugin. Each preset (`dashboard`, `alpha`, `snacks`, `starter`, `vimenter`) works identically with bundled or custom splashes.

### my origina splash

```lua
require("milli").dashboard({ splash = "corona", loop = true })
```

### nvimdev/dashboard-nvim

```lua
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "amansingh-afk/milli.nvim" },
  opts = function()
    local splash = require("milli").load({ splash = "finger" })
    return {
      theme = "doom",
      config = {
        header = splash.frames[1],         -- seed header with frame 0
        center = {
          { icon = "  ", desc = "Find File", key = "f", action = "Telescope find_files" },
          { icon = "  ", desc = "Quit",      key = "q", action = "qa" },
        },
      },
    }
  end,
  config = function(_, opts)
    require("dashboard").setup(opts)
    require("milli").dashboard({ splash = "finger", loop = true })
  end,
}
```

### goolord/alpha-nvim

```lua
require("milli").alpha({ splash = "fire", loop = true })
```

### folke/snacks.nvim

```lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = { "amansingh-afk/milli.nvim" },
  opts = function()
    local splash = require("milli").load({ splash = "fire" })
    return {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat(splash.frames[1], "\n"),
        },
        sections = {
          { section = "header", padding = 1 },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    }
  end,
  config = function(_, opts)
    require("snacks").setup(opts)
    require("milli").snacks({ splash = "fire", loop = true })
  end,
}
```

`preset.header` seeds frame 0 of the splash as snacks's default header so milli's anchor-search can locate the buffer position to animate over. 
The splash name in `preset.header` and in `require("milli").snacks({ splash = ... })` must match.

### nvim-mini/mini.starter

```lua
require("milli").starter({ splash = "fire", loop = true })
```

### No plugin (raw VimEnter)

```lua
require("milli").vimenter({ splash = "fire", loop = true })
```

