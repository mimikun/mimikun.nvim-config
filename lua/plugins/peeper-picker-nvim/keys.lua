---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>to",
    function()
      require("peeper_picker").find()
    end,
    mode = {
      "n",
    },
    desc = "Peeper Picker",
    silent = true,
  },
  {
    "<leader>tO",
    function()
      require("peeper_picker").history()
    end,
    mode = {
      "n",
    },
    desc = "Peeper Picker History",
    silent = true,
  },
}

return keys
