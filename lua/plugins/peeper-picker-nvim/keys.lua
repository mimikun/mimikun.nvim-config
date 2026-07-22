---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>pp",
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
    "<leader>ph",
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
