# Installation

This guide will walk you through installing nvumi and its dependencies.

## Prerequisites

Before you begin, ensure you have [numi-cli](https://github.com/nikolaeu/numi) installed.

## Installing numi-cli

### macOS
```bash
brew install nikolaeu/numi/numi-cli
```

### Linux & Windows
```bash
curl -sSL https://s.numi.app/cli | sh
```

## Installing nvumi

### Using Lazy.nvim
Add nvumi to your Lazy.nvim configuration:
```lua
{
  "josephburgess/nvumi",
  opts = {
    virtual_text = "newline", -- or "inline"
    prefix = " = ",
    date_format = "iso", -- or "uk", "us", "long"
    keys = {
      run = "<CR>",      -- refresh calculations
      reset = "R",       -- clear buffer and variables
      yank = "<leader>y",   -- yank current evaluation
      yank_all = "<leader>Y", -- yank all evaluations
    },
    custom_conversions = {
      -- Add your custom conversion configurations here
    },
  }
}
```

After adding nvumi to your configuration, restart Neovim and run the command below to open the scratch buffer:
```vim
:Nvumi
```
