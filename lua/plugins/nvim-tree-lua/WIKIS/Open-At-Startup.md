# Opening nvim-tree At Neovim Startup

It can be useful to open nvim-tree when you start neovim.

nvim-tree cannot reliably do this on setup due to race conditions at startup and the overwhelming variety of user and plugin configurations.

Behaviour at startup is also a quite personal choice, with no means to provide mechanisms to suit everyone.

Hence we now leave it to you, the power user, to configure your startup behaviour.

Please open a [Discussion](https://github.com/nvim-tree/nvim-tree.lua/discussions) if you have any questions, issues or concerns.

Additional Recipes would be gratefully appreciated - please edit this page!

# netrw Hijacking

By default, [netrw](https://neovim.io/doc/user/pi_netrw.html) is replaced by nvim-tree when opening a directory.

netrw may still interfere with your startup behaviour. It's recommended to completely disable netrw, see `:help nvim-tree-netrw`

```lua
-- start of your init.lua
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
```

# Recipes

The `VimEnter` event should be used for the startup functionality: nvim-tree setup will have been called and other plugins will have started. It's the best time for you to define the behaviour you desire.

```lua
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
```

The `VimEnter` callback will be passed a table with the following pertinent data:

`buf` the buffer number of the currently focused buffer

`file` the name of the buffer

`event` always `VimEnter`

## Always Open nvim-tree

```lua
local function open_nvim_tree()

  -- open the tree
  require("nvim-tree.api").tree.open()
end
```

## Open For Files And [No Name] Buffers

```lua
local function open_nvim_tree(data)

  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not real_file and not no_name then
    return
  end

  -- open the tree, find the file but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end
```

## Open For Directories And Change Neovim's Directory

Current window:

```lua
local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end
```

New window:

```lua
local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end
```

## Open Nvim-tree in Regular Size

By default, nvim-tree occupies the whole window when opened at startup for directories. But this behavior might not intended by some users. To open nvim-tree in regular size, set the following lines in the config file:

```lua
hijack_directories = {
	enable = false,
	auto_open = false,
},
```

Then use above recipies to open nvim-tree at startup.

**NOTE**: If nvim-tree is opened in current window, it will always occupy the whole window regardless of the above config. So always open it in new window. To open nvim-tree in new window, call the `open()` function with a table which has the `current_window` key set to `false`:

```lua
require("nvim-tree.api").tree.open({
    current_window = false,
})
```

# Useful API

Useful API for startup. See `:help nvim-tree-api` for full details.

```lua
require("nvim-tree.api").tree.toggle({
	path = nil,
	current_window = false,
	find_file = false,
	update_root = false,
	focus = true,
})
```

```lua
require("nvim-tree.api").tree.change_root("/some/path")
```

```lua
require("nvim-tree.api").tree.focus()
```

```lua
require("nvim-tree.api").tree.open({
	path = nil,
	current_window = false,
	find_file = false,
	update_root = false,
})
```

# Useful Tests

Following are some tests that can help you make your decisions:

An actual, real file on the disk:

`vim.fn.filereadable(data.file) == 1`

A directory:

`vim.fn.isdirectory(data.file) == 1`

&buftype:

`vim.bo[data.buf].buftype`

&filetype:

`vim.bo[data.buf].ft`

A [No Name] new:

`data.file == "" and vim.bo[data.buf].buftype == ""`
