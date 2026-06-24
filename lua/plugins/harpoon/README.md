
### Config
There is quite a bit of behavior you can configure via `harpoon:setup()`

* `settings`: is the global settings.  as of now there isn't a global setting in use, but once we have some custom behavior i'll put them here
* `default`: the default configuration for any list.  it is simply a file harpoon
* `[name] = HarpoonPartialConfigItem`: any named lists config.  it will be merged with `default` and override any behavior

**HarpoonPartialConfigItem Definition**
```
---@class HarpoonPartialConfigItem
---@field select_with_nil? boolean defaults to false
---@field encode? (fun(list_item: HarpoonListItem): string) | boolean
---@field decode? (fun(obj: string): any)
---@field display? (fun(list_item: HarpoonListItem): string)
---@field select? (fun(list_item?: HarpoonListItem, list: HarpoonList, options: any?): nil)
---@field equals? (fun(list_line_a: HarpoonListItem, list_line_b: HarpoonListItem): boolean)
---@field create_list_item? fun(config: HarpoonPartialConfigItem, item: any?): HarpoonListItem
---@field BufLeave? fun(evt: any, list: HarpoonList): nil
---@field VimLeavePre? fun(evt: any, list: HarpoonList): nil
---@field get_root_dir? fun(): string
```

**Detailed Definitions**
* `select_with_nil`: allows for a list to call select even if the provided item is nil
* `encode`: how to encode the list item to the harpoon file.  if encode is `false`, then the list will not be saved to disk (think terminals)
* `decode`: how to decode the list
* `display`: how to display the list item in the ui menu
* `select`: the action taken when selecting a list item. called from `list:select(idx, options)`
* `equals`: how to compare two list items for equality
* `create_list_item`: called when `list:add()` or `list:prepend()` is called.  called with an item, which will be a string, when adding through the ui menu
* `BufLeave`: this function is called for every list on BufLeave.  if you need custom behavior, this is the place
* `VimLeavePre`: this function is called for every list on VimLeavePre.
* `get_root_dir`: used for creating relative paths.  defaults to `vim.loop.cwd()`

### Settings
Settings can alter the experience of harpoon

**Definition**
```lua
---@class HarpoonSettings
---@field save_on_toggle boolean defaults to false
---@field sync_on_ui_close boolean defaults to false
---@field key (fun(): string)

```

**Descriptions**
* `save_on_toggle`: any time the ui menu is closed then we will save the state back to the backing list, not to the fs
* `sync_on_ui_close`: any time the ui menu is closed then the state of the list will be sync'd back to the fs
* `key` how the out list key is looked up.  This can be useful when using worktrees and using git remote instead of file path

**Defaults**
```lua
settings = {
    save_on_toggle = false,
    sync_on_ui_close = false,
    key = function()
        return vim.loop.cwd()
    end,
},
```

### Extend
The 'extend' functionality can be used to add keymaps for opening files in splits & tabs.

```lua
harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-t>", function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })
  end,
})
```

### Builtin Extensions
Highlight current file in the harpoon buffer list

```lua
local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
```


