### lualine Setup

```lua
{
-- optional lualine component to show captured events when the profiler is running
  "nvim-lualine/lualine.nvim",
  --deps="folke/snacks.nvim",
  --local Snacks = require("snacks")
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, Snacks.profiler.status())
  end,
}
```

### Profiling Neovim Startup

In order to profile Neovim's startup, you need to make sure `snacks.nvim` is
installed and loaded **before** doing anything else. So also before loading
your plugin manager.

You can add something like the below to the top of your `init.lua`.

Then you can profile your Neovim session, with `PROF=1 nvim`.

```lua
if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end
```

