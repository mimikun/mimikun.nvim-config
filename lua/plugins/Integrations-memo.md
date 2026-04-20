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

