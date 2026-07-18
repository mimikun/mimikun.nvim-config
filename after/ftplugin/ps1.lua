vim.keymap.set({ "n" }, "<leader>lt", function()
  require("powershell").toggle_term()
end, {
  desc = "Toggle Powershell Extension Terminal",
  silent = true,
})

vim.keymap.set({ "n", "x" }, "<leader>le", function()
  require("powershell").eval()
end, {
  desc = "Eval expression on Powershell Extension Terminal",
  silent = true,
})

vim.keymap.set({ "n" }, "<leader>ld", function()
  require("powershell").toggle_debug_term()
end, {
  desc = "Toggle Powershell Debug Terminal",
  silent = true,
})
