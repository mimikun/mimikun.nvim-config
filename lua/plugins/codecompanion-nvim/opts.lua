---@type table
local opts = {
  --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
  interactions = {
    -- NOTE: Change the adapter as required

    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
  },

  -- NOTE: The log_level is in `opts.opts`
  opts = {
    -- or "TRACE"
    log_level = "DEBUG",
  },
}

return opts
