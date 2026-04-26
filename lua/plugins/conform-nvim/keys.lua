---@type LazyKeysSpec[]
local keys = {
  {
    -- Customize or remove this keymap to your liking
    "<leader>f",
    function()
      require("conform").format({
        async = true,
      })
    end,
    mode = {
      "n",
    },
    desc = "Format buffer",
    silent = true,
  },
}

return keys
