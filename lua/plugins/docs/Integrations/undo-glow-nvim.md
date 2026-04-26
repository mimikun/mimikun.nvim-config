# Integrations

## y3owk1n/undo-glow.nvim

### gbprod/substitute.nvim

```lua
-- Turn off substitute's highlights
require("substitute").setup({
  highlight_substituted_text = { enabled = false }
})

-- Add undo-glow highlights
vim.keymap.set("n", "s", function()
  require("undo-glow").substitute_action(require("substitute").operator)
end, { desc = "Substitute" })
```

### folke/flash.nvim

```lua
-- Highlight cursor after jumping
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("undo-glow").flash_jump()
end, { desc = "Flash jump" })
```

