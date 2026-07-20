-- check-options-sync.lua - Detect drift between the running Neovim's option
-- set and lua/config/options.lua.
--
-- Run via the wrapper (recommended, cds to repo root first):
--   scripts/check-options-sync.sh
-- or directly:
--   nvim --headless -l scripts/check-options-sync.lua
--
-- Why
--   lua/config/options.lua is a self-documenting, exhaustive list of every
--   Neovim option (each set to its default or the user's override, or left
--   commented when it has no meaningful/portable default). Neovim upgrades add,
--   rename, and remove options, so the file silently drifts out of date. This
--   checker diffs the authoritative option set reported by
--   `nvim_get_all_options_info()` against the names mentioned in the file.
--
-- What it reports
--   MISSING - option exists in this Neovim but is absent from options.lua
--             (add it, following the file's classification rules).
--   STALE   - option is mentioned in options.lua but no longer exists in this
--             Neovim (removed/renamed upstream), excluding the intentionally
--             kept historical notes in IGNORE_STALE below.
--
--   Set-vs-commented state and actual values are NOT checked: user overrides
--   and "keep commented" defaults are intentional. Only the *set of option
--   names* is compared for completeness.
--
-- Exit code: 0 when in sync, 1 when any MISSING or STALE option is found.

local OPTIONS_FILE = "lua/config/options.lua"

-- Names mentioned in options.lua that intentionally do NOT exist in modern
-- Neovim. Kept as historical notes (see the `-- XXX: removed?` markers), so
-- they must not be reported as STALE.
local IGNORE_STALE = {
  term = true,
  ttytype = true,
}

--- Collect the option names referenced in options.lua (set or commented).
---@param path string Path to options.lua, relative to cwd.
---@return table<string, boolean> names Set of option names found in the file.
---@return string|nil read_error Set when the file could not be read.
local function names_in_file(path)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then
    return {}, tostring(lines)
  end
  local names = {}
  for _, line in ipairs(lines) do
    -- matches both `vim.opt.foo` and the commented `--vim.opt.foo`
    for name in line:gmatch("vim%.opt%.([%a_]+)") do
      names[name] = true
    end
  end
  return names, nil
end

--- Collect the authoritative option names from the running Neovim.
---@return table<string, boolean> names Set of every option name Neovim knows.
local function names_in_nvim()
  local names = {}
  for name in pairs(vim.api.nvim_get_all_options_info()) do
    names[name] = true
  end
  return names
end

--- Sorted keys of a set, filtered by an optional predicate.
---@param set table<string, boolean>
---@param keep? fun(name: string): boolean
---@return string[]
local function sorted_keys(set, keep)
  local out = {}
  for name in pairs(set) do
    if not keep or keep(name) then
      out[#out + 1] = name
    end
  end
  table.sort(out)
  return out
end

local file_names, read_error = names_in_file(OPTIONS_FILE)
if read_error then
  io.stderr:write(string.format("ERROR  cannot read %s: %s\n", OPTIONS_FILE, read_error))
  os.exit(1)
end

local nvim_names = names_in_nvim()

local missing = sorted_keys(nvim_names, function(name)
  return not file_names[name]
end)
local stale = sorted_keys(file_names, function(name)
  return not nvim_names[name] and not IGNORE_STALE[name]
end)

if #missing == 0 and #stale == 0 then
  local total = #sorted_keys(nvim_names)
  print(
    string.format(
      "OK: %s covers all %d Neovim options (%s).",
      OPTIONS_FILE,
      total,
      vim.version() and tostring(vim.version()) or "?"
    )
  )
  os.exit(0)
end

if #missing > 0 then
  io.stderr:write(string.format("MISSING (%d) - present in Neovim, absent from %s:\n", #missing, OPTIONS_FILE))
  for _, name in ipairs(missing) do
    io.stderr:write(string.format("  + %s\n", name))
  end
end

if #stale > 0 then
  io.stderr:write(string.format("STALE (%d) - mentioned in %s, no longer a Neovim option:\n", #stale, OPTIONS_FILE))
  for _, name in ipairs(stale) do
    io.stderr:write(string.format("  - %s\n", name))
  end
end

io.stderr:write(
  "\nUpdate lua/config/options.lua: add MISSING options (set the default if one\n"
    .. "exists, else leave commented), and remove or annotate STALE ones. If a\n"
    .. "STALE name is intentionally kept as a historical note, add it to\n"
    .. "IGNORE_STALE in scripts/check-options-sync.lua.\n"
)
os.exit(1)
