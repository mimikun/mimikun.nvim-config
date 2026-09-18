---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Gad",
    function()
      require("github-actions").dispatch_workflow()
    end,
    mode = {
      "n",
    },
    desc = "Dispatch workflow",
    silent = true,
  },
  {
    "<leader>Gah",
    function()
      require("github-actions").show_history()
    end,
    mode = {
      "n",
    },
    desc = "Show workflow history",
    silent = true,
  },
  {
    "<leader>Gap",
    function()
      require("github-actions").show_history({ pr_mode = true })
    end,
    mode = {
      "n",
    },
    desc = "Show workflow history by branch/PR",
    silent = true,
  },
  {
    "<leader>Gaw",
    function()
      require("github-actions").watch_workflow()
    end,
    mode = {
      "n",
    },
    desc = "Watch running workflow",
    silent = true,
  },
  {
    "<leader>Gao",
    function()
      require("github-actions").open_workflow_url()
    end,
    mode = {
      "n",
    },
    desc = "Open workflow URL in browser",
    silent = true,
  },
}

return keys
