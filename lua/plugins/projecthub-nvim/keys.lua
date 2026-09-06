---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Pj",
    function()
      require("projecthub").open()
    end,
    mode = {
      "n",
    },
    desc = "ProjectHub Dashboard",
    silent = true,
  },
}

return keys
