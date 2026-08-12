#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
vim.env.LAZY_PATH = vim.fs.normalize("~/projects/lazy.nvim")

if vim.fn.isdirectory(vim.env.LAZY_PATH) == 1 then
  loadfile(vim.env.LAZY_PATH .. "/bootstrap.lua")()
else
  load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"), "bootstrap.lua")()
end

-- Setup lazy.nvim
require("lazy.minit").setup({
  spec = {
    {
      dir = vim.uv.cwd(),
      opts = {},
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    { "folke/snacks.nvim" },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      build = ":TSUpdate",
      config = function()
        local TS = require("nvim-treesitter")
        TS.setup({})
        TS.install({ "python", "rust", "javascript", "typescript", "go", "lua" }, { summary = true }):wait()
      end,
    },
  },
})

-- TODO: check why this is needed
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")
