A place for the community to share configurations and custom pickers that dont fit into core or an extension

## Table Of Contents

- [Mappings](#mappings)
  - [Mapping `<Esc>` to quit in insert mode](#mapping-esc-to-quit-in-insert-mode)
  - [Mapping `<C-u>` to clear prompt](#mapping-c-u-to-clear-prompt)
  - [Mapping `<C-d>` to delete buffer](#mapping-c-d-to-delete-buffer)
  - [Mapping `<C-s>/<C-a>` to cycle previewer for git commits to show full message](#mapping-c-sc-a-to-cycle-previewer-for-git-commits-to-show-full-message)
- [Layouts](#layouts)
  - [Fused Layout](#fused-layout)
- [Pickers](#pickers)
  - [File and text search in hidden files and directories](#file-and-text-search-in-hidden-files-and-directories)
  - [Falling back to find_files if git_files can't find a .git directory](#falling-back-to-find_files-if-git_files-cant-find-a-git-directory)
  - [Remove ./ from fd results](#remove--from-fd-results)
  - [Ripgrep Remove indentation](#ripgrep-remove-indentation)
  - [change directory](#change-directory)
  - [Live grep from project git root with fallback](#live-grep-from-project-git-root-with-fallback)
  - [Find files from project git root with fallback](#find-files-from-project-git-root-with-fallback)
  - [Find sibling files of current file](#find-sibling-files-of-current-file)
  - [Find files using Ag](#find-files-using-ag)
  - [Override `git_files` to use `jj`](#override-git-files-to-use-jj)
- [Previewer](#previewers)
  - [Disable highlighting for certain files](#disable-highlighting-for-certain-files)
  - [Ignore files bigger than a threshold](#ignore-files-bigger-than-a-threshold)
  - [Enable regex highlighting for certain filetypes](#enable-regex-highlighting-for-certain-filetypes)
  - [Dont preview binaries](#dont-preview-binaries)
  - [Use terminal image viewer to preview images](#use-terminal-image-viewer-to-preview-images)
- [Actions](#actions)
  - [Performing an arbitrary command by extending existing find_files picker](#performing-an-arbitrary-command-by-extending-existing-find_files-picker)
  - [Using nvim-window-picker to choose a target window when opening a file from any picker](#using-nvim-window-picker-to-choose-a-target-window-when-opening-a-file-from-any-picker)
- [Themes](#themes)
  - [Having two different themes and applying them selectively](#having-two-different-themes-and-applying-them-selectively)
- [Others](#others)
  - [Having a factory-like function based on a dict](#having-a-factory-like-function-based-on-a-dict)
  - [Customize buffers display to look like LeaderF](#customize-buffers-display-to-look-like-leaderf)
  - [Running external commands](#running-external-commands)
  - [Fuzzy search among YAML objects](#fuzzy-search-among-yaml-objects)

---

## Mappings

### Mapping `<Esc>` to quit in insert mode

If you'd prefer Telescope not to enter a normal-like mode when hitting escape (and instead exiting), you can map `<Esc>` to do so via:

```lua
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
```

### Mapping `<C-u>` to clear prompt

If you'd prefer Telescope to clear the prompt on `<C-u>` rather than scroll the previewer add the following to your config:

```lua
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false
      },
    },
  }
}
```

### Mapping `<C-d>` to delete buffer

If you would like to delete a buffer from picker without closing telescope.
For more information, you can check [Pull Request #828](https://github.com/nvim-telescope/telescope.nvim/pull/828).

```lua
local actions = require "telescope.actions"
require("telescope").setup {
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  }
}
```

### Add mapping to toggle the preview

If you want to add a mapping to toggle the previewer (when applicable), you can map it using the `toggle_preview` action.
For example, you can map `<M-p>` to do so via:

```lua
local action_layout = require("telescope.actions.layout")
require("telescope").setup{
  defaults = {
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview
      },
      i = {
        ["<M-p>"] = action_layout.toggle_preview
      },
    },
  }
}
```
### Mapping `<C-s>/<C-a>` to cycle previewer for git commits to show full message

```lua
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
  },
})
```

## Layouts

### Fused Layout

Requirements:
- [`nui.nvim`](https://github.com/MunifTanjim/nui.nvim).

<img width="1261" alt="Horizontal Fused Layout" src="https://github.com/nvim-telescope/telescope.nvim/assets/8050659/e1239201-d6b6-4e72-91f0-1a680269b0c1">

<details>

<summary>See Vertical and Minimal Fused Layout</summary>

<img width="764" alt="Vertical Fused Layout" src="https://github.com/nvim-telescope/telescope.nvim/assets/8050659/769d7cd7-1e58-4e12-9f86-3e20dfd423bf">

<img width="765" alt="Minimal Fused Layout" src="https://github.com/nvim-telescope/telescope.nvim/assets/8050659/eb5c43e5-a4b3-4c95-a990-67356a4b9939">

</details>

```lua
local Layout = require("nui.layout")
local Popup = require("nui.popup")

local telescope = require("telescope")
local TSLayout = require("telescope.pickers.layout")

local function make_popup(options)
  local popup = Popup(options)
  function popup.border:change_title(title)
    popup.border.set_text(popup.border, "top", title)
  end
  return TSLayout.Window(popup)
end

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        size = {
          width = "90%",
          height = "60%",
        },
      },
      vertical = {
        size = {
          width = "90%",
          height = "90%",
        },
      },
    },
    create_layout = function(picker)
      local border = {
        results = {
          top_left = "┌",
          top = "─",
          top_right = "┬",
          right = "│",
          bottom_right = "",
          bottom = "",
          bottom_left = "",
          left = "│",
        },
        results_patch = {
          minimal = {
            top_left = "┌",
            top_right = "┐",
          },
          horizontal = {
            top_left = "┌",
            top_right = "┬",
          },
          vertical = {
            top_left = "├",
            top_right = "┤",
          },
        },
        prompt = {
          top_left = "├",
          top = "─",
          top_right = "┤",
          right = "│",
          bottom_right = "┘",
          bottom = "─",
          bottom_left = "└",
          left = "│",
        },
        prompt_patch = {
          minimal = {
            bottom_right = "┘",
          },
          horizontal = {
            bottom_right = "┴",
          },
          vertical = {
            bottom_right = "┘",
          },
        },
        preview = {
          top_left = "┌",
          top = "─",
          top_right = "┐",
          right = "│",
          bottom_right = "┘",
          bottom = "─",
          bottom_left = "└",
          left = "│",
        },
        preview_patch = {
          minimal = {},
          horizontal = {
            bottom = "─",
            bottom_left = "",
            bottom_right = "┘",
            left = "",
            top_left = "",
          },
          vertical = {
            bottom = "",
            bottom_left = "",
            bottom_right = "",
            left = "│",
            top_left = "┌",
          },
        },
      }

      local results = make_popup({
        focusable = false,
        border = {
          style = border.results,
          text = {
            top = picker.results_title,
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      })

      local prompt = make_popup({
        enter = true,
        border = {
          style = border.prompt,
          text = {
            top = picker.prompt_title,
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      })

      local preview = make_popup({
        focusable = false,
        border = {
          style = border.preview,
          text = {
            top = picker.preview_title,
            top_align = "center",
          },
        },
      })

      local box_by_kind = {
        vertical = Layout.Box({
          Layout.Box(preview, { grow = 1 }),
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col" }),
        horizontal = Layout.Box({
          Layout.Box({
            Layout.Box(results, { grow = 1 }),
            Layout.Box(prompt, { size = 3 }),
          }, { dir = "col", size = "50%" }),
          Layout.Box(preview, { size = "50%" }),
        }, { dir = "row" }),
        minimal = Layout.Box({
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col" }),
      }

      local function get_box()
        local strategy = picker.layout_strategy
        if strategy == "vertical" or strategy == "horizontal" then
          return box_by_kind[strategy], strategy
        end

        local height, width = vim.o.lines, vim.o.columns
        local box_kind = "horizontal"
        if width < 100 then
          box_kind = "vertical"
          if height < 40 then
            box_kind = "minimal"
          end
        end
        return box_by_kind[box_kind], box_kind
      end

      local function prepare_layout_parts(layout, box_type)
        layout.results = results
        results.border:set_style(border.results_patch[box_type])

        layout.prompt = prompt
        prompt.border:set_style(border.prompt_patch[box_type])

        if box_type == "minimal" then
          layout.preview = nil
        else
          layout.preview = preview
          preview.border:set_style(border.preview_patch[box_type])
        end
      end

      local function get_layout_size(box_kind)
        return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
      end

      local box, box_kind = get_box()
      local layout = Layout({
        relative = "editor",
        position = "50%",
        size = get_layout_size(box_kind),
      }, box)

      layout.picker = picker
      prepare_layout_parts(layout, box_kind)

      local layout_update = layout.update
      function layout:update()
        local box, box_kind = get_box()
        prepare_layout_parts(layout, box_kind)
        layout_update(self, { size = get_layout_size(box_kind) }, box)
      end

      return TSLayout(layout)
    end,
  },
})
```

## Pickers

### File and text search in hidden files and directories

```lua
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})
```

### Falling back to find_files if git_files can't find a .git directory

```lua
-- telescope-config.lua
local M = {}

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

return M

-- call via:
-- :lua require"telescope-config".project_files()

-- example keymap:
-- vim.api.nvim_set_keymap("n", "<Leader><Space>", "<CMD>lua require'telescope-config'.project_files()<CR>", {noremap = true, silent = true})
```

Credits to [@Conni2461 for the project_files snippet](https://github.com/nvim-telescope/telescope.nvim/issues/410#issuecomment-765656002).

### Remove ./ from fd results

Require at least fd v0.8.3. Prior to this version there shouldn't be a `./`

```lua
require("telescope").setup {
  defaults = {
    -- ....
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  }
}
```

Credits to [@numToStr](https://github.com/nvim-telescope/telescope.nvim/pull/1532)

### ripgrep remove indentation

To trim the indentation at the beginning of presented line in the result window,
change the defaults like shown below:

```lua
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim" -- add this value
    }
  }
}
```

### Change directory

This is a snippet on how you can add change directory functionality to some pickers, like find files.

```lua
require("telescope").setup {
  defaults = {
    -- ....
  },
  pickers = {
    find_files = {
      mappings = {
        n = {
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent lcd %s", dir))
          end
        }
      }
    },
  }
}
```

Credits to [@ranjithshegde](https://github.com/nvim-telescope/telescope.nvim/pull/644)

### Live grep from project git root with fallback

```lua
function live_grep_from_project_git_root()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").live_grep(opts)
end
```

Credits to @wesbragagt

### Find files from project git root with fallback

This function is basically `find_files()` combined with `git_files()`. The appeal of this function over the default `find_files()` is that you can find files that are not tracked by git. Also, `find_files()` only finds files in the current directory but this function finds files regardless of your current directory as long as you're in the project directory.

```lua
function vim.find_files_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end
```

Credits to @wesbragagt for most of the code from [Live grep from project git root with fallback](#live-grep-from-project-git-root-with-fallback).

### Find sibling files of current file

This function is basically `find_files()` but only for the directory containing the file you're currently editing. So you don't have to open up `:Explore`, tree, or anything else to browse next to the current file.

```lua
vim.keymap.set('n', '<leader>.', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
```

### Find files using Ag

```lua
telescope.setup({
  pickers = {
    find_files = {
      find_command = {"ag", "--silent", "--nocolor", "--follow", "-g", "", "--literal", "--hidden","--ignore", ".git "},
    },
  },

})
```

### Override git files to use jj

If you use [jujutsu](https://github.com/martinvonz/jj), you can override the `git_files` builtin picker to use `jj` instead of git.

```lua
local function jj_files()
  require("telescope.builtin").git_files {
    prompt_title = "jj Files",
    git_command = { "jj", "file", "list", "--no-pager" },
  }
end
```

## Previewers

### Disable highlighting for certain files

```lua
local previewers = require("telescope.previewers")

local _bad = { ".*%.csv", ".*%.lua" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require("telescope").setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}
```

Credit: @Conni2461

### Ignore files bigger than a threshold

```lua
require("telescope").setup {
  defaults = {
    preview = {
        filesize_limit = 0.1, -- MB
    },
  }
}
```

### Enable regex highlighting for certain filetypes

```lua
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local pfiletype = require("plenary.filetype")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then
    local ft = pfiletype.detect(filepath)
    -- Here for example you can say: if ft == "xyz" then this_regex_highlighing else nothing end
    opts.use_ft_detect = false
    putils.regex_highlighter(bufnr, ft)
  end
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require("telescope").setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}
```

Credit: @Conni2461

### Dont preview binaries

```lua
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

require("telescope").setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}
```

Credit: @Conni2461

### Use terminal image viewer to preview images

It is possible to use a terminal image viewer such as [catimg](https://github.com/posva/catimg) to preview images in telescope.

```lua
require("telescope").setup {
  defaults = {
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = {'png','jpg'}   -- Supported image formats
          local split_path = vim.split(filepath:lower(), '.', {plain=true})
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _ )
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d..'\r\n')
            end
          end
          vim.fn.jobstart(
            {
              'catimg', filepath  -- Terminal image viewer command
            }, 
            {on_stdout=send_output, stdout_buffered=true, pty=true})
        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end
    },
  }
}
```

Credit: @matheustavarestrindade

### Fast image preview on terminal with caching using chafa.

It is possible to use a terminal image viewer such as [chafa](https://github.com/hpjansson/chafa) to preview images in telescope.

```lua
            local previewers = require("telescope.previewers")
            local image_cache = {}

            local function render_image(filepath, max_width, callback)
                local key = filepath .. "|w" .. max_width

                if image_cache[key] then
                    callback(image_cache[key])
                    return
                end

                vim.fn.jobstart({
                    "chafa",
                    "--size", tostring(max_width) .. "x", -- x lets chafa pick height automatically
                    filepath
                }, {
                    stdout_buffered = true,
                    on_stdout = function(_, data, _)
                        if not data then return end
                        local output = table.concat(data, "\r\n")
                        image_cache[key] = output
                        callback(output)
                    end
                })
            end

            local function image_preview(filepath, bufnr, opts)
                local ext = vim.fn.fnamemodify(filepath, ":e"):lower()
                local is_image = vim.tbl_contains({ "png", "jpg", "jpeg", "webp", "svg" }, ext)

                if is_image then
                    local term = vim.api.nvim_open_term(bufnr, {})

                    -- Schedule to wait until buffer is displayed
                    vim.schedule(function()
                        local winid = vim.fn.bufwinid(bufnr)
                        if winid == -1 then
                            -- fallback to default width if window not ready yet
                            winid = 0
                        end

                        local width = vim.api.nvim_win_get_width(winid) - 2
                        if width < 10 then width = 40 end -- sanity min width

                        render_image(filepath, width, function(output)
                            vim.api.nvim_chan_send(term, output)
                        end)
                    end)
                else
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                end
            end


            require("telescope").setup({
                defaults = {
                    buffer_previewer_maker = image_preview,
                }
            })
```


## Actions

### Performing an arbitrary command by extending existing find_files picker

```lua
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    vim.cmd([[!git log ]]..selection[1])
  end)
  return true
end

M.git_log = function()
  -- example for running a command on a file
  local opts = {
    attach_mappings = run_selection
  }
  require('telescope.builtin').find_files(opts)
end
return M
```

### Using [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker) to choose a target window when opening a file from any picker.

```lua
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-g>'] = function(prompt_bufnr)
          -- Use nvim-window-picker to choose the window by dynamically attaching a function
          local action_set = require('telescope.actions.set')
          local action_state = require('telescope.actions.state')

          local picker = action_state.get_current_picker(prompt_bufnr)
          picker.get_selection_window = function(picker, entry)
            local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
            -- Unbind after using so next instance of the picker acts normally
            picker.get_selection_window = nil
            return picked_window_id
          end

          return action_set.edit(prompt_bufnr, 'edit')
        end,
      },
    }
  }
}
```

## Themes

### Having two different themes and applying them selectively.

```lua
-- in lua/finders.lua
local finders = {}

-- Dropdown list theme using a builtin theme definitions :
local center_list = require"telescope.themes".get_dropdown({
  winblend = 10,
  width = 0.5,
  prompt = " ",
  results_height = 15,
  previewer = false,
})

-- Settings for with preview option
local with_preview = {
  winblend = 10,
  show_line = false,
  results_title = false,
  preview_title = false,
  layout_config = {
    preview_width = 0.5,
  },
}

-- Find in neovim config with center theme
finders.fd_in_nvim = function()
  local opts = vim.deepcopy(center_list)
  opts.prompt_prefix = "Nvim>"
  opts.cwd = vim.fn.stdpath("config")
  require"telescope.builtin".fd(opts)
end

-- Find files with_preview settings
function fd()
  local opts = vim.deepcopy(with_preview)
  opts.prompt_prefix = "FD>"
  require"telescope.builtin".fd(opts)
end

return finders

-- make sure to map it:
-- nnoremap <leader>ff :lua require"finders".fd_in_nvim()<cr>
-- nnoremap <leader>ff :lua require"finders".fd()<cr>
```

## Others

### Having a factory-like function based on a dict

```lua
local center_list  -- check the above snippet
local with_preview -- check the above snippet
local main = {}
local telescopes = {
  fd_nvim = {
    prompt_prefix = "Nvim>",
    fun = "fd",
    theme = center_list,
    cwd = vim.fn.stdpath("config")
    -- .. other options
  }
  fd = {
    prompt_prefix = "Files>",
    fun = "fd",
    theme = with_preview,
    -- .. other options
  }
}

main.run = function(str, theme)
  local base, fun, opts
  if not telescopes[str] then
    fun = str
    opts = theme or {}
    --return print("Sorry not found")
  else
    base = telescopes[str]
    fun = base.fun; theme = base.theme
    base.theme = nil; base.fun = nil
    opts = vim.tbl_extend("force", theme, base)
  end
  if str then
    return require"telescope.builtin"[fun](opts)
  else
    return print("You need to a set a default function")
    -- return require"telescope.builtin".find_files(opts)
  end
end

return main
-- make sure to map it:
-- nnoremap <leader>ff :lua require"main".run("fd")<cr>
-- nnoremap <leader>ff :lua require"main".run("fd_in_nvim")<cr>
```

### Customize buffers display to look like LeaderF

<div style="text-align:center"><img alt="telescope_like_leaderf" src="https://user-images.githubusercontent.com/16581287/103161563-1a791780-4827-11eb-8fe5-a808d05f315b.png"></div>

```lua
-- In: lua/rc/telescope/my_make_entry.lua
local my_make_entry = {}

local devicons = require"nvim-web-devicons"
local entry_display = require("telescope.pickers.entry_display")

local filter = vim.tbl_filter
local map = vim.tbl_map

function my_make_entry.gen_from_buffer_like_leaderf(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon("file", "", {default = true})

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr = math.max(unpack(bufnrs))
  local bufnr_width = #tostring(max_bufnr)

  local max_bufname = math.max(
    unpack(
      map(function(bufnr)
        return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
      end, bufnrs)
    )
  )

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = bufnr_width },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      {entry.bufnr, "TelescopeResultsNumber"},
      {entry.indicator, "TelescopeResultsComment"},
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
    }
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
    local hidden = entry.info.hidden == 1 and "h" or "a"
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
    local changed = entry.info.changed == 1 and "+" or " "
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
    local file_name = vim.fn.fnamemodify(bufname, ":p:t")

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

return my_make_entry


-- Use in telescope buffers

require("telescope.builtin").buffers({
  -- ...
  entry_maker = require"vimrc.telescope.my_make_entry".gen_from_buffer_like_leaderf(),
})
```

Credit: @elianiva

### Running external commands

```lua
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")

pickers.new {
  results_title = "Resources",
  -- Run an external command and show the results in the finder window
  finder = finders.new_oneshot_job({"terraform", "show"}),
  sorter = sorters.get_fuzzy_file(),
  previewer = previewers.new_buffer_previewer {
    define_preview = function(self, entry, status)
       -- Execute another command using the highlighted entry
      return require('telescope.previewers.utils').job_maker(
          {"terraform", "state", "list", entry.value},
          self.state.bufnr,
          {
            callback = function(bufnr, content)
              if content ~= nil then
                require('telescope.previewers.utils').regex_highlighter(bufnr, 'terraform')
              end
            end,
          })
    end
  },
}:find()
```

### Fuzzy search among YAML objects

Utilizes treesitter. Let's imagine you have such a structure

```yaml
services:
  database:
    volumes:
....
```

Telescope will have entries:

```
services
services.database
services.database.volumes
```

So you can jump to any of them

```lua
local pickers = require("telescope.pickers")
local conf = require('telescope.config').values
local finders = require("telescope.finders")

local function visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
    local key = ''
    if node:type() == "block_mapping_pair" then
        local field_key = node:field("key")[1]
        key = vim.treesitter.query.get_node_text(field_key, bufnr)
    end

    if key ~= nil and string.len(key) > 0 then
        table.insert(yaml_path, key)
        local line, col = node:start()
        table.insert(result, {
            lnum = line + 1,
            col = col + 1,
            bufnr = bufnr,
            filename = file_path,
            text = table.concat(yaml_path, '.'),
        })
    end

    for node, name in node:iter_children() do
        visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
    end

    if key ~= nil and string.len(key) > 0 then
        table.remove(yaml_path, table.maxn(yaml_path))
    end
end

local function gen_from_yaml_nodes(opts)
    local displayer = entry_display.create {
        separator = " │ ",
        items = {
            { width = 5 },
            { remaining = true },
        },
    }

    local make_display = function(entry)
        return displayer {
            { entry.lnum, "TelescopeResultsSpecialComment" },
            { entry.text, function() return {} end },
        }
    end

    return function(entry)
        return make_entry.set_default_entry_mt({
            ordinal = entry.text,
            display = make_display,
            filename = entry.filename,
            lnum = entry.lnum,
            text = entry.text,
            col = entry.col,
        }, opts)
    end
end

local yaml_symbols = function(opts)
    local yaml_path = {}
    local result = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
    local tree = vim.treesitter.get_parser(bufnr, ft):parse()[1]
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    local root = tree:root()
    for node, name in root:iter_children() do
        visit_yaml_node(node, name, yaml_path, result, file_path, bufnr)
    end

  -- return result
  pickers.new(opts, {
      prompt_title = "YAML symbols",
      finder = finders.new_table {
          results = result,
          entry_maker = opts.entry_maker or gen_from_yaml_nodes(opts),
      },
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
  })
  :find()
end
```