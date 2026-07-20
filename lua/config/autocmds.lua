-- https://github.com/iterative/dvc
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Dvcfile", "*.dvc", "dvc.lock" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})
