### Describe Editor Modes

The `describe.editor.type` option lets you choose how you want to write commit descriptions:

- **`"buffer"`** (default) - Opens a full buffer editor similar to Git's commit message editor
  - Shows file changes with syntax highlighting
  - Multi-line editing with proper formatting
  - Close with `q` or `<Esc>`, save with `:w` or `:wq`
- **`"input"`** - Simple single-line input prompt
  - Quick and minimal
  - Good for short, single-line descriptions
  - Uses `vim.ui.input()` which can be customized by UI plugins like dressing.nvim

Example:

```lua
require("jj").setup({
  describe = {
    editor = {
      type = "input", -- Use simple input mode
    }
  }
})
```

You can also customize the keymaps for the describe editor buffer:

```lua
require("jj").setup({
  describe = {
    editor = {
      type = "buffer",
      keymaps = {
        close = { "q", "<Esc>", "<C-c>" }, -- Customize close keybindings
      }
    }
  }
})
```

### Editor Options

The top-level `editor` config controls behavior for the describe/commit editor buffers.

#### `editor.auto_insert`

When `auto_insert = true`, `jj.nvim` automatically enters Insert mode when opening a describe or commit buffer **only if the description is empty**.

If the change already has a description, the buffer stays in Normal mode so you can review or edit the existing message without being dropped straight into Insert mode.

Default:

```lua
require("jj").setup({
  editor = {
    auto_insert = false,
  }
})
```

Enable smart auto-insert:

```lua
require("jj").setup({
  editor = {
    auto_insert = true,
  }
})
```

#### `editor.window`

Control where the describe/commit editor buffer opens:

- `type`: `"hsplit" | "vsplit" | "floating" | "tab"`
- `split_size`: split ratio for `hsplit`/`vsplit` (default `0.5`)
- `floating_width`: width ratio for floating windows (default `0.99`)
- `floating_height`: height ratio for floating windows (default `0.95`)

Example:

```lua
require("jj").setup({
  editor = {
    window = {
      type = "floating",
      floating_width = 0.9,
      floating_height = 0.8,
    },
  },
})
```

### Highlight Customization

The `highlights` option allows you to customize the colors used in the describe buffer's file status display. Each highlight accepts standard Neovim highlight attributes:

- `fg` - Foreground color (hex or color name)
- `bg` - Background color
- `ctermfg` - Terminal foreground color
- `ctermbg` - Terminal background color
- `bold`, `italic`, `underline` - Text styles

Example with custom colors:

```lua
require("jj").setup({
  highlights = {
    modified = { fg = "#89ddff", bold = true },
    added = { fg = "#c3e88d", ctermfg = "LightGreen" },
  }
})
```

## Lua API Usage

Beyond the `:J` command, you can call functions directly from Lua for more control. The example config below shows how to use them with custom keymaps.

### Log Command Options

The `log` function accepts an options table:

```lua
local cmd = require("jj.cmd")
cmd.log({
  summary = false,      -- Show summary of changes (default: false)
  reversed = false,     -- Reverse the log order (default: false)
  no_graph = false,     -- Hide the graph (default: false)
  limit = 20,          -- Limit number of entries (default: 20)
  revisions = "'all()'" -- Revision specifier (default: all reachable)
})

-- Examples:
cmd.log({ limit = 50 })                    -- Show 50 entries
cmd.log({ revisions = "'main::@'" })       -- Show commits between main and current
cmd.log({ summary = true, limit = 100 })   -- Show summary with high limit
cmd.log({ raw = "-r 'main::@' --summary --no-graph" }) -- Pass raw flags directly
```

## Configuration Examples

### New Command Options

The `new` function accepts an options table:

```lua
local cmd = require("jj.cmd")
cmd.new({
  show_log = false,     -- Display log after creating new change (default: false)
  with_input = false,   -- Prompt for parent revision (default: false)
  args = ""             -- Additional arguments to pass to jj new
})

-- Examples:
cmd.new({ show_log = true })                           -- Create new and show log
cmd.new({ show_log = true, with_input = true })        -- Prompt for parent
cmd.new({ args = "--before @" })                       -- Pass custom args
```

### Resolve Command Options

The `resolve` function accepts an options table:

```lua
local cmd = require("jj.cmd")
cmd.resolve({
  rev = "@",                    -- Revision to resolve (default: "@")
  filesets = { "src/" },        -- Optional filesets to limit what gets resolved
  args = { "--tool", "meld" }, -- Extra args passed to `jj resolve`
  external = true,               -- Run as an external command instead of in an nvim floating terminal
})

-- Examples:
cmd.resolve()                                                -- Resolve @ in floating terminal
cmd.resolve({ rev = "abc123" })                            -- Resolve a specific revision
cmd.resolve({ rev = "abc123", filesets = { "lua/" } })    -- Resolve only selected filesets
cmd.resolve({ external = true, args = { "--tool", "kdiff3" } }) -- Use an external merge tool
```

When called from the log buffer via `gr`, `jj.nvim` can optionally prompt for a strategy using `cmd.resolve_strategies`.

> [!NOTE]
> See [Example config](#example-config) for a full `cmd.resolve_strategies` example.

CLI flags for `:J resolve`:

- `-r <rev>` or `--revision <rev>`: target revision (default: `@`)
- `--tool <name>`: pass merge tool to `jj resolve`
- `--external` or `--ext`: run outside the floating terminal
- trailing positional args are treated as filesets
- unknown long options are rejected to avoid ambiguity with filesets

### Push Command Options

The `push` function accepts an options table:

```lua
local cmd = require("jj.cmd")
cmd.push({
  bookmark = "main",    -- Push specific bookmark (default: all changes)
  remote = "origin",    -- Optional target remote
  -- deleted = true,     -- Push deleted bookmarks instead of a bookmark
})

-- Examples:
cmd.push()                               -- Push all changes
cmd.push({ bookmark = "main" })         -- Push only main bookmark
cmd.push({ bookmark = "feature" })      -- Push only feature bookmark
cmd.push({ remote = "origin" })         -- Push all changes to a specific remote
cmd.push({ bookmark = "main", remote = "origin" }) -- Push only main to a specific remote
cmd.push({ deleted = true, remote = "origin" })     -- Push deleted bookmarks to a specific remote
```

The `:J push` command also supports these forms:

```sh
:J push --remote origin
:J push main --remote origin
:J push --deleted --remote origin
```

### Bookmark Management Command Options

The `bookmark_create` function creates a new bookmark:

```lua
local cmd = require("jj.cmd")
cmd.bookmark_create()                               -- Prompts for bookmark name, then prompts the revision
cmd.bookmark_create({ prefix = "feature/" })        -- Uses prefix for default bookmark name
```

You can also set a default bookmark prefix in the config:

```lua
require("jj").setup({
  cmd = {
    bookmark = {
      prefix = "feature/"  -- Default prefix when creating bookmarks
    }
  }
})
```

The `bookmark_move` function moves an existing bookmark to a new revision:

```lua
local cmd = require("jj.cmd")
cmd.bookmark_move()  -- Select bookmark, then specify new revset
```

The `bookmark_delete` function deletes a bookmark:

```lua
local cmd = require("jj.cmd")
cmd.bookmark_delete()  -- Select bookmark to delete
```

The `bookmark_track` function tracks an untracked bookmark:

```lua
local cmd = require("jj.cmd")
cmd.bookmark_track()  -- Select bookmark to track
```

The `bookmark_forget` function forgets a bookmark (untracks it locally):

```lua
local cmd = require("jj.cmd")
cmd.bookmark_forget()  -- Select bookmark to forget/untrack
```

### Tag Management Command Options

The `tag_set` function creates a tag on a revision:

```lua
local cmd = require("jj.cmd")
cmd.tag_set()              -- Prompts for revision and tag name
cmd.tag_set("abc123")      -- Set a tag on a specific revision (prompts for tag name)
```

The `tag_delete` function deletes a tag via picker:

```lua
local cmd = require("jj.cmd")
cmd.tag_delete()           -- Select tag to delete from picker
```

The `tag_push` function pushes a tag to a remote (colocated repositories only):

```lua
local cmd = require("jj.cmd")
cmd.tag_push()             -- Select tag to push from picker (prompts for remote if multiple)
```

### Open PR/MR Command Options

The `open_pr` function accepts an options table:

```lua
local cmd = require("jj.cmd")
cmd.open_pr({
  list_bookmarks = false    -- Whether to select from all bookmarks (default: false, uses current revision)
})

-- Examples:
cmd.open_pr()                          -- Open PR for current change's bookmark
cmd.open_pr({ list_bookmarks = true }) -- Select bookmark from all and open PR
```

### Diff Module

The diff module provides a unified API for viewing diffs with pluggable backend support.

The natively supported backends are:

- Native (Diffs the current file in place and uses a floating buffer with your jj diff command when diffing changes)
- [codediff](https://github.com/esmuellert/codediff.nvim)
- [diffview](https://github.com/sindrets/diffview.nvim)

#### Functions

```lua
local diff = require("jj.diff")

-- Diff current buffer against a revision (default: @-)
-- The `layout` is only supported for the native backend
diff.diff_current({ rev = "@-", layout = "vertical" })

-- Show what changed in a single revision
diff.show_revision({ rev = "abc123" })

-- Diff between two revisions
diff.diff_revisions({ left = "main", right = "@" })

-- Open a history-aware diff between two revisions
-- Supported by the `diffview` and `codediff` backends
-- The `native` backend currently warns instead
diff.diff_history_revisions({ left = "main", right = "@" })

-- Convenience functions (LEGACY FUNCTIONS)
diff.open_vdiff()                   -- Vertical split diff against parent
diff.open_vdiff({ rev = "main" })   -- Vertical split against specific revision
diff.open_hdiff()                   -- Horizontal split diff
diff.open_hdiff({ rev = "@-2" })    -- Horizontal split against @-2
```

#### Log Buffer Integration

The diff module integrates seamlessly with the log buffer:

- `<S-d>` - Show diff for the revision under cursor in a floating window
- `<S-h>` - In visual mode, open a history-aware diff for the first and last selected revisions

These actions use the configured diff backend, allowing you to leverage your preferred diff viewer directly from the log.

### Custom Diff Backends

The diff module supports pluggable backends. Built-in backends include `native`, `diffview`, and `codediff`. You can register your own backend:

```lua
local diff = require("jj.diff")

diff.register_backend("my-backend", {
  -- Diff current buffer against a revision
  diff_current = function(opts)
    -- opts.rev: revision to diff against (default: "@-")
    -- opts.path: file path (default: current buffer)
    -- opts.layout: "vertical" or "horizontal"
  end,

  -- Show what changed in a single revision
  show_revision = function(opts)
    -- opts.rev: revision to show
    -- opts.path: optional file filter
    -- opts.display: "floating", "tab", or "split"
  end,

  -- Diff between two revisions
  diff_revisions = function(opts)
    -- opts.left: left/base revision
    -- opts.right: right/target revision
    -- opts.path: optional file filter
    -- opts.display: "floating", "tab", or "split"
  end,

  -- Open a history-aware diff between two revisions
  diff_history_revisions = function(opts)
    -- opts.left: left/base revision
    -- opts.right: right/target revision
  end,
})
```

Set your backend as default in the config:

```lua
require("jj").setup({
  diff = {
    backend = "my-backend"
  }
})
```

Or use it per-call:

```lua
diff.diff_current({ backend = "my-backend", rev = "main" })
```

All four backend functions are optional—missing ones fall back to the `native` implementation.


## Example config

```lua
    -- Core commands
    local cmd = require("jj.cmd")
    vim.keymap.set("n", "<leader>jd", cmd.describe, { desc = "JJ describe" })
    vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
    vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
    vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
    vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })
    vim.keymap.set("n", "<leader>sj", cmd.squash, { desc = "JJ squash" })
    vim.keymap.set("n", "<leader>ju", cmd.undo, { desc = "JJ undo" })
    vim.keymap.set("n", "<leader>jy", cmd.redo, { desc = "JJ redo" })
    vim.keymap.set("n", "<leader>jr", cmd.rebase, { desc = "JJ rebase" })
    vim.keymap.set("n", "<leader>jbc", cmd.bookmark_create, { desc = "JJ bookmark create" })
    vim.keymap.set("n", "<leader>jbd", cmd.bookmark_delete, { desc = "JJ bookmark delete" })
    vim.keymap.set("n", "<leader>jbm", cmd.bookmark_move, { desc = "JJ bookmark move" })
    vim.keymap.set("n", "<leader>jts", cmd.tag_set, { desc = "JJ tag set" })
    vim.keymap.set("n", "<leader>jtd", cmd.tag_delete, { desc = "JJ tag delete" })
    vim.keymap.set("n", "<leader>jtp", cmd.tag_push, { desc = "JJ tag push" })
    vim.keymap.set("n", "<leader>jf", cmd.fetch, { desc = "JJ fetch" })
    vim.keymap.set("n", "<leader>jp", cmd.push, { desc = "JJ push" })
    vim.keymap.set("n", "<leader>jpr", cmd.open_pr, { desc = "JJ open PR from bookmark in current revision or parent" })
    vim.keymap.set("n", "<leader>jpl", function()
        cmd.open_pr { list_bookmarks = true }
    end, { desc = "JJ open PR listing available bookmarks" })


    -- Diff commands
    local diff = require("jj.diff")
    vim.keymap.set("n", "<leader>df", function() diff.open_vdiff() end, { desc = "JJ diff current buffer" })
    vim.keymap.set("n", "<leader>dF", function() diff.open_hdiff() end, { desc = "JJ hdiff current buffer" })

    -- Pickers
    local picker = require("jj.picker")
    vim.keymap.set("n", "<leader>gj", function() picker.status() end, { desc = "JJ Picker status" })
    vim.keymap.set("n", "<leader>jgh", function() picker.file_history() end, { desc = "JJ Picker history" })
    vim.keymap.set("n", "<leader>jgc", function() picker.conflict() end, { desc = "JJ Picker conflicts" })
    vim.keymap.set("n", "<leader>jgs", function() picker.conflict_sections() end, { desc = "JJ Picker conflict sections" })

-- Annotations
local annotate = require("jj.annotate")
vim.keymap.set("n", "<leader>jan", annotate.file, { desc = "JJ annotate file" })
vim.keymap.set("n", "<leader>jAn", annotate.line, { desc = "JJ annotate line" })

    -- Some functions like `log` can take parameters
    vim.keymap.set("n", "<leader>jL", function()
      cmd.log {
        revisions = "'all()'", -- equivalent to jj log -r ::
      }
    end, { desc = "JJ log all" })


    -- This is an alias i use for moving bookmarks its so good
    vim.keymap.set("n", "<leader>jt", function()
      cmd.j "tug"
      cmd.log {}
    end, { desc = "JJ tug" })
```
