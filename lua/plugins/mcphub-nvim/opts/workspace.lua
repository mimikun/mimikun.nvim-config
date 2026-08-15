---@type MCPHub.WorkspaceConfig
local workspace = {
  -- Enables workspace-specific hubs
  -- Master switch for workspace-specific hubs
  ---@type boolean
  enabled = true,

  -- Files to look for when detecting project boundaries (VS Code format supported)
  -- Files to search for (in order)
  ---@type string[]
  look_for = {
    ".mcphub/servers.json",
    ".vscode/mcp.json",
    ".cursor/mcp.json",
  },

  -- Whether to listen to DirChanged events to reload workspace config
  -- Automatically switch hubs on DirChanged event
  ---@type boolean
  reload_on_dir_changed = true,

  -- Port range for workspace hubs
  -- Port range for generating unique workspace ports
  ---@type { min: number, max: number }
  port_range = {
    ---@type number
    min = 40000,

    ---@type number
    max = 41000,
  },

  -- Optional function returning custom port number.
  -- Called when generating ports to allow custom port assignment logic
  -- Function that determines that returns the port
  ---@type fun(): number | nil
  get_port = function()
    return nil
  end,
}

return workspace
