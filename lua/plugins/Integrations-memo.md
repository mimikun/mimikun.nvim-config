## API

```lua
local glimmer = require("tiny-glimmer")

-- Control plugin state
glimmer.enable()   -- Enable animations
glimmer.disable()  -- Disable animations
glimmer.toggle()   -- Toggle animations on/off

-- Change animation highlights dynamically
-- @param animation_name string|string[] - Animation name(s) or "all"
-- @param hl table - Highlight configuration { from_color = "...", to_color = "..." }
glimmer.change_hl("fade", { from_color = "#FF0000", to_color = "#0000FF" })
glimmer.change_hl("all", { from_color = "#FF0000", to_color = "#0000FF" })
glimmer.change_hl({"fade", "pulse"}, { from_color = "#FF0000", to_color = "#0000FF" })

-- Search operations (when overwrite.search.enabled = true)
glimmer.search_next()          -- Same as "n"
glimmer.search_prev()          -- Same as "N"
glimmer.search_under_cursor()  -- Same as "*"

-- Paste operations (when overwrite.paste.enabled = true)
glimmer.paste()   -- Same as "p"
glimmer.Paste()   -- Same as "P"

-- Undo/redo operations (when undo/redo.enabled = true)
glimmer.undo()    -- Undo changes
glimmer.redo()    -- Redo changes

-- Refresh highlights after theme change
glimmer.apply()   -- Recompute cached highlights for current colorscheme
```

Keybinding examples:

```lua
vim.keymap.set("n", "<leader>ge", "<cmd>TinyGlimmer enable<cr>", { desc = "Enable animations" })
vim.keymap.set("n", "<leader>gd", "<cmd>TinyGlimmer disable<cr>", { desc = "Disable animations" })
vim.keymap.set("n", "<leader>gt", "<cmd>TinyGlimmer fade<cr>", { desc = "Switch to fade" })
```

## Integrations

### gbprod/substitute.nvim

Add animation support to the substitute plugin:

```lua
{
    "gbprod/substitute.nvim",
    dependencies = { "rachartier/tiny-glimmer.nvim" },
    config = function()
        require("substitute").setup({
            on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
            highlight_substituted_text = {
                enabled = false,  -- Disable built-in highlight
            },
        })
    end,
}
```

