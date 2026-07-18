-- Forward-declared so the `callback` closure below can read `opts.timeout`
-- instead of duplicating its value.
---@type table
local opts

opts = {
  -- Maximum time (in milliseconds) to consider key presses as repeated.
  ---@type number
  max_time = 1000,

  -- Maximum count of repeated key presses allowed within the `max_time` period.
  ---@type number
  max_count = 3,

  -- Disable mouse support.
  ---@type boolean
  disable_mouse = true,

  -- Enable hint messages for better commands.
  ---@type boolean
  hint = true,

  -- Enable notification messages for restricted and disabled keys.
  ---@type boolean
  notification = true,

  -- Time to show notification in milliseconds, set to `false` to disable timeout.
  ---@type number | boolean
  timeout = 3000,

  -- Allow different keys to reset the count.
  ---@type boolean
  allow_different_key = true,

  -- Whether the plugin is enabled by default or not.
  ---@type boolean
  enabled = true,

  -- Enable forcing exit Insert mode if user is inactive in Insert mode.
  ---@type boolean
  force_exit_insert_mode = false,

  -- Maximum amount of idle time, in milliseconds, allowed in Insert mode.
  ---@type number
  max_insert_idle_ms = 5000,

  -- The behavior when `restricted_keys` trigger count mechanism.
  ---@type string | "block" | "hint"
  restriction_mode = "block",

  -- An option to customize the popup for the `Hardtime report`.
  ---@type table
  ui = require("plugins.hardtime-nvim.opts.ui"),

  -- Keys in what modes that reset the count.
  ---@type table
  resetting_keys = require("plugins.hardtime-nvim.opts.resetting_keys"),

  -- Keys in what modes triggering the count mechanism.
  ---@type table
  restricted_keys = require("plugins.hardtime-nvim.opts.restricted_keys"),

  -- Keys in what modes are disabled.
  ---@type table
  disabled_keys = require("plugins.hardtime-nvim.opts.disabled_keys"),

  -- Hardtime is disabled under these filetypes.
  ---@type table
  disabled_filetypes = require("plugins.hardtime-nvim.opts.disabled_filetypes"),

  -- `key` is a string pattern you want to match, `value` is a table of hint message and pattern length.
  -- Learn more about Lua string pattern (https://www.lua.org/pil/20.2.html).
  ---@type table
  hints = require("plugins.hardtime-nvim.opts.hints"),

  -- `callback` function can be used to override the default notification behavior."
  ---@type function
  callback = function(text)
    vim.notify(text, vim.log.levels.WARN, {
      title = "Hardtime",
      timeout = opts.timeout,
    })
  end,
}

return opts
