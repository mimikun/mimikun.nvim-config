---@type LazyKeysSpec[]
local keys = {
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --vim.api.nvim_set_keymap("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggles `markview` previews globally." });
  --vim.api.nvim_set_keymap("i", "<Ctrl-m>", "<CMD>Markview HybridToggle<CR>", { desc = "Toggles `hybrid mode` globally." });
  --vim.api.nvim_set_keymap("n", "<leader>s", "<CMD>Markview linewiseToggle<CR>", { desc = "Toggles `line-wise` hybrid mode." });
  --vim.api.nvim_set_keymap("n", "<leader>s", "<CMD>Markview splitToggle<CR>", { desc = "Toggles `splitview` for current buffer." });
}

return keys
