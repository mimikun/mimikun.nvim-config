-- Repo-level project config loading
---@type CamouflageProjectConfigLoaderConfig
local project_config = {
  -- Enable repo config loading
  ---@type boolean | true
  enabled = true,

  -- Project config filename
  ---@type string | ".camouflage.yaml"
  filename = ".camouflage.yaml",

  -- Show warnings for project config parse/validation issues
  ---@type boolean | true
  notify = true,

  -- Gate the project file behind vim.secure.read / :trust
  ---@type boolean | false
  secure = false,

  -- Watch .camouflage.yaml for runtime changes
  ---@type boolean | true
  watch_enabled = true,

  ---@type string | "auto" | "autocmd" | "fs" | "both"
  watch_backend = "auto",

  -- Debounce for change events
  ---@type number | 200
  watch_debounce_ms = 200,

  -- Max roots to watch in one session
  ---@type number | 10
  max_watched_roots = 10,

  -- Show info notification after successful live reload
  ---@type boolean | false
  notify_on_reload = false,
}

return project_config
