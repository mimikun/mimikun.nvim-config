---@type LazyKeysSpec[]
local keys = {
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = "n",
    desc = "",
    { silent = true },
  },
  ---- Interrupt the process of plugins via <C-c>
  --vim.keymap.set({ "n", "v", "x", "s", "o" }, "<C-c>", "<Cmd>call denops#interrupt()<CR><C-c>", { silent = true })
  --vim.keymap.set("i", "<C-c>", "<Cmd>call denops#interrupt()<CR><C-c>", { silent = true })
  --vim.keymap.set("c", "<C-c>", "<Cmd>call denops#interrupt()<CR><C-c>", { silent = true })
}

return keys
