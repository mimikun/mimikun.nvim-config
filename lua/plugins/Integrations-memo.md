# Integrations

## rachartier/tiny-glimmer.nvim

### gbprod/substitute.nvim

Add animation support to the substitute plugin:

```lua
{
    "gbprod/substitute.nvim",
    dependencies = { "rachartier/tiny-glimmer.nvim" },
    config = function()
        require("substitute").setup({
            on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
            highlight_substituted_text = {
                enabled = false,  -- Disable built-in highlight
            },
        })
    end,
}
```

## HakonHarnes/img-clip.nvim

### nvim-telescope/telescope.nvim

The plugin can be integrated with [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) to provide a seamless way to select and embed images using Telescope's powerful fuzzy finding capabilities.

```lua
function()
  local telescope = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  telescope.find_files({
    attach_mappings = function(_, map)
      local function embed_image(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        local filepath = entry[1]
        actions.close(prompt_bufnr)

        local img_clip = require("img-clip")
        img_clip.paste_image(nil, filepath)
      end

      map("i", "<CR>", embed_image)
      map("n", "<CR>", embed_image)

      return true
    end,
  })
end
```

The above function should be bound to a keymap, e.g. through lazy.nvim.

### folke/snacks.nvim

The plugin can be integrated with [Snacks.nvim picker](https://github.com/folke/snacks.nvim) which includes built-in support for previewing media files.

```lua
function()
    Snacks.picker.files {
    	ft = { "jpg", "jpeg", "png", "webp" },
    	confirm = function(self, item, _)
    	    self:close()
    	    require("img-clip").paste_image({}, "./" .. item.file) -- ./ is necessary for img-clip to recognize it as path
    	end,
    }
end
```

The above function should be bound to a keymap, e.g. through lazy.nvim.

### stevearc/oil.nvim

The plugin also integrates with [oil.nvim](https://github.com/stevearc/oil.nvim), providing a convenient way to browse and select images using Oil's file explorer.

```lua
function()
  local oil = require("oil")
  local filename = oil.get_cursor_entry().name
  local dir = oil.get_current_dir()
  oil.close()

  local img_clip = require("img-clip")
  img_clip.paste_image({}, dir .. filename)
end
```

The above function should be bound to a keymap, e.g. through lazy.nvim.

Alternatively, you can invoke img-clip.nvim directly from your oil.nvim configuration:

```lua
keymaps = {
  ["<leader>p"] = function()
    local oil = require("oil")
    local filename = oil.get_cursor_entry().name
    local dir = oil.get_current_dir()
    oil.close()

    local img_clip = require("img-clip")
    img_clip.paste_image({}, dir .. filename)
  end,
}
```

## rachartier/tiny-cmdline.nvim

### saghen/blink.cmp

blink.cmp manages its own menu position independently. Use the built-in adapter so it follows the repositioned cmdline window:

```lua
require("tiny-cmdline").setup({
    on_reposition = require("tiny-cmdline").adapters.blink,
})
```

## gbprod/yanky.nvim

### gbprod/substitute.nvim

To enable [gbprod/substitute.nvim](https://github.com/gbprod/substitute.nvim)
swap when performing a substitution, you can add this to your setup:

```lua
local opts = {
  on_substitute = require("yanky.integration").substitute(),
}
require("substitute").setup(opts)
```

### hrsh7th/nvim-cmp

Using [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) and [chrisgrieser/cmp_yanky](https://github.com/chrisgrieser/cmp_yanky), you can also get suggestions from your yank history as you type in insert mode.

### hydra.nvim

To work with [anuvyklack/hydra.nvim](https://github.com/anuvyklack/hydra.nvim) (but this is old and dead)
only setup <C-n>/<C-p> mapping when yanky is activated, you can add this to your setup:

```lua
local Hydra = require("hydra")

local function t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

local yanky_hydra = Hydra({
  name = "Yank ring",
  mode = "n",
  heads = {
    { "p", "<Plug>(YankyPutAfter)", { desc = "After" } },
    { "P", "<Plug>(YankyPutBefore)", { desc = "Before" } },
    { "<c-p>", "<Plug>(YankyPreviousEntry)", { private = true, desc = "↑" } },
    { "<c-n>", "<Plug>(YankyNextEntry)", { private = true, desc = "↓" } },
  },
})

-- choose/change the mappings if you want
for key, putAction in pairs({
  ["p"] = "<Plug>(YankyPutAfter)",
  ["P"] = "<Plug>(YankyPutBefore)",
  ["gp"] = "<Plug>(YankyGPutAfter)",
  ["gP"] = "<Plug>(YankyGPutBefore)",
}) do
  vim.keymap.set({ "n", "x" }, key, function()
    vim.fn.feedkeys(t(putAction))
    yanky_hydra:activate()
  end)
end

-- choose/change the mappings if you want
for key, putAction in pairs({
  ["]p"] = "<Plug>(YankyPutIndentAfterLinewise)",
  ["[p"] = "<Plug>(YankyPutIndentBeforeLinewise)",
  ["]P"] = "<Plug>(YankyPutIndentAfterLinewise)",
  ["[P"] = "<Plug>(YankyPutIndentBeforeLinewise)",

  [">p"] = "<Plug>(YankyPutIndentAfterShiftRight)",
  ["<p"] = "<Plug>(YankyPutIndentAfterShiftLeft)",
  [">P"] = "<Plug>(YankyPutIndentBeforeShiftRight)",
  ["<P"] = "<Plug>(YankyPutIndentBeforeShiftLeft)",

  ["=p"] = "<Plug>(YankyPutAfterFilter)",
  ["=P"] = "<Plug>(YankyPutBeforeFilter)",
}) do
  vim.keymap.set("n", key, function()
    vim.fn.feedkeys(t(putAction))
    yanky_hydra:activate()
  end)
end
```

## folke/lazydev.nvim

### hrsh7th/nvim-cmp

```lua
-- optional cmp completion source for require statements and module annotations
return { 
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, {
      name = "lazydev",
      -- set group index to 0 to skip loading LuaLS completions
      group_index = 0,
    })
  end,
}
```

### saghen/blink.cmp

```lua
-- optional blink completion source for require statements and module annotations
return { 
  "saghen/blink.cmp",
  opts = {
    sources = {
      -- add lazydev to your completion providers
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  },
}
```

## rachartier/tiny-inline-diagnostic.nvim

### folke/sidekick.nvim

The plugin integrates with [sidekick.nvim](https://github.com/folke/sidekick.nvim) to automatically disable diagnostics when the sidekick NES is shown and re-enable them when hidden. This prevents visual clutter...

```lua
local disabled = false
return {
  {
    "folke/sidekick.nvim",
    opts = { nes = { enabled = true } },
    config = function(_, opts)
      require("sidekick").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "SidekickNesHide",
        callback = function()
          if disabled then
            disabled = false
            require("tiny-inline-diagnostic").enable()
          end
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "SidekickNesShow",
        callback = function()
          disabled = true
          require("tiny-inline-diagnostic").disable()
        end,
      })
    end,
  },
}
```

This setup listens for `SidekickNesShow` and `SidekickNesHide` events to toggle the diagnostics accordingly.

## delphinus/md-render.nvim

### nvim-telescope/telescope.nvim

#### Previewer

`require("md-render.telescope").previewer()` で作成した previewer は、任意の
[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) picker
（builtin、extension、カスタム問わず）に渡せます：

```lua
local previewer = require("md-render.telescope").previewer()

require("telescope.builtin").find_files({ previewer = previewer })
require("telescope").extensions.egrepify.egrepify({ previewer = previewer })
```

ファイルの種類に応じて自動的に表示方法を切り替えます：

| ファイル種別 | 動作 |
|---|---|
| Markdown (`.md`, `.markdown`) | md-render によるフルレンダリング（ハイライト、リンク、画像） |
| 画像・動画 (PNG, JPEG, WebP, GIF, MP4, ...) | Kitty graphics protocol でインライン表示 |
| その他 | telescope のデフォルト previewer（シンタックスハイライト付き）にフォールバック |

grep 系の picker では、マッチした行に自動スクロールします。

#### `:Telescope md_render` Extension

builtin picker 用のショートカットです。`telescope.builtin` の picker を md-render
previewer 付きでラップします。引数はすべてそのまま渡されます：

```vim
:Telescope md_render find_files
:Telescope md_render live_grep cwd=~/notes
:Telescope md_render grep_string search=TODO
```

### folke/snacks.nvim

`require("md-render.snacks").preview()` で
[snacks.nvim](https://github.com/folke/snacks.nvim) の picker 用プレビュー関数を
作成します。telescope 版と同じく Markdown、画像・動画、その他のファイルに対応します。

グローバルに全 picker へ適用：

```lua
require("snacks").setup({
  picker = {
    preview = require("md-render.snacks").preview(),
  },
})
```

source ごとに個別設定：

```lua
require("snacks").setup({
  picker = {
    sources = {
      files = { preview = require("md-render.snacks").preview() },
      grep = { preview = require("md-render.snacks").preview() },
    },
  },
})
```

## lewis6991/gitsigns.nvim

### tpope/vim-fugitive

When viewing revisions of a file (via `:0Gclog` for example), Gitsigns will attach to the fugitive buffer with the base set to the commit immediately before the commit of that revision.
This means the signs placed in the buffer reflect the changes introduced by that revision of the file.

### folke/trouble.nvim

If installed and enabled (via `config.trouble`; defaults to true if installed), `:Gitsigns setqflist` or `:Gitsigns setloclist` will open Trouble instead of Neovim's built-in quickfix or location list windows.

### Any status-line plugin

- Use `b:gitsigns_status` or `b:gitsigns_status_dict`.
- `b:gitsigns_status` is formatted using `config.status_formatter`.
- `b:gitsigns_status_dict` is a dictionary with the keys `added`, `removed`, `changed` and `head`.

Example:

```viml
set statusline+=%{get(b:,'gitsigns_status','')}
```

#### helpfile

```help
STATUSLINE                                               *gitsigns-statusline*

                                    *b:gitsigns_status* *b:gitsigns_status_dict*
The buffer variables `b:gitsigns_status` and `b:gitsigns_status_dict` are
provided. `b:gitsigns_status` is formatted using `config.status_formatter`
. `b:gitsigns_status_dict` is a dictionary with the keys:

        • `added` - Number of added lines.
        • `changed` - Number of changed lines.
        • `removed` - Number of removed lines.
        • `head` - Name of current HEAD (branch or short commit hash).
        • `root` - Top level directory of the working tree.
        • `gitdir` - .git directory.

Example:
>vim
    set statusline+=%{get(b:,'gitsigns_status','')}
<
                                            *b:gitsigns_head* *g:gitsigns_head*
Use `g:gitsigns_head` and `b:gitsigns_head` to return the name of the current
HEAD (usually branch name). If the current HEAD is detached then this will be
a short commit hash. `g:gitsigns_head` returns the current HEAD for the
current working directory, whereas `b:gitsigns_head` returns the current HEAD
for each buffer.

                            *b:gitsigns_blame_line* *b:gitsigns_blame_line_dict*
Provided if |gitsigns-config-current_line_blame| is enabled.
`b:gitsigns_blame_line` if formatted using
`config.current_line_blame_formatter`. `b:gitsigns_blame_line_dict` is a
dictionary containing of the blame object for the current line. For complete
list of keys, see the {blame_info} argument from
|gitsigns-config-current_line_blame_formatter|.
```

## amansingh-afk/milli.nvim

Pick your dashboard plugin. Each preset (`dashboard`, `alpha`, `snacks`, `starter`, `vimenter`) works identically with bundled or custom splashes.

### my origina splash

```lua
require("milli").dashboard({ splash = "corona", loop = true })
```

### nvimdev/dashboard-nvim

```lua
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "amansingh-afk/milli.nvim" },
  opts = function()
    local splash = require("milli").load({ splash = "finger" })
    return {
      theme = "doom",
      config = {
        header = splash.frames[1],         -- seed header with frame 0
        center = {
          { icon = "  ", desc = "Find File", key = "f", action = "Telescope find_files" },
          { icon = "  ", desc = "Quit",      key = "q", action = "qa" },
        },
      },
    }
  end,
  config = function(_, opts)
    require("dashboard").setup(opts)
    require("milli").dashboard({ splash = "finger", loop = true })
  end,
}
```

### goolord/alpha-nvim

```lua
require("milli").alpha({ splash = "fire", loop = true })
```

### folke/snacks.nvim

```lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = { "amansingh-afk/milli.nvim" },
  opts = function()
    local splash = require("milli").load({ splash = "fire" })
    return {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat(splash.frames[1], "\n"),
        },
        sections = {
          { section = "header", padding = 1 },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    }
  end,
  config = function(_, opts)
    require("snacks").setup(opts)
    require("milli").snacks({ splash = "fire", loop = true })
  end,
}
```

`preset.header` seeds frame 0 of the splash as snacks's default header so milli's anchor-search can locate the buffer position to animate over. 
The splash name in `preset.header` and in `require("milli").snacks({ splash = ... })` must match.

### nvim-mini/mini.starter

```lua
require("milli").starter({ splash = "fire", loop = true })
```

### No plugin (raw VimEnter)

```lua
require("milli").vimenter({ splash = "fire", loop = true })
```

