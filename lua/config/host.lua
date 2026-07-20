-- Environment detection helpers.
--
-- Single source of truth for host, OS, hardware and standard-path lookups so
-- machine-specific branches can be written as `if host.is("azusa") then ...` or
-- `if host.is_windows() then ...` from anywhere in the config.
--
-- Detection is resolved once at load time and cached for the session; callers
-- can treat everything here as constant for the running Neovim instance.

local M = {}

-- Lower-cased hostname, resolved once and cached for the session.
---@type string
M.name = vim.uv.os_gethostname():lower()

-- Lower-cased OS name, resolved once and cached for the session.
-- e.g. "linux", "darwin", "windows_nt".
---@type string
M.os = vim.uv.os_uname().sysname:lower()

--- Return true when the current OS matches `name` (case-insensitive).
---
--- @param name string OS name to compare against, e.g. "linux", "darwin".
--- @return boolean
---
--- Example:
---   if require("config.host").is_os("linux") then
---     -- Linux-only branch
---   end
function M.is_os(name)
  return M.os == name:lower()
end

--- Return true on Linux.
--- @return boolean
function M.is_linux()
  return M.is_os("linux")
end

--- Return true on macOS.
--- @return boolean
function M.is_mac()
  return M.is_os("darwin")
end

--- Return true on Windows.
--- @return boolean
function M.is_windows()
  return M.is_os("windows_nt")
end

-- Whether Neovim reports a WSL environment, resolved once and cached.
---@type boolean
local is_wsl = vim.fn.has("wsl") == 1

-- Whether Neovim reports a Unix-like environment, resolved once and cached.
---@type boolean
local is_unix = vim.fn.has("unix") == 1

--- Return true under Windows Subsystem for Linux.
--- @return boolean
function M.is_wsl()
  return is_wsl
end

--- Return true on any Unix-like OS (Linux, macOS, BSD, ...).
--- @return boolean
function M.is_unix()
  return is_unix
end

--- Return true when the current host matches `name` (case-insensitive).
---
--- @param name string Hostname to compare against, e.g. "azusa".
--- @return boolean
---
--- Example:
---   local concurrency = require("config.host").is("azusa") and 4 or nil
function M.is(name)
  return M.name == name:lower()
end

--- Return true when the current host matches any of `names` (case-insensitive).
---
--- @param names string[] Hostnames to compare against, e.g. { "azusa", "corona" }.
--- @return boolean
---
--- Example:
---   if require("config.host").any({ "azusa", "corona" }) then
---     -- runs on either machine
---   end
function M.any(names)
  for _, name in ipairs(names) do
    if M.is(name) then
      return true
    end
  end
  return false
end

-- Personal machines. Anything not listed here is treated as a work machine.
---@type table<string, boolean>
local home_pcs = {
  ["wakamo"] = true,
  ["izuna"] = true,
  ["azusa"] = true,
}

--- Return true when running on one of the personal machines in `home_pcs`.
--- @return boolean
function M.is_home()
  return home_pcs[M.name] == true
end

--- Return true when running on a machine that is not a personal one.
--- @return boolean
function M.is_work()
  return not M.is_home()
end

--- Return true on the "azusa" host (convenience wrapper over `is`).
--- @return boolean
function M.is_azusa()
  return M.is("azusa")
end

-- Total physical memory in bytes, resolved once and cached.
---@type number
local total_memory = vim.uv.get_total_memory()

-- Minimum memory (bytes) a machine needs before it is considered capable of
-- running the heavier plugin set. Windows needs more headroom than Linux.
-- TODO: Replace mimikun/human_rights.nvim
---@type table<string, number>
local human_rights_memory = {
  -- 4GB
  linux = 4294967296,
  -- 9GB
  windows = 9663676416,
}

--- Return true when the machine has enough memory for the heavy plugin set.
---
--- @return boolean
---
--- Example:
---   if require("config.host").is_human_rights() then
---     -- enable resource-hungry plugins
---   end
function M.is_human_rights()
  local threshold = M.is_windows() and human_rights_memory.windows or human_rights_memory.linux
  return total_memory > threshold
end

-- Config version string, bumped on major config reworks.
---@type string
M.config_version = "5.0.0"

-- OS path separator ("\" on Windows, "/" elsewhere), taken from Lua's own
-- package.config so it needs no OS branch.
---@type string
M.path_sep = string.sub(package.config, 1, 1)

-- Standard directories resolved from vim.fn.stdpath, plus derived config/data
-- paths. All absolute and resolved once at load time.
--
-- NOTE: These have no consumers yet; they are provided as a single source of
-- truth for future use.
---@type table<string, string>
M.paths = {}
do
  local config = vim.fn.stdpath("config") --[[@as string]]
  local cache = vim.fn.stdpath("cache") --[[@as string]]
  local data = vim.fn.stdpath("data") --[[@as string]]
  local state = vim.fn.stdpath("state") --[[@as string]]

  M.paths.config = config
  M.paths.cache = cache
  M.paths.data = data
  M.paths.state = state
  -- Legacy `:h packpath` site dir under the data directory.
  M.paths.site = data .. "/site"
  M.paths.plugins = config .. "/plugins"
  M.paths.snippets = config .. "/snippets"
  M.paths.parser_install = data .. "/parser"
  M.paths.scratch_buf = data .. "/scratch"
  M.paths.mason_lockfile = config .. "/mason-lock.json"
  -- Under lazy.nvim's real install root (stdpath("data")/lazy), see lua/config/lazy.lua.
  M.paths.friendly_snippets = data .. "/lazy/friendly-snippets"
end

return M
