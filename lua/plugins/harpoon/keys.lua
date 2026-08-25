local harpoon = require("harpoon")

---@type LazyKeysSpec[]
local keys = {
  -- Block 1
  {
    "<leader>a",
    function()
      harpoon:list():add()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  -- Block 2
  {
    "<C-e>",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  -- Block 3
  {
    "<C-h>",
    function()
      harpoon:list():select(1)
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<C-t>",
    function()
      harpoon:list():select(2)
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<C-n>",
    function()
      harpoon:list():select(3)
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<C-s>",
    function()
      harpoon:list():select(4)
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  -- Block 4
  -- Toggle previous & next buffers stored within Harpoon list
  {
    "<C-S-P>",
    function()
      harpoon:list():prev()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<C-S-N>",
    function()
      harpoon:list():next()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
}

return keys
