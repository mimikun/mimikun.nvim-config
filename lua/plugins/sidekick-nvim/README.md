
### Snacks.nvim Picker Integration

#### folke/snacks.nvim

```lua
{
  "folke/snacks.nvim",
  optional = true,
  opts = {
    picker = {
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
  },
}
```

#### Example of how to override the default keymaps

```lua
{
  "folke/sidekick.nvim",
  opts = {
    cli = {
      win = {
        keys = {
          -- override the default hide keymap
          hide_n = { "<leader>q", "hide", mode = "n" },
          -- add a new keymap to say hi
          say_hi = {
            "<c-h>",
            function(t)
              t:send("hi!")
            end,
          },
        },
      },
    },
  },
}
```

## 📟 Statusline Integration

Using the `require("sidekick.status")` API, you can easily integrate **Copilot LSP** and **CLI sessions** in your statusline.

### nvim-lualine/lualine.nvim

```lua
{
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections = opts.sections or {}
    opts.sections.lualine_c = opts.sections.lualine_c or {}

    -- Copilot status
    table.insert(opts.sections.lualine_c, {
      function()
        return " "
      end,
      color = function()
        local status = require("sidekick.status").get()
        if status then
          return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
        end
      end,
      cond = function()
        local status = require("sidekick.status")
        return status.get() ~= nil
      end,
    })

    -- CLI session status
    table.insert(opts.sections.lualine_x, 2, {
      function()
        local status = require("sidekick.status").cli()
        return " " .. (#status > 1 and #status or "")
      end,
      cond = function()
        return #require("sidekick.status").cli() > 0
      end,
      color = function()
        return "Special"
      end,
    })
  end,
}
```

## ❓ FAQ

### Terminal sessions not persisting?

Make sure you have tmux or zellij installed and enable the multiplexer:

```lua
opts = {
  cli = {
    mux = {
      enabled = true,
      backend = "tmux", -- or "zellij"
    },
  },
}
```

### Can I use this without NES, just for CLI tools?

Absolutely! Just disable NES:

```lua
opts = {
  nes = { enabled = false },
}
```

### How do I create custom prompts?

Add them to your config:

```lua
opts = {
  cli = {
    prompts = {
      refactor = "Please refactor {this} to be more maintainable",
      security = "Review {file} for security vulnerabilities",
      custom = function(ctx)
        return "Current file: " .. ctx.buf .. " at line " .. ctx.row
      end,
    },
  },
}
```


## ???

-- use: https://github.com/github/copilot-language-server-release by
-- https://github.com/mason-org/mason-lspconfig.nvim

## Integrations

### saghen/blink.cmp

insert mode with blink.cmp

```lua
{
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    keymap = {
      ["<Tab>"] = {
        "snippet_forward",
        function() -- sidekick next edit suggestion
          return require("sidekick").nes_jump_or_apply()
        end,
        function() -- if you are using Neovim's native inline completions
          return vim.lsp.inline_completion.get()
        end,
        "fallback",
      },
    },
  },
}
```

### Custom Tab integration for insert mode

```lua
{
  "folke/sidekick.nvim",
  opts = {
    -- add any options here
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if require("sidekick").nes_jump_or_apply() then
          return -- jumped or applied
        end

        -- if you are using Neovim's native inline completions
        if vim.lsp.inline_completion.get() then
          return
        end

        -- any other things (like snippets) you want to do on <tab> go here.

        -- fall back to normal tab
        return "<tab>"
      end,
      mode = { "i", "n" },
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
  },
}
```



