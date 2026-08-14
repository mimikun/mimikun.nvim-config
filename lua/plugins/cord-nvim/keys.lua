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
    desc = "Cord: toggle presence",
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
    desc = "Cord: toggle idle (force)",
    silent = true,
  },
}

return keys
