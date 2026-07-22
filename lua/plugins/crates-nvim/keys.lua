---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ct",
    function()
      require("crates").toggle()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cr",
    function()
      require("crates").reload()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cv",
    function()
      require("crates").show_versions_popup()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cf",
    function()
      require("crates").show_features_popup()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cd",
    function()
      require("crates").show_dependencies_popup()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cu",
    function()
      require("crates").update_crate()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cu",
    function()
      require("crates").update_crates()
    end,
    mode = {
      "v",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>ca",
    function()
      require("crates").update_all_crates()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cU",
    function()
      require("crates").upgrade_crate()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cU",
    function()
      require("crates").upgrade_crates()
    end,
    mode = {
      "v",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cA",
    function()
      require("crates").upgrade_all_crates()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cx",
    function()
      require("crates").expand_plain_crate_to_inline_table()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cX",
    function()
      require("crates").extract_crate_into_table()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cH",
    function()
      require("crates").open_homepage()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cR",
    function()
      require("crates").open_repository()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cD",
    function()
      require("crates").open_documentation()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cC",
    function()
      require("crates").open_crates_io()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
  {
    "<leader>cL",
    function()
      require("crates").open_lib_rs()
    end,
    mode = {
      "n",
    },
    desc = "",
    silent = true,
  },
}

return keys
