---@type LazyKeysSpec[]
local keys = {
  {
    -- <leader>l is quicker.nvim's loclist toggle
    "<leader>L",
    function()
      vim.cmd("Lint")
    end,
    mode = {
      "n",
    },
    desc = "Lint buffer",
    silent = true,
  },
}

return keys
