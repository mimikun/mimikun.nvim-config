# grug-far.nvim

## 🥪 Cookbook

### Launch with the current word under the cursor as the search string

```lua
:lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
```

#### Launch with ast-grep engine

```lua
:lua require('grug-far').open({ engine = 'astgrep' })
```

#### Launch as a transient buffer which is both unlisted and fully deletes itself when not in use

```lua
:lua require('grug-far').open({ transient = true })
```

#### Launch, limiting search/replace to current file

```lua
:lua require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } })
```

#### Launch with the current visual selection, searching only current file

```lua
:<C-u>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
```

#### Launch, limiting search to the current buffer visual selection range

```lua
:GrugFarWithin
```

or as a keymap if you want to go fully lua:

```lua
vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
  require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
end, { desc = 'grug-far: Search within range' })
```

or auto-detect to only limit the range if the visual selection is linewise, otherwise use the selection to pre-fill the search input:

```lua
vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
  require('grug-far').open({ visualSelectionUsage = 'auto-detect' })
end, { desc = 'grug-far: Search within range' })
```

#### Launch, with @/ register value as the search query, falling back to visual selection

Note that `@/` register holds your last `/` or `*`, etc search query.

```lua
vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
  local search = vim.fn.getreg('/')
  -- surround with \b if "word" search (such as when pressing `*`)
  if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
    search = '\\b' .. search:sub(3, -3) .. '\\b'
  elseif search and vim.startswith(search, '\\V') then
    search = search:sub(3)
  end
  local inst = require('grug-far').open({
    prefills = {
      search = search,
    },
  })
  inst:when_ready(function()
    inst:goto_input('replacement')
  end)
end, { desc = 'grug-far: Search using @/ register value or visual selection' })
```

#### Launch, pre-filling with last history entry

```lua
vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
  ---@type grug.far.OptionsOverride
  local opts = {}
  local entry = require('grug-far').get_last_history_entry()
  if entry ~= nil then
    opts.prefills = entry
    opts.engine = entry.engine
    opts.replacementInterpreter = entry.replacementInterpreter
  end

  require('grug-far').open(opts)
end, { desc = 'grug-far: Search, pre-filling with last history entry' })
```

#### Toggle visibility of a particular instance and set title to a fixed string

```lua
:lua require('grug-far').toggle_instance({ instanceName="far", staticTitle="Find and Replace" })
```

#### Create a buffer local keybinding to toggle --fixed-strings flag

```lua
vim.api.nvim_create_autocmd('FileType', {
  group =  vim.api.nvim_create_augroup('my-grug-far-custom-keybinds', { clear = true }),
  pattern = { 'grug-far' },
  callback = function()
    vim.keymap.set('n', '<localleader>w', function()
      local state = unpack(require('grug-far').get_instance(0):toggle_flags({ '--fixed-strings' }))
      vim.notify('grug-far: toggled --fixed-strings ' .. (state and 'ON' or 'OFF'))
    end, { buffer = true })
  end,
})
```

#### Create a buffer local keybinding to open a result location and immediately close grug-far.nvim

```lua
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
  pattern = { 'grug-far' },
  callback = function()
    vim.keymap.set('n', '<C-enter>', function()
      require('grug-far').get_instance(0):open_location()
      require('grug-far').get_instance(0):close()
    end, { buffer = true })
  end,
})
```

#### Create a buffer local keybinding to jump back to first input

``` lua
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('grug-far-keymap', { clear = true }),
  pattern = { 'grug-far' },
  callback = function()
    -- jump back to first input by hitting left arrow in normal mode:
    vim.keymap.set('n', '<left>', function()
      require('grug-far').get_instance(0):goto_first_input()
    end, { buffer = true })
  end,
})
```

#### Run a command (p4 edit <file>) before each file is modified on replace/sync

```lua
require('grug-far').open({ hooks = {
  on_before_edit_file = function(on_finish, file)
    return require('grug-far').spawn_cmd_async({
      cmd_path = 'p4',
      args = { 'edit', file.path},
      on_finish = on_finish,
    })
  end,
}})
```

_NOTE:_ `spawn_cmd_async` is provided as a convenience that also handles abort (it returns abort function),
but you can implement your own logic of course.

#### Add neo-tree integration to open search limited to focused directory or file

Create a hotkey `z` in `neo-tree` that will create/open a named instance of grug-far with the current directory of the file or directory in focus. On the second trigger, path of the grug-far instance will be updated, leaving other fields intact.

<details>
<summary>Neo tree lazy plugin setup</summary>

Small video of it in action: <https://github.com/MagicDuck/grug-far.nvim/issues/165#issuecomment-2257439367>

```lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local function open_grug_far(prefills)
      local grug_far = require("grug-far")

      if not grug_far.has_instance("explorer") then
        grug_far.open({ instanceName = "explorer" })
      else
        grug_far.get_instance('explorer'):open()
      end
      -- doing it seperately because multiple paths doesn't open work when passed with open
      -- updating the prefills without clearing the search and other fields
      grug_far.get_instance('explorer'):update_input_values(prefills, false)
    end
    require("neo-tree").setup {
      commands = {
        -- create a new neo-tree command
        grug_far_replace = function(state)
          local node = state.tree:get_node()
          local prefills = {
            -- also escape the paths if space is there
            -- if you want files to be selected, use ':p' only, see filename-modifiers
            paths = node.type == "directory" and vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ":p"))
        or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ":h")),
          }
          open_grug_far(prefills)
        end,
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/fbb631e818f48591d0c3a590817003d36d0de691/doc/neo-tree.txt#L535
        grug_far_replace_visual = function(state, selected_nodes, callback)
          local paths = {}
          for _, node in pairs(selected_nodes) do
            -- also escape the paths if space is there
            -- if you want files to be selected, use ':p' only, see filename-modifiers
            local path = node.type == "directory" and vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ":p"))
        or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ":h"))
            table.insert(paths, path)
          end
          local prefills = { paths = table.concat(paths, "\n") }
          open_grug_far(prefills)
        end,
      },
      window = {
        mappings = {
          -- map our new command to z
          z = "grug_far_replace",
        },
      },
      -- rest of your config
    }
  end,
}
```

</details>

#### Add oil.nvim integration to open search limited to focused directory

Create a hotkey `gs` in `oil.nvim` that will create/open a named instance of grug-far with the current directory in focus. On the second trigger, path of the grug-far instance will be updated, leaving other fields intact.

<details>
<summary>Oil explorer lazy plugin setup</summary>

```lua
return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require "oil"
    oil.setup {
      keymaps = {
        -- create a new mapping, gs, to search and replace in the current directory
        gs = {
          callback = function()
            -- get the current directory
            local prefills = { paths = oil.get_current_dir() }

            local grug_far = require "grug-far"
            -- instance check
            if not grug_far.has_instance "explorer" then
              grug_far.open {
                instanceName = "explorer",
                prefills = prefills,
                staticTitle = "Find and Replace from Explorer",
              }
            else
              grug_far.get_instance('explorer'):open()
              -- updating the prefills without clearing the search and other fields
              grug_far.get_instance('explorer'):update_input_values(prefills, false)
            end
          end,
          desc = "oil: Search in directory",
        },
      },
      -- rest of your config
    }
  end,
}
```

</details>

#### Add mini.files integration to open search limited to focused directory

Create a hotkey `gs` in `mini.files` that will create/open a named instance of grug-far with the current directory in focus. On the second trigger, the path of the grug-far instance will be updated, leaving other fields intact.

<details>
<summary>MiniFiles explorer lazy plugin setup</summary>

```lua
return {
  "echasnovski/mini.files",
  config = function()
    local MiniFiles = require "mini.files"

    MiniFiles.setup({
      -- your config
    })


    local files_grug_far_replace = function(path)
      -- works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local prefills = { paths = vim.fs.dirname(cur_entry_path) }

      local grug_far = require "grug-far"

      -- instance check
      if not grug_far.has_instance "explorer" then
        grug_far.open {
          instanceName = "explorer",
          prefills = prefills,
          staticTitle = "Find and Replace from Explorer",
        }
      else
        grug_far.get_instance('explorer'):open()
        -- updating the prefills without crealing the search and other fields
        grug_far.get_instance('explorer'):update_input_values(prefills, false)
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "gs", files_grug_far_replace, { buffer = args.data.buf_id, desc = "Search in directory" })
      end,
    })
  end,
}
```

</details>

## ❓ Q&A

### 1. Getting RPC[Error] ... Document for URI could not be found: file:///.../Grug%20FAR%20-%20

Chances are that you are using copilot.nvim and the fix is to exclude `grug-far` file types in copilot config:

```lua
filetypes = {
  ["grug-far"] = false,
  ["grug-far-history"] = false,
  ["grug-far-help"] = false,
}
```

[spectre]: https://github.com/nvim-pack/nvim-spectre
[telescope]: https://github.com/nvim-telescope/telescope.nvim
