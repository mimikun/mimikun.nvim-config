### Picker Options

You can define default configurations for the pickers opened by `zk-nvim`,
allowing you to apply a specific theme or layout for `zk-nvim`. This works for
all supported pickers, but you'll need to refer to the relevant configuration
options for each picker.

```lua
require("zk").setup({
    picker_options = {
        telescope = require("telescope.themes").get_ivy(),

        -- or if you use snacks picker

        snacks_picker = {
            layout = {
                preset = "ivy",
            }
        },
    },
    ...
})
```



---

**Via Lua**

You can access the underlying Lua function of a command, with
`require("zk.commands").get`.

_Examples:_

```lua
require("zk.commands").get("ZkNew")({ dir = "daily" })
require("zk.commands").get("ZkNotes")({ createdAfter = "3 days ago", tags = { "work" } })
require("zk.commands").get("ZkNewFromTitleSelection")()
```

## Custom Commands

```lua
---A thin wrapper around `vim.api.nvim_add_user_command` which parses the `params.args` of the command as a Lua table and passes it on to `fn`.
---@param name string
---@param fn function
---@param opts? table {needs_selection} makes sure the command is called with a range
---@see vim.api.nvim_add_user_command
require("zk.commands").add(name, fn, opts)
```

_Example 1:_

Let us add a custom `:ZkOrphans` command that will list all notes that are
orphans, i.e. not referenced by any other note.

```lua
local zk = require("zk")
local commands = require("zk.commands")

commands.add("ZkOrphans", function(options)
  options = vim.tbl_extend("force", { orphan = true }, options or {})
  zk.edit(options, { title = "Zk Orphans" })
end)
```

This adds the `:ZkOrphans [{options}]` vim user command, which accepts an
`options` Lua table as an argument. We can execute it like this
`:ZkOrphans { tags = { "work" } }` for example.

> Note: The `zk.edit` function is from the [high-level API](#high-level-api),
> which also contains other functions that might be useful for your custom
> commands.

_Example 2:_

Chances are that this will not be our only custom command following this
pattern. So let's also add a `:ZkRecents` command and make the pattern a bit
more reusable.

```lua
local zk = require("zk")
local commands = require("zk.commands")

local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))
```

## High-level API

The high-level API is inspired by the commands provided by the `zk` CLI tool;
see `zk --help`. It's mainly used for the implementation of built-in and custom
commands.

```lua
---Cd into the notebook root
--
---@param options? table
require("zk").cd(options)
```

```lua
---Creates and edits a new note
--
---@param options? table additional options
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zknew
require("zk").new(options)
```

```lua
---Indexes the notebook
--
---@param options? table additional options
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zkindex
require("zk").index(options)
```

```lua
---Opens a notes picker, and calls the callback with the selection
--
---@param options? table additional options
---@param picker_options? table options for the picker
---@param cb function
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zklist
---@see zk.ui.pick_notes
require("zk").pick_notes(options, picker_options, cb)
```

```lua
---Opens a tags picker, and calls the callback with the selection
--
---@param options? table additional options
---@param picker_options? table options for the picker
---@param cb function
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zktaglist
---@see zk.ui.pick_tags
require("zk").pick_tags(options, picker_options, cb)
```

```lua
---Opens a notes picker, and edits the selected notes
--
---@param options? table additional options
---@param picker_options? table options for the picker
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zklist
---@see zk.ui.pick_notes
require("zk").edit(options, picker_options)
```

## API

The functions in the API module give you maximum flexibility and provide only a
thin Lua friendly layer around `zk`'s LSP API. You can use it to write your own
specialized functions for interacting with `zk`.

```lua
---@param path? string path to explicitly specify the notebook
---@param options? table additional options
---@param cb function callback function
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zkindex
require("zk.api").index(path, options, function(err, stats)
  -- do something with the stats
end)
```

```lua
---@param path? string path to explicitly specify the notebook
---@param options? table additional options
---@param cb function callback function
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zknew
require("zk.api").new(path, options, function(err, res)
  file_path = res.path
  -- do something with the new file path
end)
```

```lua
---@param path? string path to explicitly specify the notebook
---@param options table additional options
---@param cb function callback function
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zklist
require("zk.api").list(path, options, function(err, notes)
  -- do something with the notes
end)
```

```lua
---@param path? string path to explicitly specify the notebook
---@param options? table additional options
---@param cb function callback function
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zktaglist
require("zk.api").tag.list(path, options, function(err, tags)
  -- do something with the tags
end)
```

## Pickers

Used by the [high-level API](#high-level-api) to display the results of the
[API](#api).

```lua
---Opens a notes picker
--
---@param notes list
---@param options? table containing {picker}, {title}, {multi_select} keys
---@param cb function
require("zk.ui").pick_notes(notes, options, cb)
```

```lua
---Opens a tags picker
--
---@param tags list
---@param options? table containing {picker}, {title}, {multi_select} keys
---@param cb function
require("zk.ui").pick_tags(tags, options, cb)
```

```lua
---To be used in zk.api.list as the `selection` in the additional options table
--
---@param options table the same options that are use for pick_notes
---@return table api selection
require("zk.ui").get_pick_notes_list_api_selection(options)
```

## Example Mappings

Add these global mappings in your main Neovim config:

```lua
local opts = { noremap=true, silent=false }

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
```

You can add additional key mappings for Markdown buffers located in a `zk`
notebook, using `ftplugin`. First, make sure it is enabled in your Neovim
config:

```viml
filetype plugin on
```

Then, create a new file under `~/.config/nvim/ftplugin/markdown.lua` to setup
the mappings:

```lua
-- Add the key mappings only for Markdown files in a zk notebook.
if 
    require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) 
        vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { 
        noremap=true, silent=false }

  -- Open the link under the caret.
  map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

  -- Open notes linking to the current buffer.
  map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
  -- Alternative for backlinks using pure LSP and showing the source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Open notes linked by the current buffer.
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

  -- Preview a linked note.
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- Open the code actions for a visual selection.
  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end
```
