-- lua/line-justice/themes/init.lua
--
-- Theme registry for line-justice.nvim.
--
-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  This module is the single source of truth for all colour themes.       │
-- │                                                                         │
-- │  Built-in themes are loaded lazily on first use from sibling files:     │
-- │    • horizon.lua   — Horizon (default)                                  │
-- │    • dawn.lua      — Dawn                                               │
-- │    • midnight.lua  — Midnight                                           │
-- │                                                                         │
-- │  Developers can register additional themes at runtime via:              │
-- │    require("line-justice").themes.register(spec)                        │
-- │                                                                         │
-- │  A theme spec must conform to LineJusticeThemeSpec (see types below).   │
-- └─────────────────────────────────────────────────────────────────────────┘
--
-- ── Quick-reference ──────────────────────────────────────────────────────────
--
--   Registry API (all accessible via require("line-justice").themes):
--
--     register(spec)         Register a new theme (or overwrite an existing one)
--     get(name)              Return a theme's colors table, or nil
--     list()                 Return a sorted list of all registered theme names
--     exists(name)           Boolean — true if the theme name is registered
--
-- ── Theme spec shape ─────────────────────────────────────────────────────────
--
--   ---@type LineJusticeThemeSpec
--   {
--     name        = "MyTheme",                  -- unique identifier (case-sensitive)
--     description = "Short human description.", -- shown in error messages / docs
--     author      = "Your Name",                -- optional credit
--     colors = {
--       CursorLine    = { fg = "#rrggbb", bold   = true },
--       AbsoluteAbove = { fg = "#rrggbb" },
--       AbsoluteBelow = { fg = "#rrggbb" },
--       RelativeAbove = { fg = "#rrggbb" },
--       RelativeBelow = { fg = "#rrggbb" },
--       WrappedLine   = { fg = "#rrggbb", italic = true },
--     },
--   }
--
-- ─────────────────────────────────────────────────────────────────────────────

-- ---------------------------------------------------------------------------
-- LuaDoc types
-- ---------------------------------------------------------------------------

---A complete theme specification that can be passed to themes.register().
---
--- `name` is the string users pass to `line_numbers.theme = "..."`.
--- `colors` is a LineJusticeOverrides-compatible table — all six keys should
--- be provided (missing keys fall through to auto-detect / FALLBACK).
---
---@class LineJusticeThemeSpec
---@field name        string                 Unique theme identifier (case-sensitive)
---@field description string                 Human-readable description
---@field author?     string                 Optional author credit
---@field colors      LineJusticeOverrides   All six colour slots

-- ---------------------------------------------------------------------------
-- Required color keys — used for validation
-- ---------------------------------------------------------------------------

---@type string[]
local REQUIRED_COLOR_KEYS = {
  "CursorLine",
  "AbsoluteAbove",
  "AbsoluteBelow",
  "RelativeAbove",
  "RelativeBelow",
  "WrappedLine",
}

-- ---------------------------------------------------------------------------
-- Internal registry store
-- ---------------------------------------------------------------------------

---Stores theme name → LineJusticeThemeSpec (the full spec, not just colors)
---@type table<string, LineJusticeThemeSpec>
local registry = {}

-- ---------------------------------------------------------------------------
-- Built-in theme definitions (paths relative to this file)
-- ---------------------------------------------------------------------------

---@type table<string, string>  name → require path
local BUILTIN_PATHS = {
  Horizon = "line-justice.themes.horizon",
  Dawn = "line-justice.themes.dawn",
  Midnight = "line-justice.themes.midnight",
}

-- ---------------------------------------------------------------------------
-- Validation helper
-- ---------------------------------------------------------------------------

---Validate a LineJusticeThemeSpec table.
---Returns nil on success, or an error string describing the problem.
---@param spec any
---@return string|nil
local function validate(spec)
  if type(spec) ~= "table" then
    return "theme spec must be a table, got " .. type(spec)
  end
  if type(spec.name) ~= "string" or spec.name == "" then
    return "theme spec.name must be a non-empty string"
  end
  if type(spec.description) ~= "string" or spec.description == "" then
    return "theme spec.description must be a non-empty string"
  end
  if type(spec.colors) ~= "table" then
    return "theme spec.colors must be a table"
  end
  for _, key in ipairs(REQUIRED_COLOR_KEYS) do
    local slot = spec.colors[key]
    if slot ~= nil then
      -- If present it must be a table with a string fg field
      if type(slot) ~= "table" then
        return "theme spec.colors." .. key .. " must be a table"
      end
      if slot.fg ~= nil and type(slot.fg) ~= "string" then
        return "theme spec.colors." .. key .. ".fg must be a string (hex color)"
      end
      if slot.fg ~= nil and not slot.fg:match("^#%x%x%x%x%x%x$") then
        return "theme spec.colors." .. key .. '.fg must be a valid hex color like "#rrggbb", got "' .. slot.fg .. '"'
      end
    end
  end
  return nil
end

-- ---------------------------------------------------------------------------
-- Public registry API
-- ---------------------------------------------------------------------------

local M = {}

---Register a new theme (or overwrite an existing one by the same name).
---
--- Validates the spec before storing it. Emits a WARN and does nothing if
--- validation fails, so a bad spec never corrupts the registry.
---
--- Built-in themes are registered lazily — you can overwrite them by
--- registering a spec with the same name.
---
---@param spec LineJusticeThemeSpec
---@return boolean  true on success, false if validation failed
function M.register(spec)
  local err = validate(spec)
  if err then
    vim.notify("[line-justice] Cannot register theme: " .. err, vim.log.levels.WARN)
    return false
  end
  registry[spec.name] = spec
  return true
end

---Retrieve a theme's colors table by name.
---
--- Loads built-in themes lazily on first access.
--- Returns nil (with a WARN) if the name is not registered.
---
---@param name string
---@return LineJusticeOverrides|nil
function M.get(name)
  -- Already in registry
  if registry[name] then
    return registry[name].colors
  end

  -- Try loading a built-in
  local path = BUILTIN_PATHS[name]
  if path then
    local ok, spec = pcall(require, path)
    if ok and type(spec) == "table" then
      local err = validate(spec)
      if err then
        vim.notify("[line-justice] Built-in theme '" .. name .. "' failed validation: " .. err, vim.log.levels.ERROR)
        return nil
      end
      registry[name] = spec
      return spec.colors
    else
      vim.notify(
        "[line-justice] Failed to load built-in theme '" .. name .. "': " .. tostring(spec),
        vim.log.levels.ERROR
      )
      return nil
    end
  end

  -- Unknown theme
  vim.notify(
    "[line-justice] Unknown theme '"
      .. name
      .. "'. "
      .. "Available: "
      .. table.concat(M.list(), ", ")
      .. ". "
      .. 'Register a custom theme with require("line-justice").themes.register(spec).',
    vim.log.levels.WARN
  )
  return nil
end

---Return a sorted list of all registered theme names plus all built-in names.
---@return string[]
function M.list()
  local seen = {}
  -- All registered
  for name in pairs(registry) do
    seen[name] = true
  end
  -- All built-ins (even if not yet loaded)
  for name in pairs(BUILTIN_PATHS) do
    seen[name] = true
  end
  local names = vim.tbl_keys(seen)
  table.sort(names)
  return names
end

---Return true if a theme with the given name is available (registered or built-in).
---@param name string
---@return boolean
function M.exists(name)
  if registry[name] then
    return true
  end
  if BUILTIN_PATHS[name] then
    return true
  end
  return false
end

return M
