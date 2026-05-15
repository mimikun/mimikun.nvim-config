Welcome to the neo-tree.nvim wiki!

This is a place to share configuration recipes for functionality that others may want to copy or learn from.

## Commands ##

### Switch between `filesystem`, `buffers` and `git_status`

```lua
require('neo-tree').setup({
  window = {
    mappings = {
      ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
      ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
      ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
    },
  },
})
```

Or add global mapping for toggling (LazyVim example):

```lua
    keys = {
      {
        "<leader>r",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "buffers",
            position = "left",
          })
        end,
        desc = "Buffers (root dir)",
      },
    },
```

### Open with System Viewer

Thanks to [@wavded](https://github.com/wavded) for this recipe! This command will allow you to open a file or directory using the OS default viewer. This example is for macOS and Linux, but you should be able to adapt it to another OS easily:

```lua
require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["o"] = "system_open",
      },
    },
  },
  commands = {
    system_open = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      -- macOs: open file in default application in the background.
      vim.fn.jobstart({ "open", path }, { detach = true })
      -- Linux: open file in default application
      vim.fn.jobstart({ "xdg-open", path }, { detach = true })

  -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
  local p
  local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
  if lastSlashIndex then
  	p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
  else
  	p = path -- If no slash found, return original path
      end
  vim.cmd("silent !start explorer " .. p)
    end,
  },
})
``` 

### Open and Clear Search ###
Sometimes you may want to add a filter and leave that way because the filter captures the files you want to work on now. Other times you may just be using the filter as a quick way to find a file you want to open. In the latter case, you may want to clear the search when you open that file. This custom command offers that choice:

```lua
require("neo-tree").setup({
  popup_border_style = "NC",
  filesystem = {
    window = {
      mappings = {
        ["o"] = "open_and_clear_filter"
      },
    },
  },
  commands = {
    open_and_clear_filter = function (state)
      local node = state.tree:get_node()
      if node and node.type == "file" then
        local file_path = node:get_id()
        -- reuse built-in commands to open and clear filter
        local cmds = require("neo-tree.sources.filesystem.commands")
        cmds.open(state)
        cmds.clear_filter(state)
        -- reveal the selected file without focusing the tree
        require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
      end
    end,
  }
})
```

### Run Command

Similar to the '.' command in nvim-tree. Primes the ":" command with the full path of the chosen node.

```lua
require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["i"] = "run_command",
      },
    },
  },
  commands = {
    run_command = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      vim.api.nvim_input(": " .. path .. "<Home>")
    end,
  },
})
``` 

### Find with telescope

Find/grep for a file under the current node using Telescope and select it.

```lua
local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function (prompt_bufnr, map)
      local actions = require "telescope.actions"
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require "telescope.actions.state"
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if (filename == nil) then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end
  }
end
require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["tf"] = "telescope_find",
        ["tg"] = "telescope_grep",
      },
    },
  },
  commands = {
    telescope_find = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      require('telescope.builtin').find_files(getTelescopeOpts(state, path))
    end,
    telescope_grep = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
    end,
  },
})
```

### Trash (macOS)

Move the current item or all selections to the Trash bin and support "put back" feature.

Requirement: `brew install trash`

```lua
local inputs = require("neo-tree.ui.inputs")

-- Trash the target
local function trash(state)
	local node = state.tree:get_node()
	if node.type == "message" then
		return
	end
	local _, name = require("neo-tree.utils").split_path(node.path)
	local msg = string.format("Are you sure you want to trash '%s'?", name)
	inputs.confirm(msg, function(confirmed)
		if not confirmed then
			return
		end
		vim.api.nvim_command("silent !trash -F " .. node.path)
		require("neo-tree.sources.manager").refresh(state)
	end)
end

-- Trash the selections (visual mode)
local function trash_visual(state, selected_nodes)
	local paths_to_trash = {}
	for _, node in ipairs(selected_nodes) do
		if node.type ~= "message" then
			table.insert(paths_to_trash, node.path)
		end
	end
	local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
	inputs.confirm(msg, function(confirmed)
		if not confirmed then
			return
		end
		for _, path in ipairs(paths_to_trash) do
			vim.api.nvim_command("silent !trash -F " .. path)
		end
		require("neo-tree.sources.manager").refresh(state)
	end)
end

require("neo-tree").setup({
	window = {
		mappings = {
			["T"] = "trash",
		},
	},
	commands = {
		trash = trash,
		trash_visual = trash_visual,
	},
})
```

### [Vscode](https://github.com/antfu/vscode-file-nesting-config/tree/main) like File Nesting

```lua
-- lazy.nvim
{
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      -- Others dependencies
      'saifulapm/neotree-file-nesting-config', -- add plugin as dependency. no need any other config or setup call
    },
    opts = {
      -- recommanded config for better UI
      hide_root_node = true,
      retain_hidden_root_indent = true,
      filesystem = {
        filtered_items = {
          show_hidden_count = false,
          never_show = {
            '.DS_Store',
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
        },
      },
      -- others config
    },
    config = function(_, opts)
      -- Adding rules from plugin
      opts.nesting_rules = require('neotree-file-nesting-config').nesting_rules
      require('neo-tree').setup(opts)
    end,
}
```

### Diff files

Credits to @mwpardue. You can mark two files to diff them.
```lua
require('neo-tree').setup({
  window = {
    mappings = {
      ['D'] = "diff_files"
    }
  }
})
diff_files = function(state)
  local node = state.tree:get_node()
  local log = require("neo-tree.log")
  state.clipboard = state.clipboard or {}
  if diff_Node and diff_Node ~= tostring(node.id) then
    local current_Diff = node.id
    require("neo-tree.utils").open_file(state, diff_Node, open)
    vim.cmd("vert diffs " .. current_Diff)
    log.info("Diffing " .. diff_Name .. " against " .. node.name)
    diff_Node = nil
    current_Diff = nil
    state.clipboard = {}
    require("neo-tree.ui.renderer").redraw(state)
  else
    local existing = state.clipboard[node.id]
    if existing and existing.action == "diff" then
      state.clipboard[node.id] = nil
      diff_Node = nil
      require("neo-tree.ui.renderer").redraw(state)
    else
      state.clipboard[node.id] = { action = "diff", node = node }
      diff_Name = state.clipboard[node.id].node.name
      diff_Node = tostring(state.clipboard[node.id].node.id)
      log.info("Diff source file " .. diff_Name)
      require("neo-tree.ui.renderer").redraw(state)
    end
  end
end,
```

### Emulating Vim's fold commands

Make the neo-tree window respond in reasonable ways to fold commands. Many of
the commands under "Opening and Closing Folds" in `:h fold-commands` are
emulated. Here is a non-exhaustive list of examples:

| command | description |
| ---     | --- |
| `zo`    | open a directory |
| `2zo`   | recursively open two levels of directories |
| `zO`    | recursively open a directory and all its children |
| `zc`    | close a directory |
| `zr`    | increase depthlevel (like `foldlevel`), open all folders to the depthlevel, and close all folders beyond it |
| `2zm`   | decrease the depthlevel by 2, then open or close folders appropriately |
| `zR`    | open all directories and set the foldlevel to the deepest directory |


<details>
<summary>Implementation</summary>

```lua

local renderer = require "neo-tree.ui.renderer"

-- Expand a node and load filesystem info if needed.
local function open_dir(state, dir_node)
  local fs = require "neo-tree.sources.filesystem"
  fs.toggle_directory(state, dir_node, nil, true, false)
end

-- Expand a node and all its children, optionally stopping at max_depth.
local function recursive_open(state, node, max_depth)
  local max_depth_reached = 1
  local stack = { node }
  while next(stack) ~= nil do
    node = table.remove(stack)
    if node.type == "directory" and not node:is_expanded() then
      open_dir(state, node)
    end

    local depth = node:get_depth()
    max_depth_reached = math.max(depth, max_depth_reached)

    if not max_depth or depth < max_depth - 1 then
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end
    end
  end

  return max_depth_reached
end

--- Open the fold under the cursor, recursing if count is given.
local function neotree_zo(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  renderer.redraw(state)
end

--- Recursively open the current folder and all folders it contains.
local function neotree_zO(state)
  neotree_zo(state, true)
end

-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2

--- Close the node and its parents, optionally stopping at max_depth.
local function recursive_close(state, node, max_depth)
  if max_depth == nil or max_depth <= MIN_DEPTH then
    max_depth = MIN_DEPTH
  end

  local last = node
  while node and node:get_depth() >= max_depth do
    if node:has_children() and node:is_expanded() then
      node:collapse()
    end
    last = node
    node = state.tree:get_node(node:get_parent_id())
  end

  return last
end

--- Close a folder, or a number of folders equal to count.
local function neotree_zc(state, close_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  local max_depth
  if not close_all then
    max_depth = node:get_depth() - vim.v.count1
    if node:has_children() and node:is_expanded() then
      max_depth = max_depth + 1
    end
  end

  local last = recursive_close(state, node, max_depth)
  renderer.redraw(state)
  renderer.focus_node(state, last:get_id())
end

-- Close all containing folders back to the top level.
local function neotree_zC(state)
  neotree_zc(state, true)
end

--- Open a closed folder or close an open one, with an optional count.
local function neotree_za(state, toggle_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  if node.type == "directory" and not node:is_expanded() then
    neotree_zo(state, toggle_all)
  else
    neotree_zc(state, toggle_all)
  end
end

--- Recursively close an open folder or recursively open a closed folder.
local function neotree_zA(state)
  neotree_za(state, true)
end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local function set_depthlevel(state, depthlevel)
  if depthlevel < MIN_DEPTH then
    depthlevel = MIN_DEPTH
  end

  local stack = state.tree:get_nodes()
  while next(stack) ~= nil do
    local node = table.remove(stack)

    if node.type == "directory" then
      local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
      if should_be_open and not node:is_expanded() then
        open_dir(state, node)
      elseif not should_be_open and node:is_expanded() then
        node:collapse()
      end
    end

    local children = state.tree:get_nodes(node:get_id())
    for _, v in ipairs(children) do
      table.insert(stack, v)
    end
  end

  vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local function redraw_after_depthlevel_change(state, stay)
  local node = state.tree:get_node()

  if stay then
    require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
  else
    -- Find the closest parent that is still visible.
    local parent = state.tree:get_node(node:get_parent_id())
    while not parent:is_expanded() and parent:get_depth() > 1 do
      node = parent
      parent = state.tree:get_node(node:get_parent_id())
    end
  end

  renderer.redraw(state)
  renderer.focus_node(state, node:get_id())
end

--- Update all open/closed folders by depthlevel, then reveal current node.
local function neotree_zx(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, true)
end

--- Update all open/closed folders by depthlevel.
local function neotree_zX(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse more folders: decrease depthlevel by 1 or count.
local function neotree_zm(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel - vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse all folders. Set depthlevel to MIN_DEPTH.
local function neotree_zM(state)
  set_depthlevel(state, MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Expand more folders: increase depthlevel by 1 or count.
local function neotree_zr(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel + vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Expand all folders. Set depthlevel to the deepest node level.
local function neotree_zR(state)
  local top_level_nodes = state.tree:get_nodes()

  local max_depth = 1
  for _, node in ipairs(top_level_nodes) do
    max_depth = math.max(max_depth, recursive_open(state, node))
  end

  vim.b.neotree_depthlevel = max_depth
  redraw_after_depthlevel_change(state, false)
end

neotree.setup {
  filesystem = {
    window = {
      mappings = {
        ["z"] = "none",

        ["zo"] = neotree_zo,
        ["zO"] = neotree_zO,
        ["zc"] = neotree_zc,
        ["zC"] = neotree_zC,
        ["za"] = neotree_za,
        ["zA"] = neotree_zA,
        ["zx"] = neotree_zx,
        ["zX"] = neotree_zX,
        ["zm"] = neotree_zm,
        ["zM"] = neotree_zM,
        ["zr"] = neotree_zr,
        ["zR"] = neotree_zR,
      },
    },
  },
}
```
</details>

For alternate implementations, as well as commands for `]z`, `[z`, `zj`, and `zk`, see discussion [#368](https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/368).

## Components

Components are the blocks of text that get rendered for an item in the tree. Built-in components include things like "icon", "name", or "git_status". Adding a custom component involves two steps: defining a function to implement that component, and then using that component in a renderer.

### Custom Icons

If you want to override any built-in component, just add a component in your config with the same name. The example below is copied from the default icon component, which you can override to add your own special handling. 

If you want to add custom icons based on a file or directory name, you can access a node's name with `node.name`, and the full path with `node.get_id()` or `node.path`.

```lua
      local highlights = require("neo-tree.ui.highlights")

      require("neo-tree").setup({
        filesystem = {
          components = {
            icon = function(config, node, state)
              local icon = config.default or " "
              local padding = config.padding or " "
              local highlight = config.highlight or highlights.FILE_ICON

              if node.type == "directory" then
                highlight = highlights.DIRECTORY_ICON
                if node:is_expanded() then
                  icon = config.folder_open or "-"
                else
                  icon = config.folder_closed or "+"
                end
              elseif node.type == "file" then
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                if success then
                  local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                  icon = devicon or icon
                  highlight = hl or highlight
                end
              end

              return {
                text = icon .. padding,
                highlight = highlight,
              }
            end,
      })

```


### Harpoon Index

![Neo-tree with harpoon index](https://github.com/nvim-neo-tree/resources/raw/main/images/Neo-tree-harpoon-component.png)

This example adds the index number of a file that has been marked with [Harpoon](https://github.com/ThePrimeagen/harpoon):

```lua
require("neo-tree").setup({
  filesystem = {
    components = {
      harpoon_index = function(config, node, _)
        local harpoon_list = require("harpoon"):list()
        local path = node:get_id()
        local harpoon_key = vim.uv.cwd()

        for i, item in ipairs(harpoon_list.items) do
          local value = item.value
          if string.sub(item.value, 1, 1) ~= "/" then
            value = harpoon_key .. "/" .. item.value
          end

          if value == path then
            vim.print(path)
            return {
              text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
              highlight = config.highlight or "NeoTreeDirectoryIcon",
            }
          end
        end
        return {}
      end,
    },
    renderers = {
      file = {
        { "icon" },
        { "name", use_git_status_colors = true },
        { "harpoon_index" }, --> This is what actually adds the component in where you want it
        { "diagnostics" },
        { "git_status", highlight = "NeoTreeDimText" },
      },
    },
  },
})
```

Alternative version if above does not work:

```lua
require("neo-tree").setup({
  filesystem = {
    components = {
      harpoon_index = function(config, node, _)
        local Marked = require("harpoon.mark")
        local path = node:get_id()
        local success, index = pcall(Marked.get_index_of, path)
        if success and index and index > 0 then
          return {
            text = string.format("%d ", index), -- <-- Add your favorite harpoon like arrow here
            highlight = config.highlight or "NeoTreeDirectoryIcon",
          }
        else
          return {
            text = "  ",
          }
        end
      end,
    },
    renderers = {
      file = {
        { "icon" },
        { "name", use_git_status_colors = true },
        { "harpoon_index" }, --> This is what actually adds the component in where you want it
        { "diagnostics" },
        { "git_status", highlight = "NeoTreeDimText" },
      },
    },
  },
})
```

## Events

### Auto Close on Open File

This example uses the `file_open` event to close the Neo-tree window when a file is opened through Neo-tree. This applies to all windows and all sources at once.

```lua
      require("neo-tree").setup({
        event_handlers = {

          {
            event = "file_open_requested",
            handler = function()
              -- auto close
              -- vim.cmd("Neotree close")
              -- OR
              require("neo-tree.command").execute({ action = "close" })
            end
          },

        }
      })
```

### Clear Search after Opening File

**NOTE:** This is no longer necessary as of v1.28. You can now use the `"fuzzy_finder"` command instead, which will clear the search after a file is opened.

If you want to use the search feature as a fuzzy finder rather than a sticky filter, you may want to clear the search as soon as a file is chosen. One way to handle that was shown above with a custom command, but you could also handle that in a more universal way by handling the "file_opened" event:

```lua
      require("neo-tree").setup({
        event_handlers = {

          {
            event = "file_opened",
            handler = function(file_path)
              require("neo-tree.sources.filesystem").reset_search(state)
            end
          },

        }
      })
```

### Equalize Window Sizes on Neo-tree Open and Close

This is a simple solution that will run `wincmd =` every time a Neo-tree window is opened or closed. This solves the problem discussed in issue [#476](https://github.com/nvim-neo-tree/neo-tree.nvim/issues/476) for simple layouts. This example also shows the usage of the `args` argument to ensure that the window is a left or right sidebar first, because this is not so much of an issue for a bottom window. 

For more advanced scenarios that try to take into account the window layout before the window is opened or closed, there are corresponding `before` versions of these events.

```lua
require("neo-tree").setup({
  event_handlers = {
    --{
    --  event = "neo_tree_window_before_open",
    --  handler = function(args)
    --    print("neo_tree_window_before_open", vim.inspect(args))
    --  end
    --},
    {
      event = "neo_tree_window_after_open",
      handler = function(args)
        if args.position == "left" or args.position == "right" then
          vim.cmd("wincmd =")
        end
      end
    },
    --{
    --  event = "neo_tree_window_before_close",
    --  handler = function(args)
    --    print("neo_tree_window_before_close", vim.inspect(args))
    --  end
    --},
    {
      event = "neo_tree_window_after_close",
      handler = function(args)
        if args.position == "left" or args.position == "right" then
          vim.cmd("wincmd =")
        end
      end
    }
  }
})
```


### Handle Rename or Move File Event
If you want to take some custom action after a file has been renamed, you can handle the `"file_renamed"` in your config and add your code to the handler. The most obvious use for this would be to cleanup references to that file within your project.

**The simple way to accomplish this is to install [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations), which will automatically wire up these events for you.**

For a working example of how to do this manually with typescript, see: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/308#issuecomment-1304765940

Here is the general format to use to write your own handler:

```lua
require("neo-tree").setup({
  event_handlers = {
    {
      event = "file_renamed",
      handler = function(args)
        -- fix references to file
        print(args.source, " renamed to ", args.destination)
      end
    },
    {
      event = "file_moved",
      handler = function(args)
        -- fix references to file
        print(args.source, " moved to ", args.destination)
      end
    },
  }
})
```

### Custom Window Chooser for File Open commands

If you want to change the logic for where to open a file when using the built-in `"open"`, `"open_split"`, and `"open_vsplit"` commands, the way to do that is by handling the "file_open_requested" event. Below is an example which includes the default logic used by Neo-tree.

**NOTE:** If you do open the file successfully, you must return `{ handled = true }` to prevent the next handler from opening the file again. If there are situations where you **do** want to pass it back to the built-in logic to be handled, return `{ handled = false }`.

```lua
require("neo-tree").setup({
  event_handlers = {
    {
      event = "file_open_requested",
      handler = function(args)
        local state = args.state
        local path = args.path
        local open_cmd = args.open_cmd or "edit"

        -- use last window if possible
        local suitable_window_found = false
        local nt = require("neo-tree")
        if nt.config.open_files_in_last_window then
          local prior_window = nt.get_prior_window()
          if prior_window > 0 then
            local success = pcall(vim.api.nvim_set_current_win, prior_window)
            if success then
              suitable_window_found = true
            end
          end
        end

        -- find a suitable window to open the file in
        if not suitable_window_found then
          if state.window.position == "right" then
            vim.cmd("wincmd t")
          else
            vim.cmd("wincmd w")
          end
        end
        local attempts = 0
        while attempts < 4 and vim.bo.filetype == "neo-tree" do
          attempts = attempts + 1
          vim.cmd("wincmd w")
        end
        if vim.bo.filetype == "neo-tree" then
          -- Neo-tree must be the only window, restore it's status as a sidebar
          local winid = vim.api.nvim_get_current_win()
          local width = require("neo-tree.utils").get_value(state, "window.width", 40)
          vim.cmd("vsplit " .. path)
          vim.api.nvim_win_set_width(winid, width)
        else
          vim.cmd(open_cmd .. " " .. path)
        end

        -- If you don't return this, it will proceed to open the file using built-in logic.
        return { handled = true }
      end
    },
  },
})
```

### Hide Cursor in Neo-tree Window

This recipe will hide the cursor completely so you only see the full line highlight.

``` lua
require("neo-tree").setup({
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.cmd("highlight! Cursor blend=100")
      end,
    },
    {
      event = "neo_tree_buffer_leave",
      handler = function()
        vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
      end,
    },
  },
})
```

### Merge Source Selector in Tabline (Eg bufferline.nvim)

Thanks to the fact that the same decorations can be used for winbar and tabline (what plugins like bufferline.nvim uses to display the buffers on the top line), we can merge neo-tree's source selector into those plugins it they support a `raw`-like field.

See https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1368 for more details.

![image](https://github.com/nvim-neo-tree/neo-tree.nvim/assets/41065736/6821026b-02e8-4c31-bd51-62226da423e1)

```lua
-- neo-tree
-- require("neo-tree").setup({
    event_handlers = {
      {
        event = "after_render",
        handler = function(state)
          if state.current_position == "left" or state.current_position == "right" then
            vim.api.nvim_win_call(state.winid, function()
              local str = require("neo-tree.ui.selector").get()
              if str then
                _G.__cached_neo_tree_selector = str
              end
            end)
          end
        end,
      },
    }
-- end

-- bufferline
_G.__cached_neo_tree_selector = nil
_G.__get_selector = function()
  return _G.__cached_neo_tree_selector
end

-- require("bufferline.nvim").setup({
    options = {
      offsets = {
        {
          filetype = "neo-tree",
          raw = " %{%v:lua.__get_selector()%} ",
          highlight = { sep = { link = "WinSeparator" } },
          separator = "┃",
        },
      },
-- end
```

### Automatically Show Source Preview

This recipe will automatically show the preview of whatever source you are looking at (file in filesystem, buffer in buffers, etc).

``` lua
require("neo-tree").setup({
  event_handlers = {
    {
      event = "after_render",
      handler = function(state)
        if not require("neo-tree.sources.common.preview").is_active() then
          state.config = { use_float = true }
          state.commands.toggle_preview(state)
        end
      end,
    },
  },
})
```
