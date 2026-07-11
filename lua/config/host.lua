-- Host detection helpers.
--
-- Centralizes hostname lookups so machine-specific branches can be written as
-- `if host.is("azusa") then ...` from anywhere in the config.

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

--- Return true when the current host matches `name` (case-insensitive).
---
--- @param name string Hostname to compare against, e.g. "azusa".
--- @return boolean
---
--- Example:
---   if require("config.host").is("azusa") then
---     vim.g.clipboard = nil
---   end
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
---     vim.g.clipboard = nil
---   end
function M.any(names)
  for _, name in ipairs(names) do
    if M.is(name) then
      return true
    end
  end
  return false
end

return M
