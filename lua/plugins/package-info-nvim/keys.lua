---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ns",
    function()
      require("package-info").show({ force = false })
    end,
    mode = {
      "n",
    },
    desc = "Show dependency versions",
    noremap = true,
    silent = true,
  },
  {
    "<leader>nc",
    function()
      require("package-info").hide()
    end,
    mode = {
      "n",
    },
    desc = "Hide dependency versions",
    noremap = true,
    silent = true,
  },
  {
    "<leader>nt",
    function()
      require("package-info").toggle()
    end,
    mode = {
      "n",
    },
    desc = "Toggle dependency versions",
    noremap = true,
    silent = true,
  },
  {
    "<leader>nu",
    function()
      require("package-info").update()
    end,
    mode = {
      "n",
    },
    desc = "Update dependency on the line",
    noremap = true,
    silent = true,
  },
  {
    "<leader>nd",
    function()
      require("package-info").delete()
    end,
    mode = {
      "n",
    },
    desc = "Delete dependency on the line",
    noremap = true,
    silent = true,
  },
  {
    "<leader>ni",
    function()
      require("package-info").install()
    end,
    mode = {
      "n",
    },
    desc = "Install a new dependency",
    noremap = true,
    silent = true,
  },
  {
    "<leader>np",
    function()
      require("package-info").change_version()
    end,
    mode = {
      "n",
    },
    desc = "Install a different dependency version",
    noremap = true,
    silent = true,
  },
}

return keys
