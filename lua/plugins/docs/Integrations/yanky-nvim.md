# Integrations

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

