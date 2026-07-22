---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Ct",
    function()
      require("cord.api.command").toggle_presence()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>Ci",
    function()
      require("cord.api.command").toggle_idle_force()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
}

return keys
