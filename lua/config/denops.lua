-- denops enablement gate.
--
-- denops requires a running Deno process, so every plugin under
-- `lua/denops-plugins/` is gated on this single check. denops is OFF by
-- default and enabled only on the explicitly permitted { os, host }
-- combinations below.
--
-- Add a new machine by appending an { os = ..., host = ... } entry; both are
-- compared case-insensitively via config.host.
--
-- Usage (in a lazy.nvim spec):
--   local denops_enabled = require("config.denops")
--   cond = denops_enabled,
--   enabled = denops_enabled,

local host = require("config.host")

---@type { os: string, host: string }[]
local allowlist = {
  { os = "linux", host = "wakamo" },
}

for _, entry in ipairs(allowlist) do
  if host.is_os(entry.os) and host.is(entry.host) then
    return true
  end
end

return false
