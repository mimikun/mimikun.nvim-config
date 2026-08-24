# project.nvim

## Configuration

> [!IMPORTANT]
> Make sure to put your pattern exclusions first, and then the patterns you DO want included.
>
> Also if you have `lsp.use_pattern_matching` enabled, it will also work somewhat for your LSP clients.

### Lualine

You can add the `project.nvim` component to your statusline using `lualine.nvim`:

```lua
lualine_b = {
  {
    "project",

    -- Can be:
    -- - `'short'`         - Only shows the basename of the project root directory
    -- - `'full'`          - Shows the full path but without expanding the home directory
    -- - `'full_expanded'` - Shows the full, expanded path
    -- - `'name'`          - (default) Will show the current project's name. ONLY WORKS IF HISTORY
    --                       HAS BEEN MIGRATED, OTHERWISE `'short'` WILL BE USED
    format = 'name',

    -- Text to display when no project root is found (set to `nil` or empty string to disable)
    no_project = 'N/A',

    -- The separator
    separator = " ",

    -- Optional table of two strings set as enclosing characters.
    -- Set to `nil` to disable it
    --
    -- e.g. `enclose_pair = { '(', ')' }` ==> `(<YOUR_PROJECT>)`
    --      `enclose_pair = { '<', ']' }` ==> `<<YOUR_PROJECT>]`
    --      `enclose_pair = { nil, 'a' }` ==> `<YOUR_PROJECT>a`
    enclose_pair = nil,
  }
}
```

### Nvim Tree

Make sure these flags are enabled to support [`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua):

```lua
require('nvim-tree').setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})
```

### Neo Tree

You can use `:Neotree filesystem ...` when changing a project:

```lua
vim.keymap.set('n', '<YOUR-TOGGLE-MAP>', ':Neotree filesystem toggle reveal_force_cwd<CR>', opts)
vim.keymap.set('n', '<YOUR-SHOW-MAP>', ':Neotree filesystem show reveal_force_cwd<CR>', opts)
vim.keymap.set('n', '<YOUR-FLOAT-MAP>', ':Neotree filesystem float reveal_force_cwd<CR>', opts)
-- ... and so on
```

### Telescope

To enable [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) integration use the following
code in your config:

```lua
require('telescope').setup()
require('telescope').load_extension('projects')
```

After that you can now call it from the command line:

```vim
:Telescope projects
```

You can also configure the picker when calling `require('telescope').setup()`. **CREDITS**: [@ldfwbebp](https://github.com/ahmedkhalf/project.nvim/pull/160)

```lua
require('telescope').setup({
  extensions = {
    projects = {
      prompt_prefix = "󱎸  ",
      layout_strategy = "horizontal",
      layout_config = {
        anchor = "N",
        height = 0.25,
        width = 0.6,
        prompt_position = "bottom",
      },
    },
  },
})
```

#### Telescope Mappings

`project.nvim` comes with the following mappings for Telescope:

| Normal Mode | Insert Mode | Action                     |
|-------------|-------------|----------------------------|
| `b`         | `<C-b>`     | `browse_project_files`     |
| `d`         | `<C-d>`     | `delete_project`           |
| `f`         | `<C-f>`     | `find_project_files`       |
| `n`         | `<C-n>`     | `rename_project`           |
| `r`         | `<C-r>`     | `recent_project_files`     |
| `s`         | `<C-s>`     | `search_in_project_files`  |
| `w`         | `<C-w>`     | `change_cwd`               |

_You can find the Actions in [`telescope/_extensions/projects/actions.lua`](https://github.com/DrKJeff16/project.nvim/blob/main/lua/telescope/_extensions/projects/actions.lua)_.

---

### `mini.starter`

If you use [`nvim-mini/mini.starter`](https://github.com/nvim-mini/mini.starter) you can include the following snippet in your `MiniStarter` setup:

```lua
require('mini.starter').setup({
  evaluate_single = true,
  items = {
    { name = 'Projects', action = 'Project', section = 'Projects' }, -- Runs `:Project`
    { name = 'Recent Projects', action = 'Project recents', section = 'Projects' }, -- `:Project recents`
    -- Other items...
  },
})
```

### `picker.nvim`

This plugin has a custom integration with [@wsdjeg](https://github.com/wsdjeg)'s [`picker.nvim`](https://github.com/wsdjeg/picker.nvim).
If enabled, the `:Project picker` command will be available to you.

To enable it you'll need the plugin installed, then in your setup:

```lua
require('project').setup({
  picker = {
    enabled = true,

    -- 'newest' or 'oldest'
    sort = 'newest',

    -- Show hidden files
    hidden = false,
  }
})
```

Mappings:

| Normal Mode | Description                                           |
| ----------- | ----------------------------------------------------- |
| `<C-d>`     | Delete selected project(s) (`<Tab>` to mark multiple) |
| `<C-r>`     | Rename the selected project                           |
| `<C-w>`     | Changes the cwd to the selected project               |

You can find the integration in:

- [_`picker/sources/project.lua`_](https://github.com/DrKJeff16/project.nvim/blob/main/lua/picker/sources/project.lua).
- [_`extensions/picker.lua`_](https://github.com/DrKJeff16/project.nvim/blob/main/lua/project/extensions/picker.lua)

### `snacks.nvim`

This plugin has a custom integration with [`snacks.nvim`](https://github.com/folke/snacks.nvim).
If enabled, the `:Project snacks` command will be available to you.

```lua
require('project.extensions.snacks').pick()
```

To enable and configure it you'll need the plugin installed, then in your setup:

```lua
require('project').setup({
  snacks = {
    -- Will enable the `:Project snacks` command
    enabled = true,
    opts = {
      sort = 'newest',
      hidden = false,
      title = 'Select Project',
      layout = 'select',
      -- icon = {},
      -- path_icons = {},
    },
  },
})
```

Mappings:

| Normal Mode | Description                                           |
| ----------- | ----------------------------------------------------- |
| `<C-d>`     | Delete selected project(s) (`<Tab>` to mark multiple) |
| `<C-r>`     | Rename the selected project                           |
| `<C-w>`     | Changes the cwd to the selected project               |

You can find the integration in [_`extensions/snacks.lua`_](https://github.com/DrKJeff16/project.nvim/blob/main/lua/project/extensions/snacks.lua).

`project.nvim` comes with a `vim-rooter`-inspired pattern matching expression engine
to give you better handling of your projects.

For your convenience here come some use cases:
