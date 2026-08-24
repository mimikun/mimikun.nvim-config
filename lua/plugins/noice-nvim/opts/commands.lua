-- You can add any custom commands below that will be available with `:Noice command`
---@type table<string, NoiceCommand>
local commands = {
  history = {
    -- options for the message history that you get with `:Noice`
    view = "split",
    opts = {
      enter = true,
      format = "details",
    },
    filter = {
      any = {
        {
          event = "notify",
        },
        {
          error = true,
        },
        {
          warning = true,
        },
        {
          event = "msg_show",
          kind = { "" },
        },
        {
          event = "lsp",
          kind = "message",
        },
      },
    },
  },

  -- :Noice last
  last = {
    view = "popup",
    opts = {
      enter = true,
      format = "details",
    },
    filter = {
      any = {
        {
          event = "notify",
        },
        {
          error = true,
        },
        {
          warning = true,
        },
        {
          event = "msg_show",
          kind = {
            "",
          },
        },
        {
          event = "lsp",
          kind = "message",
        },
      },
    },
    filter_opts = {
      count = 1,
    },
  },

  -- :Noice errors
  errors = {
    -- options for the message history that you get with `:Noice`
    view = "popup",
    opts = {
      enter = true,
      format = "details",
    },
    filter = {
      error = true,
    },
    filter_opts = {
      reverse = true,
    },
  },

  all = {
    -- options for the message history that you get with `:Noice`
    view = "split",
    opts = {
      enter = true,
      format = "details",
    },
    filter = {},
  },
}

return commands
