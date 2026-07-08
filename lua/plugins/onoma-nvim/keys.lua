---@type LazyKeysSpec[]
local keys = {
  {
    "fs",
    function()
      -- Snacks
      require("snacks").picker.get_symbols()
      -- Telescope
      --require("telescope").extensions.onoma.get_symbols({})
    end,
    mode = {
      "n",
      "x",
      "v",
    },
    desc = "Symbols",
    silent = true,
  },
}

return keys
