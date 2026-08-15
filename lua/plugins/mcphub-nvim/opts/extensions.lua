---@type MCPHub.Extensions.Config
local extensions = {
  avante = {
    enabled = true,
    -- make /slash commands from MCP server prompts
    make_slash_commands = true,
  },
  copilotchat = {
    enabled = true,
    convert_tools_to_functions = true,
    convert_resources_to_functions = true,
    add_mcp_prefix = false,
  },
}

return extensions
