--- yankdown.nvim / check
--- Dependency verification and caching.
---
--- The default path is intentionally quiet: cache dependency status once per
--- session, but only show diagnostics when the user explicitly runs
--- :YankdownCheck. Runtime paste fallback warnings remain in paste.lua.

local M = {}

M._cache = nil

--- Safely check whether an environment variable is set to a non-empty string.
--- Neovim's vim.env may contain vim.NIL (JSON null) for deleted keys in tests.
local function env_set(name)
  local val = vim.env[name]
  if val == nil or val == vim.NIL then
    return false
  end
  return val ~= ""
end

local function executable(name)
  return vim.fn.executable(name) == 1
end

local function add(deps, dep)
  table.insert(deps, dep)
end

local function probe()
  local deps = {}

  add(deps, {
    name = "pandoc",
    found = executable("pandoc"),
    optional = false,
    reason = "HTML to Markdown conversion engine",
    platform = nil,
  })

  if vim.fn.has("macunix") == 1 then
    add(deps, {
      name = "osascript",
      found = executable("osascript"),
      optional = false,
      reason = "macOS clipboard read (built-in)",
      platform = "macOS",
    })
    return deps
  end

  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    add(deps, {
      name = "powershell.exe",
      found = executable("powershell.exe"),
      optional = false,
      reason = "Windows clipboard HTML read",
      platform = "Windows",
    })
    return deps
  end

  local has_wayland = env_set("WAYLAND_DISPLAY")
  local has_x11 = env_set("DISPLAY")
  local wl_found = has_wayland and executable("wl-paste") or false
  local xclip_found = has_x11 and executable("xclip") or false

  -- Mirror clipboard.provider() behavior: Wayland is preferred when usable,
  -- but X11 is a valid fallback when both DISPLAY and WAYLAND_DISPLAY exist.
  -- Therefore, a missing wl-paste is only required when no xclip fallback works.
  if has_wayland then
    add(deps, {
      name = "wl-paste",
      found = wl_found,
      optional = has_x11 and xclip_found,
      reason = "Wayland clipboard read (from wl-clipboard package)",
      platform = "Wayland",
    })
  end

  if has_x11 then
    add(deps, {
      name = "xclip",
      found = xclip_found,
      optional = has_wayland and wl_found,
      reason = "X11 clipboard read",
      platform = "X11",
    })
  end

  if not has_wayland and not has_x11 then
    add(deps, {
      name = "display-server",
      found = false,
      optional = true,
      reason = "No DISPLAY or WAYLAND_DISPLAY set; clipboard unavailable",
      platform = "headless",
    })
  end

  return deps
end

--- Clear the cached dependency result. Mostly useful for tests.
function M.clear_cache()
  M._cache = nil
end

--- Probe dependencies, cached once per session by default.
---@param opts? { force?: boolean }
function M.check(opts)
  opts = opts or {}
  if opts.force or not M._cache then
    M._cache = probe()
  end
  return M._cache
end

--- Return true when every required dependency is present.
---@param deps? table[] result from M.check(); re-checks/caches when nil
function M.ok(deps)
  deps = deps or M.check()
  for _, dep in ipairs(deps) do
    if not dep.optional and not dep.found then
      return false
    end
  end
  return true
end

--- Format the dependency list into a human-readable multi-line string.
---@param deps? table[]
function M.format(deps)
  deps = deps or M.check({ force = true })
  local lines = {}
  table.insert(lines, "yankdown.nvim — dependency check")
  table.insert(lines, "---------------------------------")
  for _, dep in ipairs(deps) do
    local status = dep.found and "✓" or "✗"
    local tag = dep.optional and " (optional)" or ""
    local plat = dep.platform and ("  [" .. dep.platform .. "]") or ""
    table.insert(lines, ("  %s %s%s  — %s%s"):format(status, dep.name, tag, dep.reason, plat))
  end
  table.insert(lines, "")
  table.insert(
    lines,
    M.ok(deps) and "All required dependencies found."
      or "Some required dependencies are missing — falling back to native paste."
  )
  return table.concat(lines, "\n")
end

--- Emit a single vim.notify warning listing all missing required deps.
--- This is kept for callers that explicitly want it, but setup() does not use
--- it by default to avoid noisy startup notifications.
---@param config? { notify?: boolean }
function M.warn_if_missing(config)
  config = config or {}
  if config.notify == false then
    return
  end

  local deps = M.check()
  local missing = {}
  for _, dep in ipairs(deps) do
    if not dep.optional and not dep.found then
      table.insert(missing, dep.name)
    end
  end

  if #missing > 0 then
    vim.notify(
      ("yankdown.nvim: missing %s — falling back to native paste"):format(table.concat(missing, ", ")),
      vim.log.levels.WARN
    )
  end
end

return M
