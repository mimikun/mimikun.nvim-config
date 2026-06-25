-- Redirect editor messages (e.g. :write) to juu.notify.
-- Requires notify.
-- Set to false to disable.
-- Disabled automatically if noice.nvim is loaded.
---@type JuuMessagesConfig | false | nil
local messages = {
  -- When false, do not attach |vim.ui_attach()| for |ui-messages| (default: true)
  ---@type boolean | nil
  enabled = true,

  -- skip duplicate msg_show with the same text within this window
  -- Skip a |msg_show| if the trimmed text matches the previous one within this many ms (default: 200).
  -- Set to false to disable (e.g. if you need every echo).
  ---@type number | false | nil
  dedupe_ms = 200,

  ---@field exclude_kinds table<string, boolean>|string[]|nil Extra kinds to leave in the default message UI (merged with built-in exclusions). For a map, use `false` to remove a built-in exclusion (e.g. `progress = false`). See |ui-messages| kinds.
  ---@field include_kinds string[]|nil If set, only these kinds are redirected to notifications (overrides exclude list).
  ---@field filter fun(kind: string, text: string, trigger: string|nil): boolean|nil If set, only redirect when this returns true.
  ---@field opts table|nil Extra options passed to |juu.notify.notify| (e.g. title, ttl).
}

return messages
