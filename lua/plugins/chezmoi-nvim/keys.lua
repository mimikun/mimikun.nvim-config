---@type LazyKeysSpec[]
local keys = {
  -- NOTE: USE telescope.nvim
  {
    "<leader>cf",
    function()
      require("chezmoi.pick").telescope()
    end,
    mode = {
      "n",
    },
    desc = "Search all chezmoi files",
    silent = true,
  },
  {
    "<leader>cfn",
    function()
      local targets = vim.fn.stdpath("config")
      local args = {
        "--path-style",
        "absolute",
        "--include",
        "files",
        "--exclude",
        "externals",
      }
      require("chezmoi.pick").telescope(targets, args)
    end,
    mode = {
      "n",
    },
    desc = "Search only neovim config files",
    silent = true,
  },
  --[[
  -- NOTE: USE snacks.nvim picker
  {
    "<leader>cf",
    function()
      require("chezmoi.pick").snacks()
    end,
    mode = {
      "n",
    },
    desc = "Search all chezmoi files",
    silent = true,
  },
  {
    "<leader>cfn",
    function()
      local targets = vim.fn.stdpath("config")
      local args = {
        "--path-style",
        "absolute",
        "--include",
        "files",
        "--exclude",
        "externals",
      }
      require("chezmoi.pick").snacks(targets, args)
    end,
    mode = {
      "n",
    },
    desc = "Search only neovim config files",
    silent = true,
  },
  ]]
  --[[
  -- NOTE: USE fzf-lua
  {
    "<leader>cf",
    function()
      require("chezmoi.pick").fzf()
    end,
    mode = {
      "n",
    },
    desc = "Search all chezmoi files",
    silent = true,
  },
  {
    "<leader>cfn",
    function()
      local targets = vim.fn.stdpath("config")
      local args = {
        "--path-style",
        "absolute",
        "--include",
        "files",
        "--exclude",
        "externals",
      }
      require("chezmoi.pick").fzf(targets, args)
    end,
    mode = {
      "n",
    },
    desc = "Search only neovim config files",
    silent = true,
  },
  ]]
  --[[
  -- NOTE: USE mini.nvim mini.pick
  {
    "<leader>cf",
    function()
      require("chezmoi.pick").mini()
    end,
    mode = {
      "n",
    },
    desc = "Search all chezmoi files",
    silent = true,
  },
  {
    "<leader>cfn",
    function()
      local targets = vim.fn.stdpath("config")
      local args = {
        "--path-style",
        "absolute",
        "--include",
        "files",
        "--exclude",
        "externals",
      }
      require("chezmoi.pick").mini(targets, args)
    end,
    mode = {
      "n",
    },
    desc = "Search only neovim config files",
    silent = true,
  },
  ]]
}

return keys
