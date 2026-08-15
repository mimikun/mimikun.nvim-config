---@type string
local builds

-- Bundles `mcp-hub` binary along with the neovim plugin
local build_lua = "bundled_build.lua"

-- Installs `mcp-hub` node binary globally
--local build_npm = "npm install -g mcp-hub@latest"
--local build_yarn
--local build_pnpm = "pnpm install -g mcp-hub@latest"
--local build_bun

builds = build_lua

return builds
