---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>to",
    function()
      require("obsidian-tasks").open()
    end,
    mode = {
      "n",
    },
    desc = "Obsidian tasks: open",
    silent = true,
  },
  {
    "<leader>ta",
    function()
      require("obsidian-tasks").create()
    end,
    mode = {
      "n",
    },
    desc = "Obsidian tasks: create",
    silent = true,
  },
}

return keys
