## 🚀 Examples

### `flash`

```lua
{
  "folke/flash.nvim",
  optional = true,
  specs = {
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          win = {
            input = {
              keys = {
                ["<a-s>"] = { "flash", mode = { "n", "i" } },
                ["s"] = { "flash" },
              },
            },
          },
          actions = {
            flash = function(picker)
              require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                  mode = "search",
                  exclude = {
                    function(win)
                      return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                    end,
                  },
                },
                action = function(match)
                  local idx = picker.list:row2idx(match.pos[1])
                  picker.list:_move(idx, true, true)
                end,
              })
            end,
          },
        },
      },
    },
  },
}
```

### `general`

```lua
{
  "folke/snacks.nvim",
  opts = {
    picker = {},
    explorer = {},
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- gh
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  },
}
```

### `todo_comments`

```lua
{
  "folke/todo-comments.nvim",
  optional = true,
  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
  },
}
```

### `trouble`

```lua
{
  "folke/trouble.nvim",
  optional = true,
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
}
```

## 📚 Types

```lua
---@class snacks.picker.resume.Opts
---@field source? string
---@field include? string[]
---@field exclude? string[]
```

```lua
---@class snacks.picker.jump.Action: snacks.picker.Action
---@field cmd? snacks.picker.EditCmd
```

```lua
---@class snacks.picker.layout.Action: snacks.picker.Action
---@field layout? snacks.picker.layout.Config|string
```

```lua
---@class snacks.picker.yank.Action: snacks.picker.Action
---@field reg? string
---@field field? string
---@field notify? boolean
```

```lua
---@class snacks.picker.insert.Action: snacks.picker.Action
---@field expr string
```

```lua
---@alias snacks.picker.format.resolve fun(max_width:number):snacks.picker.Highlight[]
---@alias snacks.picker.Extmark vim.api.keyset.set_extmark|{col:number, row?:number, field?:string}
---@alias snacks.picker.Meta {[string]:any}
---@alias snacks.picker.Text {[1]:string, [2]:(string|string[])?, virtual?:boolean, field?:string, resolve?:snacks.picker.format.resolve, inline?:boolean}
---@alias snacks.picker.Highlight snacks.picker.Text|snacks.picker.Extmark|{meta?:snacks.picker.Meta}
---@alias snacks.picker.format fun(item:snacks.picker.Item, picker:snacks.Picker):snacks.picker.Highlight[]
---@alias snacks.picker.preview fun(ctx: snacks.picker.preview.ctx):boolean?
---@alias snacks.picker.sort fun(a:snacks.picker.Item, b:snacks.picker.Item):boolean
---@alias snacks.picker.transform fun(item:snacks.picker.finder.Item, ctx:snacks.picker.finder.ctx):(boolean|snacks.picker.finder.Item|nil)
---@alias snacks.picker.Pos {[1]:number, [2]:number}
---@alias snacks.picker.toggle {icon?:string, enabled?:boolean, value?:boolean}
```

Generic filter used by some finders to pre-filter items

```lua
---@class snacks.picker.filter.Config
---@field cwd? boolean|string only show files for the given cwd
---@field buf? boolean|number only show items for the current or given buffer
---@field paths? table<string, boolean> only show items that include or exclude the given paths
---@field filter? fun(item:snacks.picker.finder.Item, filter:snacks.picker.Filter):boolean? custom filter function
---@field transform? fun(picker:snacks.Picker, filter:snacks.picker.Filter):boolean? filter transform. Return `true` to force refresh
```

This is only used when using `opts.preview = "preview"`.
It's a previewer that shows a preview based on the item data.

```lua
---@class snacks.picker.Item.preview
---@field text string text to show in the preview buffer
---@field ft? string optional filetype used tohighlight the preview buffer
---@field extmarks? snacks.picker.Extmark[] additional extmarks
---@field loc? boolean set to false to disable showing the item location in the preview
```

```lua
---@class snacks.picker.Item
---@field [string] any
---@field idx number
---@field score number
---@field frecency? number
---@field score_add? number
---@field score_mul? number
---@field source_id? number
---@field file? string
---@field text string
---@field pos? snacks.picker.Pos
---@field loc? snacks.picker.lsp.Loc
---@field end_pos? snacks.picker.Pos
---@field highlights? snacks.picker.Highlight[][]
---@field preview? snacks.picker.Item.preview
---@field resolve? fun(item:snacks.picker.Item)
---@field positions? number[] indices of matched characters in `text`
```

```lua
---@class snacks.picker.finder.Item: snacks.picker.Item
---@field idx? number
---@field score? number
```

```lua
---@class snacks.picker.layout.Config
---@field layout snacks.layout.Box
---@field reverse? boolean when true, the list will be reversed (bottom-up)
---@field fullscreen? boolean open in fullscreen
---@field cycle? boolean cycle through the list
---@field preview? "main" show preview window in the picker or the main window
---@field preset? string|fun(source:string):string
---@field hidden? ("input"|"preview"|"list")[] don't show the given windows when opening the picker. (only "input" and "preview" make sense)
---@field auto_hide? ("input"|"preview"|"list")[] hide the given windows when not focused (only "input" makes real sense)
---@field config? fun(layout:snacks.picker.layout.Config) customize the resolved layout config
```

```lua
---@class snacks.picker.win.Config
---@field input? snacks.win.Config|{} input window config
---@field list? snacks.win.Config|{} result list window config
---@field preview? snacks.win.Config|{} preview window config
```

```lua
---@alias snacks.Picker.ref (fun():snacks.Picker?)|{value?: snacks.Picker}
```

```lua
---@alias snacks.picker.history.Record {pattern: string, search: string, live?: boolean}
```

