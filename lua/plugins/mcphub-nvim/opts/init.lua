---@type MCPHub.Config
local opts = {
  -- NOTE: `mcp-hub` binary related options

  -- will be set based on system if not provided
  ---@type string?
  --cmd = nil,

  -- will be set based on system if not provided
  ---@type table?
  --cmdArgs = nil,

  -- Absolute path to MCP Servers config file (will create if not exists)
  config = vim.fn.expand("~/.config/mcphub/servers.json"),

  -- The port `mcp-hub` server listens to
  port = 37373,

  -- In cases where mcp-hub is hosted somewhere, set this to the server URL
  -- e.g `http://mydomain.com:customport` or `https://url_without_need_for_port.com`
  --server_url = nil,

  -- Delay in ms before shutting down the server when last instance closes (default: 5 minutes)
  shutdown_delay = 5 * 60 * 000,

  -- Whether to use bundled mcp-hub binary
  -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
  use_bundled_binary = true,

  --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
  mcp_request_timeout = 60000,

  -- Global environment variables available to all MCP servers (can be a table or a function returning a table)
  -- Environment variables that will be available to all MCP servers
  -- Global environment variables available to all MCP servers
  ---@type table | fun(context: MCPHub.JobContext): table
  global_env = function(_context)
    return {
      --it
    }
  end,

  ---@type MCPHub.WorkspaceConfig
  workspace = require("plugins.mcphub-nvim.opts.workspace"),

  -- NOTE: Chat-plugin related options

  -- Auto approve mcp tool calls
  -- Function to determine if a call should be auto-approved
  ---@type boolean | fun(parsed_params: MCPHub.ParsedParams): boolean | nil | string
  auto_approve = function(_parsed_params)
    return false
  end,

  -- Let LLMs start and stop MCP servers automatically
  auto_toggle_mcp_servers = true,

  ---@type MCPHub.Extensions.Config
  extensions = require("plugins.mcphub-nvim.opts.extensions"),

  -- NOTE: Plugin specific options

  -- add your custom lua native servers here
  ---@type table<string, NativeServerDef>
  native_servers = require("plugins.mcphub-nvim.opts.native_servers"),

  builtin_tools = require("plugins.mcphub-nvim.opts.builtin_tools"),

  ---@type MCPHub.UIConfig
  ui = require("plugins.mcphub-nvim.opts.ui"),

  -- Custom JSON parser function (e.g., require('json5').parse for JSON5 support)
  ---@type function | nil
  json_decode = function()
    return nil
  end,

  on_ready = function(_hub)
    -- Called when hub is ready
  end,

  on_error = function(_err)
    -- Called on errors
  end,

  ---@type LogConfig
  log = require("plugins.mcphub-nvim.opts.log"),
}

return opts
