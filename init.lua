if vim.env.PROF then
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      -- stop profiler on this event.
      event = "VimEnter", 
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end

if vim.loader then
  vim.loader.enable()
end

vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.fileformats = {
  "unix",
  "dos",
  "mac",
}

vim.opt.fileencodings = {
  "utf-8",
  "cp932",
  "ucs-bombs",
  "euc-jp",
  "ucs-bom",
  "default",
  "latin1",
}

vim.opt.number = true
vim.opt.relativenumber = true
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

require("config.lazy")

vim.cmd.colorscheme("tokyonight")

vim.keymap.set("n", "<Esc><Esc>", function()
  vim.cmd("nohlsearch")
end, { silent = true })

-- https://github.com/iterative/dvc
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Dvcfile", "*.dvc", "dvc.lock" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})
