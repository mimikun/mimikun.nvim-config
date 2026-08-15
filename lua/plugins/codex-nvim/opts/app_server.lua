---@type { cmd: string[] }
local app_server = {
  ---@type string[]
  cmd = {
    "codex",
    -- A named Codex profile:
    --"--profile",
    --"work",
    "app-server",
  },
}

return app_server
