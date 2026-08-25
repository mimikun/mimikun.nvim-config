# aaa

## 🧩 Preview options

---

### enable_hybrid_mode

```lua
## callbacks

```lua from: ../lua/markview/types/preview.lua class: markview.config.preview.callbacks
--- Callback functions for specific events.
---@class markview.config.preview.callbacks
---
---@field on_attach? fun(buf: integer, wins: integer[]): nil Called when attaching to a buffers.
---@field on_detach? fun(buf: integer, wins: integer[]): nil Called when detaching from a buffer.
---
---@field on_disable? fun(buf: integer, wins: integer[]): nil Called when disabling preview of a buffer. Also called when using `splitOpen`.
---@field on_enable? fun(buf: integer, wins: integer[]): nil Called when enabling preview of a buffer. Also called when using `splitClose`.
---
---@field on_hybrid_disable? fun(buf: integer, wins: integer[]): nil Called when disabling hybrid mode in a buffer.
---@field on_hybrid_enable? fun(buf: integer, wins: integer[]): nil Called when enabling hybrid mode in a buffer.
---
---@field on_mode_change? fun(buf: integer, wins: integer[], mode: string): nil Called when changing VIM-modes(only on active buffers).
---
---@field on_splitview_close? fun(source: integer, preview_buf: integer, preview_win: integer): nil Called before closing splitview.
---@field on_splitview_open? fun(source: integer, preview_buf: integer, preview_win: integer): nil Called when opening splitview.
```

### Runs various callbacks on specific *events*

### icon_provider

```lua
---@field icon_provider?
---| "" Disable icons.
---| "internal" Internal icon provider.
---| "devicons" `nvim-web-devicons` as icon provider.
---| "mini" `mini.icons` as icon provider.
```

### Set the icon provider for the code block labels

### debounce

```lua
debounce = 150
```

Delay(in milliseconds) between refreshing the preview. Also changes how often the `splitview` window is updated.

>[!NOTE]
> In some cases(e.g. switching between 2 modes(e.g. `n`, `c`) that have preview enabled) the refresh is **skipped**.
> You can manually trigger a refresh with `:Markview render`(current buffer only) and `:Markview Render`(all attached buffers).
---

### filetypes

```lua
filetypes = { "markdown", "quarto", "rmd", "typst" },
```

Filetypes where `markview` will try to attach. Also see [preview.ignore_buftypes](#ignore_buftypes).

>[!IMPORTANT]
> If the buftype matches any of the buftype in [preview.ignore_buftypes](#ignore_buftypes) it will be **ignored**.
> By default, `nofile` buffers are skipped.

### ignore_buftypes

```lua
ignore_buftypes = { "nofile" },
```

Buffer types to ignore. Useful to disable previews in LSP hover window/Completion window.

### raw_previews

```lua from: ../lua/markview/types/preview.lua class: markview.config.preview.raw
--- Elements that should be shown as raw when hovering
--- in `hybrid mode`.
---@class markview.config.preview.raw
---
---@field comment? markview.config.preview.raw.comment[]
---@field html? markview.config.preview.raw.html[]
---@field latex? markview.config.preview.raw.latex[]
---@field markdown? markview.config.preview.raw.markdown[]
---@field markdown_inline? markview.config.preview.raw.markdown_inline[]
---@field typst? markview.config.preview.raw.typst[]
---@field yaml? markview.config.preview.raw.yaml[]
```

Changes what gets shown as raw text in `hybrid mode`. [hybrid_modes](#hybrid_modes) must be set for this to work.

It is a map of language names & a list of inclusion/exclusion rules.

| `raw_previews = { ... }` | `raw_previews = nil` |
|--------------------------|----------------------|
| ![raw_peviews](./images/preview/markview.nvim-preview.raw_previews.png) | ![no raw_previews](./images/preview/markview.nvim-preview.noraw_previews.png) |

You would use something like this to only show everything other then `block quotes` & `tables` as raw text.

```lua
raw_previews = {
    markdown = { "!block_quotes", "!tables" }
}
```

### condition

A function that returns a **boolean** indicating if a buffer should be attached to.

>[!IMPORTANT]
> This will disable [filetypes](#filetypes) & [ignore_buftypes](#ignore_buftypes).

>[!NOTE]
> The function may return `nil`. In which case, [filetypes](#filetypes) & [ignore_buftypes](#ignore_buftypes) will be checked.

Useful if you need sophisticated logic for buffer attaching.

For example, this is the default value. It attaches to any buffer that has `tree-sitter` parser available when [experimental.fancy_comments](https://github.com/OXY2DEV/markview.nvim/wiki/Experimental#fancy_comments) is set to `true`.

```lua from: ../lua/markview/spec.lua, field: spec.default.preview.condition
condition = function (buffer)
    local is_enabled = spec.get({ "experimental", "fancy_comments" }, {
        fallback = false,
    });

    if not is_enabled then
        return false;
    end

    local success, parser = pcall(vim.treesitter.get_parser, buffer);
    if success and parser ~= nil then
        return true;
    end
end,
```

### modes

```lua
modes = { "n", "no", "c" },
```

Modes where previews will be shown.

### hybrid_modes

```lua
hybrid_modes = {},
```

Modes where `hybrid mode` will be shown.

>[!IMPORTANT]
> The mode must also be preset in [modes](#modes) for this to take effect!

| `hybrid_modes = { "n" }` | `hybrid_modes = {}` |
|--------------------------|----------------------|
| ![hybrid_modes](./images/preview/markview.nvim-preview.hybrid_modes.png) | ![no hybrid_modess](./images/preview/markview.nvim-preview.nohybrid_modes.png) |

### linewise_hybrid_mode

```lua
linewise_hybrid_mode = false,
```

Enables `linewise` hybrid mode. [edit_range](#edit_range) is used to control the number of lines to clear around each cursor.

| `linewise_hybrid_mode = true` | `linewise_hybrid_mode = false` |
|--------------------------|----------------------|
| ![linewise_hybrid_mode](./images/preview/markview.nvim-preview.linewise_hybrid_mode.png) | ![no linewise_hybrid_mode](./images/preview/markview.nvim-preview.hybrid_modes.png) |

### max_buf_lines

```lua
max_buf_lines = 1000,
```

Maximum number of lines a buffer can have for it to be rendered completely.

>[!NOTE]
> This causes a lot of the redrawing to be skipped and giving a better performance.
> However, if the buffer is very long(or has very complex syntax tree) it can cause lag when opening the buffer.

If the line count is larger than this value, the buffer will be *partially* drawn. [draw_range](#draw_range) is used to control the number of lines drawn around each cursor.

### draw_range

```lua
draw_range = { 1 * vim.o.lines, 1 * vim.o.lines },
```

Number of lines drawn above & below each cursor.

>[!IMPORTANT]
> For a node to be drawn, it only needs to be partially inside this range.
> So, sometimes it may feel like more lines are being drawn than the specified amount.

### edit_range

```lua
edit_range = { 0, 0 },
```

Number of lines above & below each cursor that are considered being *edited*. Only useful in [hybrid_modes](#hybrid_modes).

>[!IMPORTANT]
> When [linewise_hybrid_mode](#linewise_hybrid_mode) is `false`, a Node only needs to *partially* be within the range for it to be considered being *edited*.
> So, things such as List items, Block quotes etc. may clear more lines than the specified amount.

>[!NOTE]
> `{ 0, 0 }` means only the current line is being edited. `{ 1, 1 }` means 1 line around each cursor(total 3 lines) are being edited.
> You can use different values for lines above & below the cursor.

### splitview_winopts

```lua
splitview_winopts = {
    split = "right"
},
```

Window options for the `splitview` window. Passed directly to `nvim_open_win()`.
