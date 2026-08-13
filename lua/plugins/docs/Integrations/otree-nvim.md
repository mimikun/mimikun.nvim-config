# Integrations

## Eutrius/Otree.nvim

### stevearc/oil.nvim

#### Automatic Configuration

If `oil.nvim` is installed but not already configured, Otree will automatically set it up with these optimized defaults:

```lua
require("oil").setup({
    default_file_explorer = false,
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    cleanup_delay_ms = false,
})
```

If Oil is already configured, Otree respects your existing setup and will not override any settings.
