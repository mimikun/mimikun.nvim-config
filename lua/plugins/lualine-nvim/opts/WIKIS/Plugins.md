Plugins can provide new components, extensions or themes.

### Currently available plugins
The following is a list of currently available plugins (feel free to add your own!):

| Extension                                                             | Description                                                                    |
|-----------------------------------------------------------------------|--------------------------------------------------------------------------------|
| [lualine-lsp-progress](https://github.com/arkav/lualine-lsp-progress) | statusline component for LSP progress messages |
| [copilot-lualine](https://github.com/AndreM222/copilot-lualine) |  status icon for copilot.lua  |
| [harpoon-lualine](https://github.com/letieu/harpoon-lualine) | see [harpoon](https://github.com/ThePrimeagen/harpoon) status in lualine |



### Plugin folder structure
```
.
├── README.md                    # Readme for your awesome plugin.
└── lua
    └── lualine
        ├── components           # This folder contains the components you want to provide.
        │   ├── component1.lua
        │   └── component2       # you can have a module with multiple files too
        │       ├── init.lua
        │       └── component2_helper.lua
        ├── extensions           # This folder contains the extensions you want to provide.
        │   ├── extensions1.lua
        │   └── extensions2      # you can have a module with multiple files too
        │       ├── init.lua
        │       └── extension2_helper.lua
        └── themes               # This folder contains the themes you want to provide.
            ├── theme1.lua
            └── theme2           # you can have a module with multiple files too
                ├── init.lua
                └── theme2_helper.lua
```
You only need to have the folders that you need. For example if
you want to only provide only one component you will just need to
ensure your component file is in `/lua/lualine/components/` folder.

### Checkout
- [Writting a theme](Writing-a-theme)
