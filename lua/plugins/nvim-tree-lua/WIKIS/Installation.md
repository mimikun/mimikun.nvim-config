# Plugins

Required

* `nvim-tree/nvim-tree.lua`

Recommended

* `nvim-tree/nvim-web-devicons` file icons 

Optional

* [Integrations](./Integrations-And-Extension-Plugins#integrations)
* [Extension Plugins](./Integrations-And-Extension-Plugins#extension-plugins)
* [Color Schemes](./Integrations-And-Extension-Plugins#color-schemes)

## Neovim Plugin Manager

Please add your preferred plugin manager.

### [vim.pack](https://neovim.io/doc/user/pack.html#vim.pack) - Neovim 0.12+ Native Plugin Manager - Preferred
```lua
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' }, -- optional
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
```

### [lazy](https://github.com/folke/lazy.nvim.git)

Importing file below or directory it is contained on lazy setup.
```lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}
```

## Operating System Package

Ensure that your neovim plugin manager is not managing these plugins.

### [Arch Linux](https://archlinux.org/)

* [neovim-tree-lua-git](https://aur.archlinux.org/packages/neovim-tree-lua-git)
* [neovim-web-devicons-git](https://aur.archlinux.org/packages/neovim-web-devicons-git) (optional)

# Lazy Loading

Lazy loading is not recommended.

nvim-tree `setup` is very inexpensive, doing little more than validating and setting configuration. There's no performance benefit for lazy loading.

Lazy loading can be problematic due to the somewhat nondeterministic startup order of plugins, session managers, netrw, `"VimEnter"` event etc.

# Older neovim Versions

If you cannot use the required version of nvim-tree you may use an older version via tag:

* `compat-nvim-0.9`
* `compat-nvim-0.8`
* `compat-nvim-0.7`
* `compat-nvim-0.6`

Please note that these compatibility versions are not maintained or updated.

