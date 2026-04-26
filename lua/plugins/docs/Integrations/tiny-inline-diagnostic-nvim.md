# Integrations

## rachartier/tiny-inline-diagnostic.nvim

### folke/sidekick.nvim

The plugin integrates with [sidekick.nvim](https://github.com/folke/sidekick.nvim) to automatically disable diagnostics when the sidekick NES is shown and re-enable them when hidden. This prevents visual clutter...

```lua
local disabled = false
return {
  {
    "folke/sidekick.nvim",
    opts = { nes = { enabled = true } },
    config = function(_, opts)
      require("sidekick").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "SidekickNesHide",
        callback = function()
          if disabled then
            disabled = false
            require("tiny-inline-diagnostic").enable()
          end
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "SidekickNesShow",
        callback = function()
          disabled = true
          require("tiny-inline-diagnostic").disable()
        end,
      })
    end,
  },
}
```

This setup listens for `SidekickNesShow` and `SidekickNesHide` events to toggle the diagnostics accordingly.

