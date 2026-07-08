---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>tt",
    function()
      require("tabterm").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Toggle tabterm",
    silent = true,
  },
  {
    "<leader>ts",
    function()
      require("tabterm").new_shell()
    end,
    mode = {
      "n",
    },
    desc = "New tabterm shell",
    silent = true,
  },
  {
    "<leader>tc",
    function()
      require("tabterm").new_command()
    end,
    mode = {
      "n",
    },
    desc = "New tabterm command",
    silent = true,
  },
}

return keys
