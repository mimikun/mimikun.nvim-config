---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>gl",
    function()
      require("snacks").lazygit()
    end,
    mode = {
      "n",
    },
    desc = "LazyGit",
    silent = true,
  },
  {
    "<leader>gB",
    function()
      require("snacks").gitbrowse()
    end,
    mode = {
      "n",
      "v",
    },
    desc = "Git browse (open in remote)",
    silent = true,
  },
  {
    "<leader>sc",
    function()
      require("snacks").scratch()
    end,
    mode = {
      "n",
    },
    desc = "Toggle scratch buffer",
    silent = true,
  },
  {
    "<leader>sS",
    function()
      require("snacks").scratch.select()
    end,
    mode = {
      "n",
    },
    desc = "Select scratch buffer",
    silent = true,
  },
  {
    "<leader>sr",
    function()
      require("snacks").rename.rename_file()
    end,
    mode = {
      "n",
    },
    desc = "Rename current file (LSP aware)",
    silent = true,
  },
  {
    "<leader>u",
    mode = {
      "n",
    },
    desc = "UI toggles",
    silent = true,
  },
}

return keys
