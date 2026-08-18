---@type OctoConfigRuns
local runs = {
  ---@type OctoConfigWorkflowIcons
  icons = {
    ---@type string
    pending = "🕖",

    ---@type string
    in_progress = "🔄",

    ---@type string
    failed = "❌",

    ---@type string
    succeeded = "",

    ---@type string
    skipped = "⏩",

    ---@type string
    cancelled = "✖",
  },
}

return runs
