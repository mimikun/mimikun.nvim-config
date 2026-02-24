---@type table
local opts = {
  ---@type number Maximum time (in milliseconds) to consider key presses as repeated.
  max_time = 1000,

  ---@type number Maximum count of repeated key presses allowed within the `max_time` period.
  max_count = 3,

  ---@type boolean Disable mouse support.
  disable_mouse = true,

  ---@type boolean Enable hint messages for better commands.
  hint = true,

  ---@type boolean Enable notification messages for restricted and disabled keys.
  notification = true,

  ---@type number | boolean Time to show notification in milliseconds, set to `false` to disable timeout.
  timeout = 3000,

  ---@type boolean Allow different keys to reset the count.
  allow_different_key = true,

  ---@type boolean Whether the plugin is enabled by default or not.
  enabled = true,

  ---@type boolean Enable forcing exit Insert mode if user is inactive in Insert mode.
  force_exit_insert_mode = false,

  ---@type number Maximum amount of idle time, in milliseconds, allowed in Insert mode.
  max_insert_idle_ms = 5000,

  ---@type string | "block" | "hint" The behavior when `restricted_keys` trigger count mechanism.
  restriction_mode = "block",

  ---@type table An option to customize the popup for the `Hardtime report`.
  ui = require("plugins.hardtime-nvim.opts.ui"),

  ---@type table Keys in what modes that reset the count.
  resetting_keys = require("plugins.hardtime-nvim.opts.resetting_keys"),

  ---@type table Keys in what modes triggering the count mechanism.
  restricted_keys = require("plugins.hardtime-nvim.opts.restricted_keys"),

  ---@type table Keys in what modes are disabled.
  disabled_keys = require("plugins.hardtime-nvim.opts.disabled_keys"),

  ---@type table Hardtime is disabled under these filetypes.
  disabled_filetypes = require("plugins.hardtime-nvim.opts.disabled_filetypes"),

  -- `key` is a string pattern you want to match, `value` is a table of hint message and pattern length.
  -- Learn more about Lua string pattern (https://www.lua.org/pil/20.2.html).
  ---@type table
  hints = require("plugins.hardtime-nvim.opts.hints"),

  ---@type function `callback` function can be used to override the default notification behavior."
  callback = function(text)
    vim.notify(text, vim.log.levels.WARN, {
      title = "Hardtime",
      timeout = M.config.timeout,
    })
  end,
}

return opts
