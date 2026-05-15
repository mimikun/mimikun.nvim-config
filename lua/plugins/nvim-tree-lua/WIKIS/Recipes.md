Please add your Recipes to share your productivity with others.

Don't forget to credit yourself when adding:
`[@username](https://www.github.com/username)`

# Caution: API and Internal Modules

Module `nvim-tree.api` is public API that will not change in a breaking manner and can be relied on.

Other modules such as `nvim-tree.view` are internal and will change without notice.

Please raise a [feature request](https://github.com/nvim-tree/nvim-tree.lua/issues/new?assignees=&labels=feature+request&projects=&template=feature_request.md&title=) to add API that you may need.

# h, j, k, l Style Navigation And Editing

[@eddiebergman](https://www.github.com/eddiebergman)

Hotkeys that keep your fingers using <kbd>h</kbd>, <kbd>j</kbd>, <kbd>k</kbd>, <kbd>l</kbd> for navigation and opening.
* <kbd>Ctrl</kbd> + <kbd>h</kbd> | Open tree
* <kbd>h</kbd> | Collapse current containing folder
* <kbd>H</kbd> | Collapse Tree
* <kbd>l</kbd> | Open node if it is a folder, else edit the file and close tree
* <kbd>L</kbd> | Open node if it is a folder, else create vsplit of file and keep cursor focus on tree
 
In particular, <kbd>L</kbd> is quite nice for opening a few files in quick succession without losing focus of the tree while using <kbd>l</kbd> for just editing a file in the current buffer.

To do so, you'll want to add some global and nvim-tree mappings:
```lua
-- global
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

-- on_attach
vim.keymap.set("n", "l", edit_or_open,          opts("Edit Or Open"))
vim.keymap.set("n", "L", vsplit_preview,        opts("Vsplit Preview"))
vim.keymap.set("n", "h", api.tree.close,        opts("Close"))
vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
```

You'll also need to define these callbacks that `nvim-tree` will use, they'll need to be defined above the snippet above:
```lua
local api = require("nvim-tree.api")

local function edit_or_open()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file as vsplit
    api.node.open.vertical()
  end

  -- Finally refocus on tree if it was lost
  api.tree.focus()
end
```

# Git Stage Unstage Files And Directories From The Tree

[@Hubro](https://www.github.com/Hubro)

You can stage and unstage files directly in the tree view with this config:

```lua
local api = require("nvim-tree.api")

local git_add = function()
  local node = api.tree.get_node_under_cursor()
  local gs = node.git_status.file

  -- If the current node is a directory get children status
  if gs == nil then
    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1]) 
         or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
  end

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  api.tree.reload()
end
```

```lua
vim.keymap.set('n', 'ga', git_add, opts('Git Add'))
```

If you target a file or directory in the tree and press `ga`, it will be git staged. If it's already staged, it will instead be unstaged.

# Find File From Node In Telescope

[@kyazdani42](https://www.github.com/kyazdani42)

Here is a small snippet of code to open the file under the cursor in telescope

File named 'treeutils.lua'

```lua
local api = require("nvim-tree.api")
local actions = require'telescope.actions'
local action_state = require'telescope.actions.state'
local M = {}

local view_selection = function(prompt_bufnr)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename
    if (filename == nil) then
      filename = selection[1]
    end
    api.tree.find_file(filename, { open = true, focus = true, })
    api.node.open.preview()
  end)
  return true
end

function M.launch_live_grep(opts)
  return M.launch_telescope("live_grep", opts)
end

function M.launch_find_files(opts)
  return M.launch_telescope("find_files", opts)
end

function M.launch_telescope(func_name, opts)
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end
  local node = api.tree.get_node_under_cursor()
  local basedir = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  return require("telescope.builtin")[func_name](opts)
end

return M
```

```lua
local treeutils = require("treeutils")

vim.keymap.set('n', '<c-f>', treeutils.launch_find_files, opts('Launch Find Files'))
vim.keymap.set('n', '<c-g>', treeutils.launch_live_grep,  opts('Launch Live Grep'))
```

# Filter Directories With Live Filter

[@kay-adamof](https://www.github.com/kay-adamof)

By default, the `live filter` doesn't filter the directory names but it's so painful if you have many folders in your project.

Put this code to your init.lua.

```lua
require("nvim-tree").setup {
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false, -- Turn into false from true by default
  }
}
```

# Fix tab titles when opening file in new tab

[@sarahkittyy](https://www.github.com/sarahkittyy)

By default, opening a file in a new tab leaves NvimTree_1 as the text in the tab bar. This function will run `<C-w>l` before opening a new tab to set the tab title to the split adjacent to the tree.

```lua
local swap_then_open_tab = function()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	vim.cmd("wincmd l")
	api.node.open.tab(node)
end
-- { key = "t", action = "swap_then_open_tab", action_cb = swap_then_open_tab },
```

# Center a floating nvim-tree window

For nvim-tree to be a centered floating window, add this to your config:

```lua
local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

require('nvim-tree').setup({
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})
```

![screen](https://user-images.githubusercontent.com/31312212/206869912-3ac53e08-9256-495f-b240-5f9f95ad2419.png)

If you want to automatically resize the floating window when neovim's window size changes, add this to your config:
```lua
local api = require("nvim-tree.api")

vim.api.nvim_create_augroup("NvimTreeResize", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
  group = "NvimTreeResize",
  callback = function()
    -- Get the nvim-tree window ID
    local winid = api.tree.winid()
    if (winid) then
      api.tree.reload()
    end
  end
})
```

Original solution by [@davidsierradz](https://github.com/davidsierradz) and
[@alex-courtis](https://github.com/alex-courtis) (see
[#1538](https://github.com/nvim-tree/nvim-tree.lua/pull/1538)). Recipe written
by [@Kryzar](https://github.com/Kryzar).

# Creating an actions menu using Telescope

[@Tolomeo](https://github.com/Tolomeo)

It is possible to use Telescope as a menu, listing custom items and executing a callback on item selection.
Following is a minimal example.

First of all, you will need a list of labels to show in the menu, along with their associated callbacks.
Note that nvim-tree actions are directly requirable from `nvim-tree.api`.

```lua
local tree_actions = {
	{
		name = "Create node",
		handler = require("nvim-tree.api").fs.create,
	},
	{
		name = "Remove node",
		handler = require("nvim-tree.api").fs.remove,
	},
	{
		name = "Trash node",
		handler = require("nvim-tree.api").fs.trash,
	},
	{
		name = "Rename node",
		handler = require("nvim-tree.api").fs.rename,
	},
	{
		name = "Fully rename node",
		handler = require("nvim-tree.api").fs.rename_sub,
	},
	{
		name = "Copy",
		handler = require("nvim-tree.api").fs.copy.node,
	},

	-- ... other custom actions you may want to display in the menu
}
```

You will then need a function used to display the actions in a Telescope picker.
The function will be keymapped inside `on_attach` nvim-tree config option and as such it will receive the highlighted node.

```lua
local function tree_actions_menu(node)
	local entry_maker = function(menu_item)
		return {
			value = menu_item,
			ordinal = menu_item.name,
			display = menu_item.name,
		}
	end

	local finder = require("telescope.finders").new_table({
		results = tree_actions,
		entry_maker = entry_maker,
	})

	local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

	local default_options = {
		finder = finder,
		sorter = sorter,
		attach_mappings = function(prompt_buffer_number)
			local actions = require("telescope.actions")

			-- On item select
			actions.select_default:replace(function()
				local state = require("telescope.actions.state")
				local selection = state.get_selected_entry()
				-- Closing the picker
				actions.close(prompt_buffer_number)
				-- Executing the callback
				selection.value.handler(node)
			end)

			-- The following actions are disabled in this example
			-- You may want to map them too depending on your needs though
			actions.add_selection:replace(function() end)
			actions.remove_selection:replace(function() end)
			actions.toggle_selection:replace(function() end)
			actions.select_all:replace(function() end)
			actions.drop_all:replace(function() end)
			actions.toggle_all:replace(function() end)

			return true
		end,
	}

	-- Opening the menu
	require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end
```

```lua
vim.keymap.set("n", "<C-Space>", tree_actions_menu, { buffer = buffer, noremap = true, silent = true })
```

# Change Root To Global Current Working Directory

[@alex-courtis](https://github.com/alex-courtis)

When not using `update_focused_file.update_root` the tree's current working directory may differ from the global.

You can manually change the root to the global cwd:

```lua
local function change_root_to_global_cwd()
  local api = require("nvim-tree.api")
  local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end
```

```lua
vim.keymap.set('n', '<C-c>', change_root_to_global_cwd, opts('Change Root To Global CWD'))
```

```lua
vim.keymap.set('n', 'T', open_tab_silent, opts('Open Tab Silent'))
```

# Sorting files naturally (respecting numbers within files names)

[@zer0-x](https://github.com/zer0-x)

The current available sorting by name algorithm just sorts files names by comparing every character in them. This leads to a strange and undesirable arrangement when you have numbered files names, since it will sort numbers as any normal letter.

For example files will be sorted as `1 foo`, `20 foo`, `3 foo` rather then `1 foo`, `3 foo`, `20 foo`. The code bellow should solve that.

This is it, the fixed and improved version:

```lua
local function natural_cmp(left, right)
	left = left.name:lower()
	right = right.name:lower()

	if left == right then
		return false
	end

	for i = 1, math.max(string.len(left), string.len(right)), 1 do
		local l = string.sub(left, i, -1)
		local r = string.sub(right, i, -1)

		if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
			local l_number = tonumber(string.match(l, "^[0-9]+"))
			local r_number = tonumber(string.match(r, "^[0-9]+"))

			if l_number ~= r_number then
				return l_number < r_number
			end
		elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
			return l < r
		end
	end
end

require("nvim-tree").setup({
	sort_by = function(nodes)
		table.sort(nodes, natural_cmp)
	end,
})
```

<sup> Related discussion: [#1896](https://github.com/nvim-tree/nvim-tree.lua/discussions/1896)</sup>

<sup> References: [lifthrasiir/rust-natord/lib.rs#L142](https://github.com/lifthrasiir/rust-natord/blob/93e5f0ace208e73ddfaaa77ec1605584c8f22a14/lib.rs#L142), [lifthrasiir/rust-natord/lib.rs#L37](https://github.com/lifthrasiir/rust-natord/blob/93e5f0ace208e73ddfaaa77ec1605584c8f22a14/lib.rs#L37)</sup>

# Automatically open file upon creation

[@magoz](https://github.com/magoz)

```lua
local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
end)
```

# Automatically focus already-opened file by `Enter` (`<CR>`)

https://user-images.githubusercontent.com/8136158/233742234-c4f4bb4b-1927-4ab4-b0cc-779c64a0e1b1.mov

[@hinell](https://github.com/hinell)

> [!NOTE]  
> REF: [PR2161](https://github.com/nvim-tree/nvim-tree.lua/pull/2161)

```lua
    require("nvim-tree").setup({
        on_attach = function(bufnr)
            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            local ok, api = pcall(require, "nvim-tree.api")
            assert(ok, "api module is not found")
            vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts("Tab drop"))
        end
    })
```

# Vinegar Style

nvim-tree can behave like vinegar. To allow this, you will need to configure it in a specific way:

Use `api.node.open.replace_tree_buffer` instead of the default open command. You can easily implement a toggle:

```lua
local function toggle_replace()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.node.open.replace_tree_buffer()
  end
end
```

Use "Open: In Place" to edit files. It's bound to `<C-e>` by default, vinegar uses `<CR>`. You can override this:

```lua
vim.keymap.set('n', '<CR>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
```

Going up a dir is bound to `-` by default in nvim-tree which is identical to vinegar, no change is needed here.


# Copy / Move File To

[cowboysmall](https://github.com/cowboysmall-tools/cowboysmall-dotfiles/blob/main/nvim/.config/nvim/lua/plugins/nvim-tree.lua)

```lua

  {
    "nvim-tree/nvim-tree.lua",

    opts = {

      view = { width = 50 },

      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        local map = vim.keymap.set

        map("n", "<M-c>", function()
          local file_src = api.tree.get_node_under_cursor()["absolute_path"]
          local input_opts = { prompt = "Copy to ", default = file_src, completion = "file" }

          vim.ui.input(input_opts, function(file_out)
            local dir = vim.fn.fnamemodify(file_out, ":h")

            local res = vim.fn.system({ "mkdir", "-p", dir })
            if vim.v.shell_error ~= 0 then
              vim.notify(res, vim.log.levels.ERROR, { title = "NvimTree" })
              return
            end

            vim.fn.system({ "cp", "-R", file_src, file_out })
          end)
        end, opts("Copy File To"))

        map("n", "<M-x>", function()
          local file_src = api.tree.get_node_under_cursor()["absolute_path"]
          local input_opts = { prompt = "Move to ", default = file_src, completion = "file" }

          vim.ui.input(input_opts, function(file_out)
            local dir = vim.fn.fnamemodify(file_out, ":h")

            local res = vim.fn.system({ "mkdir", "-p", dir })
            if vim.v.shell_error ~= 0 then
              vim.notify(res, vim.log.levels.ERROR, { title = "NvimTree" })
              return
            end

            vim.fn.system { "mv", file_src, file_out }
          end)
        end, opts("Move File To"))
      end
    }
  }

```

# Show dynamic actions popup
[@JoseConseco](https://github.com/JoseConseco)

Show dynamic Hydra popup with file actions that user can perform on files, when NvimTree window is focused.
Requires [hydra.nvim](https://github.com/anuvyklack/hydra.nvim) - this plugin can draw menu popups and execute custom, user defined, commands. 
[nvim-tree_hydra.webm](https://user-images.githubusercontent.com/13521338/219655264-2c9b650b-95b4-4fe9-85a9-73196b8c1b02.webm)


```lua
-- auto show hydra on nvimtree focus
local function change_root_to_global_cwd()
  local global_cwd = vim.fn.getcwd()
  -- local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end

local hint = [[
 _w_: cd CWD   _c_: Path yank           _/_: Filter
 _y_: Copy     _x_: Cut                 _p_: Paste
 _r_: Rename   _d_: Remove              _n_: New
 _h_: Hidden   _?_: Help
 ^
]]
-- ^ ^           _q_: exit

local nvim_tree_hydra = nil
local nt_au_group = vim.api.nvim_create_augroup("NvimTreeHydraAu", { clear = true })

local Hydra = require "hydra"
local function spawn_nvim_tree_hydra()
  nvim_tree_hydra = Hydra {
          name = "NvimTree",
          hint = hint,
          config = {
              color = "pink",
              invoke_on_body = true,
              buffer = 0, -- only for active buffer
              hint = {
                  position = "bottom",
                  border = "rounded",
              },
          },
          mode = "n",
          body = "H",
          heads = {
              { "w", change_root_to_global_cwd,     { silent = true } },
              { "c", api.fs.copy.absolute_path,     { silent = true } },
              { "/", api.live_filter.start,         { silent = true } },
              { "y", api.fs.copy.node,              { silent = true } },
              { "x", api.fs.cut,                    { exit = true, silent = true } },
              { "p", api.fs.paste,                  { exit = true, silent = true } },
              { "r", api.fs.rename,                 { silent = true } },
              { "d", api.fs.remove,                 { silent = true } },
              { "n", api.fs.create,                 { silent = true } },
              { "h", api.tree.toggle_hidden_filter, { silent = true } },
              { "?", api.tree.toggle_help,          { silent = true } },
              -- { "q", nil, { exit = true, nowait = true } },
          },
      }
  nvim_tree_hydra:activate()
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(opts)
      if vim.bo[opts.buf].filetype == "NvimTree" then
        spawn_nvim_tree_hydra()
      else
        if nvim_tree_hydra then
          nvim_tree_hydra:exit()
        end
      end
    end,
    group = nt_au_group,
})      
```

# Workaround when using rmagatti/auto-session

[@nikolasmish](https://github.com/nikolasmish)

There is currently an issue with restoring nvim-tree fully when using rmagatti/auto-session. Upon restoring the session, nvim-tree buffer will be empty, sometimes positioned in strange places with random dimensions. This issue only happens when saving session with nvim-tree open. To prevent this from happening you can use the following autocmd:

```lua
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')

    if not api.tree.is_visible() then
      api.tree.open()
    end
  end,
})
```

This autocmd will check whether nvim-tree is open when the session is restored and refresh it.

# Make `:q` and `:bd` work as if tree was not visible

[@mikehaertl](https://github.com/mikehaertl)

When closing the last window besides nvim-tree with `:q` or `:bd` you end up with a single window with nvim-tree.

The following script makes the two commands behave as if the tree was closed:

* [:q](https://neovim.io/doc/user/editing.html#%3Aq) will quit vim if only a single window (besides the tree) is open (unless there are unsaved changes)
* [:bdelete](https://neovim.io/doc/user/windows.html#%3Abdelete) will show the most recent entry in the jump list that points into a loaded buffer (i.e. some hidden buffer) or an empty buffer in the current window


```lua
-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({'BufEnter', 'QuitPre'}, {
  nested = false,
  callback = function(e)
    local tree = require('nvim-tree.api').tree

    -- Nothing to do if tree is not opened
    if not tree.is_visible() then
      return
    end

    -- How many focusable windows do we have? (excluding e.g. incline status window)
    local winCount = 0
    for _,winId in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(winId).focusable then
        winCount = winCount + 1
      end
    end

    -- We want to quit and only one window besides tree is left
    if e.event == 'QuitPre' and winCount == 2 then
      vim.api.nvim_cmd({cmd = 'qall'}, {})
    end

    -- :bd was probably issued an only tree window is left
    -- Behave as if tree was closed (see `:h :bd`)
    if e.event == 'BufEnter' and winCount == 1 then
      -- Required to avoid "Vim:E444: Cannot close last window"
      vim.defer_fn(function()
        -- close nvim-tree: will go to the last buffer used before closing
        tree.toggle({find_file = true, focus = true})
        -- re-open nivm-tree
        tree.toggle({find_file = true, focus = false})
      end, 10)
    end
  end
})
```

# Cycle Sort Methods

[@alex-courtis](https://github.com/alex-courtis)

Predefined sorts may be cycled. See `:help nvim-tree.sort_by`

```lua
local SORT_METHODS = {
  "name",
  "case_sensitive",
  "modification_time",
  "extension",
}
local sort_current = 1

local cycle_sort = function()
  if sort_current >= #SORT_METHODS then
    sort_current = 1
  else
    sort_current = sort_current + 1
  end
  api.tree.reload()
end

local sort_by = function()
  return SORT_METHODS[sort_current]
end
```

Define your `sort_by` in your configuration:

```lua
require("nvim-tree").setup({
  sort_by = sort_by,
  ---
})
```

```lua
vim.keymap.set('n', 'T', cycle_sort, opts('Cycle Sort'))
```

# Modify you `on_attach` function to have ability to operate multiple files at once!
Use the apis provided by neovim-tree to implement the following config:


```lua
{
		ui = {
			confirm = {
				remove = true,
				trash = false,
			},
		},
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local opts = function(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- mark operation
			local mark_move_j = function()
				api.marks.toggle()
				vim.cmd("norm j")
			end
			local mark_move_k = function()
				api.marks.toggle()
				vim.cmd("norm k")
			end

			-- marked files operation
			local mark_trash = function()
				local marks = api.marks.list()
				if #marks == 0 then
					table.insert(marks, api.tree.get_node_under_cursor())
				end
				vim.ui.input({ prompt = string.format("Trash %s files? [y/n] ", #marks) }, function(input)
					if input == "y" then
						for _, node in ipairs(marks) do
							api.fs.trash(node)
						end
						api.marks.clear()
						api.tree.reload()
					end
				end)
			end
			local mark_remove = function()
				local marks = api.marks.list()
				if #marks == 0 then
					table.insert(marks, api.tree.get_node_under_cursor())
				end
				vim.ui.input({ prompt = string.format("Remove/Delete %s files? [y/n] ", #marks) }, function(input)
					if input == "y" then
						for _, node in ipairs(marks) do
							api.fs.remove(node)
						end
						api.marks.clear()
						api.tree.reload()
					end
				end)
			end

			local mark_copy = function()
				local marks = api.marks.list()
				if #marks == 0 then
					table.insert(marks, api.tree.get_node_under_cursor())
				end
				for _, node in pairs(marks) do
					api.fs.copy.node(node)
				end
				api.marks.clear()
				api.tree.reload()
			end
			local mark_cut = function()
				local marks = api.marks.list()
				if #marks == 0 then
					table.insert(marks, api.tree.get_node_under_cursor())
				end
				for _, node in pairs(marks) do
					api.fs.cut(node)
				end
				api.marks.clear()
				api.tree.reload()
			end

			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "J", mark_move_j, opts("Toggle Bookmark Down"))
			vim.keymap.set("n", "K", mark_move_k, opts("Toggle Bookmark Up"))

			vim.keymap.set("n", "dd", mark_cut, opts("Cut File(s)"))
			vim.keymap.set("n", "df", mark_trash, opts("Trash File(s)"))
			vim.keymap.set("n", "dF", mark_remove, opts("Remove File(s)"))
			vim.keymap.set("n", "yy", mark_copy, opts("Copy File(s)"))

			vim.keymap.set("n", "mv", api.marks.bulk.move, opts("Move Bookmarked"))

		end,


}
```

# Find and Focus Directory (with Telescope) 

Opens up a telescope search dialog of all the directories in your project. If a selection is chosen it will then open nvim-tree and focus on that directory allowing you to quickly add/change files in any directory. 

[@hay-kot](https://github.com/hay-kot)

```lua
function find_directory_and_focus()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function open_nvim_tree(prompt_bufnr, _)
    actions.select_default:replace(function()
      local api = require("nvim-tree.api")

      actions.close(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      api.tree.open()
      api.tree.find_file(selection.cwd .. "/" .. selection.value)
    end)
    return true
  end

  require("telescope.builtin").find_files({
    find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
    attach_mappings = open_nvim_tree,
  })
end

vim.keymap.set("n", "fd", find_directory_and_focus)
```

# Refactoring of "on_attach" Generated Code

[@ErlanRG](https://www.github.com/ErlanRG)

This is a different approach to how the code generated by the temporary `on_attach` function looks like.

- Before

```lua
 -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
  vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
  vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts "Info")
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
  vim.keymap.set("n", ".", api.node.run.cmd, opts "Run Command")
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "Up")
  vim.keymap.set("n", "a", api.fs.create, opts "Create")
  vim.keymap.set("n", "bmv", api.marks.bulk.move, opts "Move Bookmarked")
  vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle No Buffer")
  vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
  vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Git Clean")
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts "Prev Git")
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts "Next Git")
  vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
  vim.keymap.set("n", "D", api.fs.trash, opts "Trash")
  vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
  vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
  vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
  vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
  vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
  vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts "Last Sibling")
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts "First Sibling")
  vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
  vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "O", api.node.open.no_window_picker, opts "Open: No Window Picker")
  vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
  vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
  vim.keymap.set("n", "q", api.tree.close, opts "Close")
  vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
  vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
  vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
  vim.keymap.set("n", "S", api.tree.search_node, opts "Search")
  vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts "Toggle Hidden")
  vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")
  vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
  vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
  -- END_DEFAULT_ON_ATTACH

  -- Mappings migrated from view.mappings.list
  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.set("n", "C", api.tree.change_root_to_node, opts "CD")
```

- After

```lua
  local mappings = {
    -- BEGIN_DEFAULT_ON_ATTACH
    ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
    ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
    ["<C-k>"] = { api.node.show_info_popup, "Info" },
    ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
    ["<C-t>"] = { api.node.open.tab, "Open: New Tab" },
    ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
    ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
    ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
    ["<CR>"] = { api.node.open.edit, "Open" },
    ["<Tab>"] = { api.node.open.preview, "Open Preview" },
    [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
    ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
    ["."] = { api.node.run.cmd, "Run Command" },
    ["-"] = { api.tree.change_root_to_parent, "Up" },
    ["a"] = { api.fs.create, "Create" },
    ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
    ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
    ["c"] = { api.fs.copy.node, "Copy" },
    ["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
    ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
    ["]c"] = { api.node.navigate.git.next, "Next Git" },
    ["d"] = { api.fs.remove, "Delete" },
    ["D"] = { api.fs.trash, "Trash" },
    ["E"] = { api.tree.expand_all, "Expand All" },
    ["e"] = { api.fs.rename_basename, "Rename: Basename" },
    ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
    ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
    ["F"] = { api.live_filter.clear, "Clean Filter" },
    ["f"] = { api.live_filter.start, "Filter" },
    ["g?"] = { api.tree.toggle_help, "Help" },
    ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
    ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
    ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
    ["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
    ["K"] = { api.node.navigate.sibling.first, "First Sibling" },
    ["m"] = { api.marks.toggle, "Toggle Bookmark" },
    ["o"] = { api.node.open.edit, "Open" },
    ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
    ["p"] = { api.fs.paste, "Paste" },
    ["P"] = { api.node.navigate.parent, "Parent Directory" },
    ["q"] = { api.tree.close, "Close" },
    ["r"] = { api.fs.rename, "Rename" },
    ["R"] = { api.tree.reload, "Refresh" },
    ["s"] = { api.node.run.system, "Run System" },
    ["S"] = { api.tree.search_node, "Search" },
    ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
    ["W"] = { api.tree.collapse_all, "Collapse" },
    ["x"] = { api.fs.cut, "Cut" },
    ["y"] = { api.fs.copy.filename, "Copy Name" },
    ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
    ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
    ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
    -- END_DEFAULT_ON_ATTACH

    -- Mappings migrated from view.mappings.list
    ["l"] = { api.node.open.edit, "Open" },
    ["<CR>"] = { api.node.open.edit, "Open" },
    ["o"] = { api.node.open.edit, "Open" },
    ["h"] = { api.node.navigate.parent_close, "Close Directory" },
    ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
    ["C"] = { api.tree.change_root_to_node, "CD" },
  }

  for keys, mapping in pairs(mappings) do
    vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
  end
```

This refactor keeps the escense of the original code, but centralize the key mappings in a table.

# Clear clipboard before every copy & cut operation

[@Tudmotu](https://www.github.com/Tudmotu) [@alex-courtis](https://github.com/alex-courtis)

By default, NvimTree clipboard is "additive", meaning you can copy or cut multiple files by invoking `c` or `x` on them, then paste them all at once using `p`.

This snippet will change the default behavior to only allow copying & cutting single files at a time. It works by rebinding the `c` and `x` commands to a new function which first clears the clipboard before adding the new file to it, as explained in [this discussion](https://github.com/nvim-tree/nvim-tree.lua/discussions/2397#discussioncomment-6895067).

Add the following to your `on_attach` function:

```lua
local function clear_and_copy()
    api.fs.clear_clipboard()
    api.fs.copy.node()
end

local function clear_and_cut()
    api.fs.clear_clipboard()
    api.fs.cut()
end

vim.keymap.set('n', 'c', clear_and_copy, opts('Copy'))
vim.keymap.set('n', 'x', clear_and_cut, opts('Cut'))
```

# Smart nvim-tree toggling

https://github.com/nvim-tree/nvim-tree.lua/assets/8136158/5ab6e864-9e10-4515-8b2e-ed33e3624adc

[@hinell](https://github.com/hinell)

> Use single hotkeys to toggle/focus nvim-tree: <br/>
If nvim-tree is focused - close it<br/>
Or always focus nvim-tree otherwise

```lua
-- init.lua
local nvimTreeFocusOrToggle = function ()
	local nvimTree=require("nvim-tree.api")
	local currentBuf = vim.api.nvim_get_current_buf()
	local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
	if currentBufFt == "NvimTree" then
		nvimTree.tree.toggle()
	else
		nvimTree.tree.focus()
	end
end


vim.keymap.set("n", "<A-1>", nvimTreeFocusOrToggle)

-- or legendary

legendary.setup({
	-- ..
	keymaps = {
		  { '<A-1>', nvimTreeFocusOrToggle, description = "nvim-tree: focus/toggle nvim-tree" }
	}
})

```

# Prevent NvimTree buffers in shada

[@JosefLitos](https://github.com/JosefLitos)

Simplest approach is to bind your nvimtree exit keybind to `<Cmd>bwipeout<CR>`. That method closes the current buffer without saving it to your jumps list nor anywhere else.
If you have a quick closing keybind, you can use regexes to choose the method for closing:
```lua
local function close()
	local name = vim.api.nvim_buf_get_name(0)
	if
		name:find('.git/', 7, true)
		-- or name:match 'node_modules'
		or name:match 'NvimTree_[0-9]+$'
		or not vim.loop.fs_stat(name)
	then
		vim.cmd.bwipeout()
	else
		vim.cmd.bdelete()
	end
end
```

Alternatively you can add a hook for closing with the `nvim-tree.on_attach` config function:
```lua
vim.api.nvim_create_autocmd('BufDelete', {callback = function(state)
  vim.opt.shada:append(state.file)
end})
```

# Root folder label shortener

[@JosefLitos](https://github.com/JosefLitos)

Turn long paths into something short yet understandable:
```
/home/user/Documents/PG/proj-name/src/DirName
→
~/D/PG/p-n/s/DName
```

```lua
local function label(path)
  path = path:gsub(os.getenv 'HOME', '~', 1)
  return path:gsub('([a-zA-Z])[a-z0-9]+', '%1') .. 
    (path:match '[a-zA-Z]([a-z0-9]*)$' or '')
end
local api = require 'nvim-tree.api'
local nt = require 'nvim-tree'
nt.setup { renderer = { root_folder_label = label, group_empty = label } }
```

# Toggle Adaptive Width

[@brucejxz](https://github.com/brucejxz)
[@alex-courtis](https://github.com/alex-courtis)

Mapping to toggle width between fixed and adaptive - width to fit largest file or folder.

Define your state and toggle function:

```lua
local VIEW_WIDTH_FIXED = 30
local view_width_max = VIEW_WIDTH_FIXED -- fixed to start

-- toggle the width and redraw
local function toggle_width_adaptive()
  if view_width_max == -1 then
    view_width_max = VIEW_WIDTH_FIXED
  else
    view_width_max = -1
  end

  require("nvim-tree.api").tree.reload()
end
```

Use the state:

```lua
-- get current view width
local function get_view_width_max()
  return view_width_max
end

require("nvim-tree").setup({
  view = {
    width = {
      min = 30,
      max = get_view_width_max,
    }
  }
})
```

Map in your `on_attach`, could also be global:

```lua
vim.keymap.set('n', 'A',        toggle_width_adaptive,                        opts('Toggle Adaptive Width'))
```

# Setting a separate statusline for nvim-tree windows

[@mkalinski](https://github.com/mkalinski)
[@alex-courtis](https://github.com/alex-courtis)

Often, a rich statusline does not behave well in a very narrow vertical split window, like nvim-tree normally uses. See [#424](https://github.com/nvim-tree/nvim-tree.lua/issues/424) for example.

A different, simpler statusline for nvim-tree windows can be configured like this:

```lua
local nt_api = require'nvim-tree.api'

nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
  local tree_winid = nt_api.tree.winid()

  if tree_winid ~= nil then
    vim.api.nvim_set_option_value('statusline', '%t', {win = tree_winid})
  end
end)
```

Statusline value of `'%t'` will make nvim-tree windows display just the title `NvimTree_#`. See `:h 'statusline` for explanation of how statusline strings work.

To make nvim-tree have no visible statusline at all, you can use a value of a single space `' '`. Note, that using a value of empty string `''` will make Neovim fall back to global statusline, which is the opposite of what we want.

# Toggle nvim-tree open / closed with nt

@jimafisk

Add the following script to `~/.config/nvim/init.vim` to hide/show nvim-tree by typing <kbd>n</kbd><kbd>t</kbd> in quick succession:

```vim
function! NvimTreeToggleAll()
   let current_tab = tabpagenr()
   if g:nvim_tree_open
      tabdo NvimTreeClose
      let g:nvim_tree_open = 0
   else
      tabdo NvimTreeOpen
      let g:nvim_tree_open = 1
   endif
   execute 'tabnext' current_tab
endfunction
let g:nvim_tree_open = 0
if isdirectory(argv(0))
   let g:nvim_tree_open = 1
endif
nnoremap nt :call NvimTreeToggleAll()<CR>
```

# Remember nvim‐tree window size
[@vhminh](https://github.com/vhminh)

Nvim-tree window size is reset when you close and reopen the tree.

This script remember the last window width for each tab, and restore the window size when nvim-tree is opened

```lua
require('nvim-tree').setup({
  actions = {
    open_file = {
      resize_window = false, -- don't resize window when opening file
    },
  },
})

local api = require('nvim-tree.api')
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- save nvim-tree window width on WinResized event
augroup('save_nvim_tree_width', { clear = true })
autocmd('WinResized', {
  group = 'save_nvim_tree_width',
  pattern = '*',
  callback = function()
    local winid = api.tree.winid()
    if winid ~= nil and vim.tbl_contains(vim.v.event['windows'], winid) then
      vim.t['filetree_width'] = vim.api.nvim_win_get_width(winid)
    end
  end,
})

-- restore window size when openning nvim-tree
api.events.subscribe(api.events.Event.TreeOpen, function()
  if vim.t['filetree_width'] ~= nil then
    local winid = api.tree.winid()
    vim.api.nvim_win_set_width(winid, vim.t['filetree_width']) 
  end
end)

-- Focus file in nvim-tree with <leader>e
vim.keymap.set('n', '<leader>e', function()
  api.tree.find_file({ open = true, focus = true })
end)
```

# Bulk paste marked files

[@Frankwii](https://www.github.com/Frankwii)

Got a workaround for pasting all marked files:

```lua
  local tree_api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'Tree: ' .. desc, buffer = bufnr , noremap = true, silent = true }
  end

  local bulk_paste = function()
    local marked_nodes = tree_api.marks.list()
    if next(marked_nodes) == nil then
      vim.api.nvim_echo({{"No nodes are marked to paste","None"}},false,{})
    else 
      for _, node in ipairs(marked_nodes) do
        tree_api.fs.copy.node(node)
        tree_api.fs.paste(tree_api.tree.get_node_under_cursor())
      end
      tree_api.fs.clear_clipboard()
    end
  end
  keymap('n', 'p',bulk_paste, opts('Paste marked files'))
```

# Change nvim's working directory with nvim-tree

[@Dumonu](https://github.com/Dumonu)

This `on_attach` function replaces the `change_root` keybinds to call local functions that also change nvim's working directory.

```lua
local function nvim_tree_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    local function change_root_to_node(node)
        if node == nil then
            node = api.tree.get_node_under_cursor()
        end

        if node ~= nil and node.type == "directory" then
            vim.api.nvim_set_current_dir(node.absolute_path)
        end
        api.tree.change_root_to_node(node)
    end

    local function change_root_to_parent(node)
        local abs_path
        if node == nil then
            abs_path = api.tree.get_nodes().absolute_path
        else
            abs_path = node.absolute_path
        end

        local parent_path = vim.fs.dirname(abs_path)
        vim.api.nvim_set_current_dir(parent_path)
        api.tree.change_root(parent_path)
    end

    vim.keymap.set('n', '<C-]>',          change_root_to_node,   opts('CD'))
    vim.keymap.set('n', '<2-RightMouse>', change_root_to_node,   opts('CD'))
    vim.keymap.set('n', '-',              change_root_to_parent, opts('Up'))
end
```

# Basic ARIA navigation (arrows and Vim keys)

[@the-citto](https://www.github.com/the-citto)

Set up for navigation with arrows (or `h`, `j`, `k`, `l`) and Enter, as found in several systems - turns out it has a name: 
[ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/treeitem_role#keyboard_interactions)

<table>
    <tr>
      <td><kbd>Right arrow</kbd></td>
      <td>
        <ul>
          <li>When focus is on a closed node, opens the node; focus does not move.</li>
          <li><s>When focus is on an open node, moves focus to the first child node.</s></li>
          <li>When focus is on an end node (a tree item with no children), does nothing.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><kbd>Left arrow</kbd></td>
      <td>
        <ul>
          <li>When focus is on an open node, closes the node.</li>
          <li>When focus is on a child node that is also either an end node or a closed node, moves focus to its parent node.</li>
          <li>When focus is on a closed tree, does nothing.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><kbd>Down Arrow</kbd></td>
      <td>Moves focus to the next node that is focusable without opening or closing a node.</td>
    </tr>
    <tr>
      <td><kbd>Up Arrow</kbd></td>
      <td>Moves focus to the previous node that is focusable without opening or closing a node.</td>
    </tr>
    <tr>
      <td><kbd>Enter</kbd></td>
      <td>Performs the default action of the currently focused node. For parent nodes, it opens or closes the node. In single-select trees, if the node has no children, selects the current node if not already selected (which is the default action).</td>
    </tr>
</table>

Up/k, Down/j, and Enter are already nvim-tree defaults; right/l from open node to first child is not implemented here (struck-through in the table above)

```lua
local api = require("nvim-tree.api")
require"nvim-tree".setup {
    on_attach = function (bufnr)
        local opts = { buffer = bufnr }
        api.config.mappings.default_on_attach(bufnr)
        -- function for left to assign to keybindings
        local lefty = function ()
            local node_at_cursor = api.tree.get_node_under_cursor()
            -- if it's a node and it's open, close
            if node_at_cursor.nodes and node_at_cursor.open then
                api.node.open.edit()
            -- else left jumps up to parent
            else
                api.node.navigate.parent()
            end
        end
        -- function for right to assign to keybindings
        local righty = function ()
            local node_at_cursor = api.tree.get_node_under_cursor()
            -- if it's a closed node, open it
            if node_at_cursor.nodes and not node_at_cursor.open then
                api.node.open.edit()
            end
        end
        vim.keymap.set("n", "h", lefty , opts )
        vim.keymap.set("n", "<Left>", lefty , opts )
        vim.keymap.set("n", "<Right>", righty , opts )
        vim.keymap.set("n", "l", righty , opts )
    end,

    -- actions, view, etc.
}
```

# Archived

Following are now core nvim-tree functionality, outdated or superseded.

## Silently open a new tab

> This functionality is now available via API:
> ```lua
> api.node.open.tab(node, { focus = false })
> ```

[@TroySigx](https://github.com/TroyCode3)

Sometimes, we only want to open a tab, but don't want to jump to that tab immediately.

```lua
local function open_tab_silent(node)
  local api = require("nvim-tree.api")

  api.node.open.tab(node)
  vim.cmd.tabprev()

end
```

## NERDTree Style Copy File To

> Superseded by [Copy / Move File To](./Recipes#copy--move-file-to)

[@mangelozzi nvim-tree config](https://github.com/mangelozzi/dotfiles/blob/master/.config/nvim/after/plugin/nvim-tree.lua)

The NERDTree way of copying files works like this:
1. Select the node in the tree
2. Activate copy file to
3. Edit the path to be the destination path of the copied file, you can use file completion to to aid entering in the new path.
4. It copies the file to the new path, and creates any parent dirs as required.

Below the `copy_file_to` function is bound to `c`, if you wish to use it in additional to the existing `c` function, you will have to map it to some other hotkey

```lua
local function copy_file_to()
    local node = api.tree.get_node_under_cursor()
    local file_src = node['absolute_path']
    -- The args of input are {prompt}, {default}, {completion}
    -- Read in the new file path using the existing file's path as the baseline.
    local file_out = vim.fn.input("COPY TO: ", file_src, "file")
    -- Create any parent dirs as required
    local dir = vim.fn.fnamemodify(file_out, ":h")
    vim.fn.system { 'mkdir', '-p', dir }
    -- Copy the file
    vim.fn.system { 'cp', '-R', file_src, file_out }
end
```

```lua
vim.keymap.set('n', 'c', copy_file_to, opts('Copy File To'))
```

## Format the root folder name to uppercase

> This may be achieved directly via setup option `:help nvim-tree.renderer.root_folder_label` e.g.
>
> ```lua
> root_folder_label = function(path)
>   return string.upper(vim.fn.fnamemodify(path, ":t"))
> end
> ```

[@Krystof2so](https://github.com/Krystof2so)

In `~/.config/nvim/lua/plugins/spec_functions/nvim_tree-functions.lua`:
```lua
local M = {} 
local tree_api = require("nvim-tree.api") 

-- *********************************************
-- * Format the root folder name to uppercase *
-- *********************************************
M.format_root_folder = function(path)
  -- Get the last component of the path (the folder name)
  local folder_name = vim.fn.fnamemodify(path, ":t") 
  
  -- Convert the folder name to uppercase and return it
  return string.upper(folder_name)
end

return M  
```

In `~/.config/nvim/lua/plugins/nvim-tree.lua` :
```lua
local nvim_tree_functions = require('plugins.spec_functions.nvim_tree_functions')
nv_tree = require("nvim-tree")


nv_tree.setup({
    renderer = { root_folder_label = nvim_tree_functions.format_root_folder, },
})
```
