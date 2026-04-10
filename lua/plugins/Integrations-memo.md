# Integrations

## gbprod/substitute.nvim

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

### Telescope.nvim

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

### Snacks.nvim

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

### Oil.nvim

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

### blink.cmp

blink.cmp manages its own menu position independently. Use the built-in adapter so it follows the repositioned cmdline window:

```lua
require("tiny-cmdline").setup({
    on_reposition = require("tiny-cmdline").adapters.blink,
})
```

