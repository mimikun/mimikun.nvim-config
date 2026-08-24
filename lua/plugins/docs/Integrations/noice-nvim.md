# Integrations

## folke/noice.nvim

### Statusline Components

**Noice** comes with the following statusline components:

- **ruler**
- **message**: last line of the last message (`event=show_msg`)
- **command**: `showcmd`
- **mode**: `showmode` (@recording messages)
- **search**: search count messages

See [noice.config.status](https://github.com/folke/noice.nvim/blob/main/lua/noice/config/status.lua) for the default config.

You can add custom statusline components in setup under the `status` key.

Statusline components have the following methods:

- **get**: gets the content of the message **without** highlights
- **get_hl**: gets the content of the message **with** highlights
- **has**: checks if the component is available

#### nvim-lualine/lualine.nvim

```lua
require("lualine").setup({
  sections = {
    lualine_x = {
      {
        require("noice").api.status.message.get_hl,
        cond = require("noice").api.status.message.has,
      },
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.search.get,
        cond = require("noice").api.status.search.has,
        color = { fg = "#ff9e64" },
      },
    },
  },
})
```
