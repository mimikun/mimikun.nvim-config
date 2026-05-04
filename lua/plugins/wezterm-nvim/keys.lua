---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>wt",
    function()
      require("wezterm").switch_tab.index()
    end,
    mode = "n",
    desc = "Switch tab by index using vim.v.count",
    silent = true,
  },
}

return keys
