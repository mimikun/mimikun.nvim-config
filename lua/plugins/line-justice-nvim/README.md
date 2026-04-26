## The Full Statuscolumn

Because line-justice never calls `statuscol.setup()`, you have complete freedom over what else appears in the statuscolumn. The recommended config composes five segments into a single, information-dense gutter:

```lua
local builtin = require("statuscol.builtin")
require("statuscol").setup({
  relculright = true,
  segments = {
    { text = { builtin.foldfunc },                                                      click = "v:lua.ScFa" },
    { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true },   click = "v:lua.ScSa" },
    { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },         click = "v:lua.ScSa" },
    { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
    { text = { lj.segment },                                                            click = "v:lua.ScLa" },
  },
})
```

Reading left to right, each segment adds a distinct layer of information:

### `builtin.foldfunc` — fold column

Renders NeoVim's native fold indicators using statuscol's built-in fold function. Shows `▶` on foldable lines and `│` on open fold contents. Clicking it opens or closes the fold (`ScFa`). Requires `foldmethod` to be set (e.g. `treesitter`, `indent`, or `expr`).

**Why it's here:** Code navigation. Collapse functions, classes, or blocks you're not working on. The fold column only appears when there are folds — it takes no space otherwise.

### `gitsigns` namespace — git change markers

Renders [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) signs in a dedicated 1-character column. Shows `│` for modified lines, `▎` for added lines, and `▁` for deleted lines (exact characters depend on your gitsigns config). Clicking a sign triggers the gitsigns click handler (`ScSa`).

**Why it's here:** At-a-glance diff awareness. You can see exactly which lines have changed since the last commit without leaving the file. Invaluable during code review and when rebasing.

### `diagnostic/signs` namespace — LSP diagnostics

Renders LSP diagnostic signs (`E` errors, `W` warnings, `H` hints, `I` info) from the `diagnostic/signs` namespace. `maxwidth = 2` allows up to two diagnostic signs per line.

**Why it's here:** Inline error visibility. You see problems the moment your LSP reports them, right next to the line number — no need to scan the statusline or run `:lua vim.diagnostic.open_float()`.

### `name = { ".*" }` — catch-all signs

A catch-all segment that renders any other signs not captured by the two namespace segments above — debugger breakpoints, bookmarks, test results, and anything else. `wrap = true` means signs on wrapped continuation lines are shown on the first real line.

**Why it's here:** Future-proofing. Any plugin that places a sign (DAP breakpoints, neotest, marks.nvim, etc.) will appear here automatically without any additional config.

### `lj.segment` — dual line numbers

The line-justice segment itself. Absolute line number on the left, relative distance on the right. See [The Solution](#the-solution) above.

**Why it's last:** The numbers are the anchor. Everything to the left is contextual metadata about the line; the numbers are the line's identity. Placing them rightmost keeps them closest to the code.

---

### Minimal setup (line numbers only)

If you don't use gitsigns or an LSP, you can strip the config down to just the essentials:

```lua
local builtin = require("statuscol.builtin")
require("statuscol").setup({
  segments = {
    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
    { text = { lj.segment },       click = "v:lua.ScLa" },
  },
})
```

### statuscol top-level options

Any `statuscol.setup()` key (`relculright`, `bt_ignore`, `ft_ignore`, etc.) can be passed freely alongside the segments:

```lua
require("statuscol").setup({
  relculright = true,
  bt_ignore   = { "nofile" },
  ft_ignore   = { "NvimTree", "neo-tree" },
  segments    = {
    -- your segments here
  },
})
```

---

## Wrapped-line Indicator

When a line is too long for the window and wraps, NeoVim renders the continuation as a virtual line. `wrapped_lines.indicator` controls what appears in the gutter of those virtual lines, **centred** in the gutter width.

### Built-in indicators

| Name | Character | Description |
|---|---|---|
| `"None"` | _(blank)_ | No character — gutter is fully empty |
| `"Arrow"` | ↳ | Classic turn-down arrow — "continued from above" |
| `"Chevron"` | › | Single right-pointing chevron — lightweight directional hint |
| `"Dot"` | · | Middle dot / interpunct — subtle and minimal |
| `"Ellipsis"` | … | Horizontal ellipsis — "more content continues" |
| `"Bar"` | │ | Thin vertical bar — structural / tree-style **(default)** |
| `"Custom"` | _your string_ | Whatever you put in `wrapped_lines.custom` |

### Custom indicator

Set `indicator = "Custom"` and put your character in `custom`:

```lua
wrapped_lines = {
  indicator = "Custom",
  custom    = "⤷",   -- or: "»", "▸", "→", "╰", or any string you like
},
```

### Colour of the indicator

The indicator inherits the `WrappedLine` colour from your `line_numbers` theme or overrides:

```lua
line_numbers = {
  theme = "Horizon",
  overrides = {
    WrappedLine = { fg = "#ff9e64", italic = true }, -- change indicator colour
  },
},
```

---

## Built-in Themes

Three colour themes ship out of the box:

| Name | Vibe | Best with |
|---|---|---|
| `"Horizon"` | Cool blue-purple above, green below | TokyoNight, Catppuccin Mocha, any dark theme |
| `"Dawn"` | Warm amber and rose tones | Rosé Pine, Catppuccin Latte, Gruvbox |
| `"Midnight"` | Cool monochrome blue-greys | GitHub Dark, Zephyr, Moonfly |

```lua
lj.setup({ line_numbers = { theme = "Horizon" } })   -- default
-- lj.setup({ line_numbers = { theme = "Dawn" } })
-- lj.setup({ line_numbers = { theme = "Midnight" } })
```

Set `theme = nil` to auto-detect colours from your active colorscheme instead.

---

## Custom Themes

You can register your own colour themes at runtime using the theme registry:

```lua
local lj = require("line-justice")

-- 1. Define and register your theme
lj.themes.register({
  name        = "Forest",
  description = "Deep greens and mossy tones.",
  author      = "Your Name",          -- optional
  colors = {
    CursorLine    = { fg = "#a8ff78", bold   = true },
    AbsoluteAbove = { fg = "#4a7c59" },
    AbsoluteBelow = { fg = "#2e5b3a" },
    RelativeAbove = { fg = "#6dbf8a" },
    RelativeBelow = { fg = "#4c9e6a" },
    WrappedLine   = { fg = "#4a7c59", italic = true },
  },
})

-- 2. Use it in setup
lj.setup({
  line_numbers = { theme = "Forest" },
})

-- 3. Wire the segment
require("statuscol").setup({
  segments = {
    { text = { lj.segment }, click = "v:lua.ScLa" },
  },
})
```

### Color slots

| Slot | Applied to |
|---|---|
| `CursorLine` | Absolute **and** relative columns on the cursor row |
| `AbsoluteAbove` | Absolute line numbers above the cursor |
| `AbsoluteBelow` | Absolute line numbers below the cursor |
| `RelativeAbove` | Relative distances above the cursor |
| `RelativeBelow` | Relative distances below the cursor |
| `WrappedLine` | The indicator character on soft-wrapped continuation lines |

All six slots are recommended. Any slot you omit falls through to colorscheme auto-detect or the built-in fallback (Horizon palette).

### Theme registry API

```lua
local themes = require("line-justice").themes

themes.register(spec)   -- register (or overwrite) a theme; returns true/false
themes.get("Forest")    -- returns the colors table, or nil if not found
themes.list()           -- sorted list of all available theme names
themes.exists("Forest") -- true if the name is registered or built-in
```

### Shipping a theme as a standalone file or plugin

```lua
-- my-lj-theme.lua (loaded after line-justice.nvim)
local ok, lj = pcall(require, "line-justice")
if not ok then return end

lj.themes.register({
  name        = "MyTheme",
  description = "My personal palette.",
  colors = { ... },
})
```

With lazy.nvim, add `dependencies = { "zaakiy/line-justice.nvim" }` to ensure load order.

See [`examples/custom-theme.lua`](examples/custom-theme.lua) for three fully-annotated example themes.

---

## Examples

### Minimal — just the defaults

```lua
local lj = require("line-justice")
lj.setup()

require("statuscol").setup({
  segments = { { text = { lj.segment }, click = "v:lua.ScLa" } },
})
```

### Arrow indicator on wrapped lines

```lua
lj.setup({ wrapped_lines = { indicator = "Arrow" } })  -- ↳
```

### Custom indicator

```lua
lj.setup({
  wrapped_lines = { indicator = "Custom", custom = "⤷" },
})
```

### Custom indicator with a custom colour

```lua
lj.setup({
  line_numbers = {
    theme = "Horizon",
    overrides = {
      WrappedLine = { fg = "#ff9e64", italic = true },
    },
  },
  wrapped_lines = { indicator = "Custom", custom = "╰" },
})
```

### Auto-detect colours from colorscheme

```lua
lj.setup({
  line_numbers  = { theme = nil },
  wrapped_lines = { indicator = "Arrow" },
})
```

### Override one colour on top of Horizon

Keep all of Horizon's colours but swap the cursor line to a warm orange:

```lua
lj.setup({
  line_numbers = {
    theme = "Horizon",
    overrides = {
      CursorLine = { fg = "#ff9e64", bold = true },
    },
  },
})
```

