# Integrations

## obsidian-nvim/obsidian.nvim

### folke/snacks.nvim

#### Inline Image viewing

The only image viewing backend that is well tested and supported is [snacks.image](https://github.com/folke/snacks.nvim/blob/main/docs/image.md), and for extra info there's work being done that will give neovim an native [API rendering images](https://github.com/neovim/neovim/pull/31399), so eventually we will just move to that.

For proper image path resolving, add the following snippet to your snacks config, it will only effect markdown files in your vault:

(_API could could change in the future_)

```lua
require("snacks").setup {
  image = {
    resolve = function(path, src)
      local api = require "obsidian.api"
      if api.path_is_note(path) then
        return api.resolve_attachment_path(src)
      end
    end,
  },
}
```

