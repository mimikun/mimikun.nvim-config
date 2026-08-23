---@type LazyKeysSpec[]
local keys = {
  {
    "_",
    function()
      require("keeper.view").view_buffer()
    end,
    mode = {
      "n",
    },
    desc = "Open the keeper buffer list",
    silent = true,
  },
}

return keys
