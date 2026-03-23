---@type table
local opts = {
  extra_args = {},
  edit = {
    watch = false,
    force = false,
    ignore_patterns = {
      "run_onchange_.*",
      "run_once_.*",
      "%.chezmoiignore",
      "%.chezmoitemplate",
      "%.chezmoiexternal.*",
      "%.chezmoiroot",
      "%.chezmoiversion",
    },
  },
  events = {
    on_open = {
      notification = {
        enable = true,
        msg = "Opened a chezmoi-managed file",
        opts = {},
      },
    },
    on_watch = {
      notification = {
        enable = true,
        msg = "This file will be automatically applied",
        opts = {},
      },
    },
    on_apply = {
      notification = {
        enable = true,
        msg = "Successfully applied",
        opts = {},
      },
    },
  },
  telescope = {
    select = { "<CR>" },
  },
}

return opts
