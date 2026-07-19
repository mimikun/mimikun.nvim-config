## ⚙ Default Configuration

```lua
{
  enable_on = { "html" },
  handlers = {
    definition = {
      bind = "gd"
    },
    hover = {
      bind = "K",
      wrap = true,
      border = "none",
      position = "cursor",
    }
  },
  documentation = {
    auto_show = true,
  },
  peek = {
    enabled = true,
    border = "rounded",
    position = "center", -- "center" | "cursor"
    width = 0.5,         -- fraction of editor width (0.0–1.0)
    height = 0.5,        -- fraction of editor height (0.0–1.0)
    focus = true,        -- whether the float steals focus on open
    style = "minimal",
  },
  style_sheets = {}
}
```

## 🔧 Project-Specific Configuration

You can set project-specific configurations using a `.nvim.lua` file in your project root. This allows you to have different settings for each project without modifying your global Neovim configuration.

### Setup

Create a `.nvim.lua` file in your project root directory and add the following:

```lua
-- Project-specific HTML/CSS configuration
vim.g.html_css = {
  enable_on = { "html", "jsx" },  -- File types for this project only
  handlers = {
    definition = {
      bind = "gd"
    },
    hover = {
      bind = "K",
      wrap = true,
      border = "none",
      position = "cursor",
    }
  },
  documentation = {
    auto_show = true,
  },
  peek = {
    enabled = true,
    position = "cursor",
  },
  style_sheets = {
    -- Project-specific stylesheets
    "./src/styles/main.css",
    "./src/styles/components.css",
    "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css",
  }
}
```

The plugin will automatically detect and apply these settings when working within this project. This is particularly useful for:

- Adding project-specific stylesheets
- Enabling the plugin for project-specific file types
- Customizing documentation behavior for a specific project

### Priority

Project-specific configurations take precedence over global settings, allowing you to override any global configuration options on a per-project basis.

## ⌨️ Keybindings

### Go to Definition

The default key binding for Go to Definition functionality is set to `gd`. If a class or ID is not found, it automatically falls back to the LSP definition using vim.lsp.buf.definition(). This allows for seamless navigation between your custom HTML/CSS definitions and LSP-managed definitions.

### Hover functionality

The default key binding for the hover functionality is set to `K`. If a class or ID is not found, it automatically falls back to the LSP hover using vim.lsp.buf.hover(). This enables quick access to your custom HTML/CSS definitions alongside standard LSP information for a seamless development experience.

### Peek

Peek opens the CSS source file in a floating window directly at the definition of the class or ID under your cursor, without leaving your current buffer. The file is fully editable — if you have unsaved changes, the window will refuse to close until you save or discard them.

The plugin exposes a `:HtmlCssPeek` command. Bind it however you like in your own config:

```lua
vim.keymap.set("n", "<leader>cp", "<cmd>HtmlCssPeek<CR>", { desc = "Peek CSS source" })
```

Inside the peek window the following keys are available:

| Key     | Action      |
| ------- | ----------- |
| `q`     | Close float |
| `<Esc>` | Close float |

