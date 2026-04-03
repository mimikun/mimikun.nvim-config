---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps (which-key)",
    { silent = true },
  },
}

return keys
