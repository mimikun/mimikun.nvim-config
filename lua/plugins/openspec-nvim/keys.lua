---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>os",
    function()
      require("openspec").summary()
    end,
    mode = {
      "n",
    },
    desc = "OpenSpec: Task summary",
    silent = true,
  },
  {
    "<leader>oh",
    function()
      require("openspec").html()
    end,
    mode = {
      "n",
    },
    desc = "OpenSpec: HTML change report",
    silent = true,
  },
  {
    "<leader>ow",
    function()
      require("openspec").workspace()
    end,
    mode = {
      "n",
    },
    desc = "OpenSpec: Workspace cockpit",
    silent = true,
  },
  {
    "<leader>oa",
    function()
      require("openspec").archive_search()
    end,
    mode = {
      "n",
    },
    desc = "OpenSpec: Archive search",
    silent = true,
  },
}

return keys
