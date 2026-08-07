-- Per-project todos
local per_project = {
  -- Enable per-project todos
  enabled = true,

  -- Default filename for project todos
  default_filename = "dooing.json",

  -- Auto-add to .gitignore
  ---@type boolean | false | string | "prompt"
  auto_gitignore = false,

  -- What to do when file missing ("prompt"/"auto_create")
  ---@type string | "prompt" | "auto_create"
  on_missing = "prompt",

  -- Auto-open project todos on startup if they exist
  auto_open_project_todos = false,
}

return per_project
