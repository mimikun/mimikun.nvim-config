-- NOTE: `scripts/check-keys-spec.lua` lints this file with a bare `dofile()`, outside the Neovim
-- runtime, so nothing here may `require()` cokeline or the sibling picker module at file scope.
-- Every such call stays inside an rhs function, which only ever runs after lazy.nvim has loaded
-- the plugin.

---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>bn",
    "<Plug>(cokeline-focus-next)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus next buffer",
    silent = true,
  },
  {
    "<leader>bp",
    "<Plug>(cokeline-focus-prev)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus prev buffer",
    silent = true,
  },
  {
    "<leader>b1",
    "<Plug>(cokeline-focus-1)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 1",
    silent = true,
  },
  {
    "<leader>b2",
    "<Plug>(cokeline-focus-2)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 2",
    silent = true,
  },
  {
    "<leader>b3",
    "<Plug>(cokeline-focus-3)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 3",
    silent = true,
  },
  {
    "<leader>b4",
    "<Plug>(cokeline-focus-4)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 4",
    silent = true,
  },
  {
    "<leader>b5",
    "<Plug>(cokeline-focus-5)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 5",
    silent = true,
  },
  {
    "<leader>b6",
    "<Plug>(cokeline-focus-6)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 6",
    silent = true,
  },
  {
    "<leader>b7",
    "<Plug>(cokeline-focus-7)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 7",
    silent = true,
  },
  {
    "<leader>b8",
    "<Plug>(cokeline-focus-8)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 8",
    silent = true,
  },
  {
    "<leader>b9",
    "<Plug>(cokeline-focus-9)",
    mode = {
      "n",
    },
    desc = "Cokeline: focus buffer 9",
    silent = true,
  },
  {
    "<leader>b$",
    -- `<Plug>(cokeline-focus-N)` only exists for a fixed 1..20, so "last" has to be computed.
    function()
      local state = require("cokeline.state")
      require("cokeline.mappings").by_index("focus", #state.visible_buffers)
    end,
    mode = {
      "n",
    },
    desc = "Cokeline: focus last buffer",
    silent = true,
  },
  {
    "<leader>bP",
    "<Plug>(cokeline-pick-focus)",
    mode = {
      "n",
    },
    desc = "Cokeline: pick buffer to focus",
    silent = true,
  },
  {
    "<leader>bd",
    "<Plug>(cokeline-pick-close)",
    mode = {
      "n",
    },
    desc = "Cokeline: pick buffer to close",
    silent = true,
  },
  {
    "<leader>bD",
    "<Plug>(cokeline-pick-close-multiple)",
    mode = {
      "n",
    },
    desc = "Cokeline: pick buffers to close (repeating)",
    silent = true,
  },
  {
    "<leader>bH",
    "<Plug>(cokeline-switch-prev)",
    mode = {
      "n",
    },
    desc = "Cokeline: move buffer left",
    silent = true,
  },
  {
    "<leader>bL",
    "<Plug>(cokeline-switch-next)",
    mode = {
      "n",
    },
    desc = "Cokeline: move buffer right",
    silent = true,
  },
  {
    "<leader>bf",
    function()
      require("plugins.nvim-cokeline.picker").buffers()
    end,
    mode = {
      "n",
    },
    desc = "Cokeline: pick buffer (fuzzy, tabline order)",
    silent = true,
  },
}

return keys
