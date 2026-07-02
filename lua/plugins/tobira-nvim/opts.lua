---@type table
local opts = {
  ---@type string | "en" | "ja"
  lang = "en",

  -- ms of inactivity before showing an ambient suggestion
  ---@type number
  idle_delay = 1500,

  -- enable ambient idle suggestions
  ---@type boolean
  idle_suggestions = true,

  -- s between automatic suggestions (default: 5 min)
  ---@type number
  suggestion_cooldown = 300,

  -- max times to suggest the same command per session
  ---@type number
  max_shown = 2,
}

return opts
