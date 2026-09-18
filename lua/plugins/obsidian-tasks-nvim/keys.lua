---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>oo",
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
    "<leader>oa",
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
