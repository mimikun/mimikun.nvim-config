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
    --expr = true,
    --noremap = true,
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
    --expr = true,
    --noremap = true,
    silent = true,
  },
}

return keys
