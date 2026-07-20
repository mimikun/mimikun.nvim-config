### Automatic settings, should be turned on/off for debug purposes only

Note: These settings will be removed when the features are deemed stable. 
In most cases they are only here because the automatic detection of Neovim nightly versions does not always work.

#### Autodetect mouse grid

```lua
vim.g.neovide_has_mouse_grid_detection = true
```

**Available since 0.16.0.**

**Requires Neovim 0.12.0.**

Neovim will detect the mouse grid for much better mouse compatibility when enabled. 
This is automaticaly enabled starting from Neovim Nightly September 20. 2025. 
You should not try to enable it manually for unsupported versions, since the behaviour is undefined.

