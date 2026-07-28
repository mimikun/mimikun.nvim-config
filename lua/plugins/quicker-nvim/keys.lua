---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>q",
    function()
      require("quicker").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Toggle quickfix",
    silent = true,
  },
  {
    "<leader>l",
    function()
      require("quicker").toggle({
        loclist = true,
      })
    end,
    mode = {
      "n",
    },
    desc = "Toggle loclist",
    silent = true,
  },
}

return keys
