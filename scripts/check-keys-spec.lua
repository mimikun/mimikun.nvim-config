-- check-keys-spec.lua - Lint lua/**/keys.lua for LazyKeysSpec violations.
--
-- Run via the wrapper (recommended, cds to repo root first):
--   scripts/check-keys-spec.sh
-- or directly:
--   nvim --headless -l scripts/check-keys-spec.lua
--
-- What it detects
--   A lazy.nvim `LazyKeysSpec` keymap entry is a table shaped like:
--     { <lhs>, <rhs?>, mode = ..., desc = ..., silent = ..., ... }
--   where lhs is entry[1], the optional rhs is entry[2] (string or function),
--   and every option (desc/silent/noremap/expr/...) is a *named* field at the
--   top level. A common mistake is to nest those options inside an extra table
--   literal appended to the entry:
--     { "<leader>cc", ":Convy<CR>", mode = { "n", "v" }, { desc = "x", silent = true } }
--                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--   lazy.nvim silently ignores that positional table, so the mapping loses its
--   description and `silent`. The correct form hoists the options to the top:
--     { "<leader>cc", ":Convy<CR>", mode = { "n", "v" }, desc = "x", silent = true }
--
--   Detection rule: any keymap entry that has a *positional* (integer-indexed)
--   element at index >= 2 whose value is a table. rhs at index 2 is only ever a
--   string or function, so a positional table is always the nested-opts bug and
--   never a false positive, regardless of formatting or comments.
--
-- Exit code: 0 when clean, 1 when any violation is found or a file fails to load.

local GLOB = "lua/**/keys.lua"

--- Scan a single keys.lua file for nested-opts violations.
---@param path string Path to a keys.lua file, relative to cwd.
---@return string[] violations Human-readable messages (empty when clean).
---@return string|nil load_error Set when the file could not be loaded.
local function scan(path)
  local ok, spec = pcall(dofile, path)
  if not ok then
    return {}, tostring(spec)
  end
  if type(spec) ~= "table" then
    return {}, "did not return a table"
  end

  local violations = {}
  for i, entry in ipairs(spec) do
    if type(entry) == "table" then
      for k, v in pairs(entry) do
        if type(k) == "number" and k >= 2 and type(v) == "table" then
          local lhs = tostring(entry[1])
          table.insert(violations, string.format("entry #%d (%s): nested opts table at positional index %d", i, lhs, k))
        end
      end
    end
  end
  return violations, nil
end

local files = vim.fn.glob(GLOB, false, true)
table.sort(files)

local total_violations = 0
local total_errors = 0

for _, path in ipairs(files) do
  local violations, load_error = scan(path)
  if load_error then
    total_errors = total_errors + 1
    io.stderr:write(string.format("ERROR  %s: %s\n", path, load_error))
  elseif #violations > 0 then
    total_violations = total_violations + #violations
    io.stderr:write(string.format("FAIL   %s\n", path))
    for _, msg in ipairs(violations) do
      io.stderr:write(string.format("         %s\n", msg))
    end
  end
end

if total_violations > 0 or total_errors > 0 then
  io.stderr:write(
    string.format(
      "\n%d violation(s) across %d file(s); %d load error(s).\n"
        .. "Fix: hoist desc/silent/noremap/... out of the nested { ... } table\n"
        .. "to the top level of the keymap entry (see LazyKeysSpec).\n",
      total_violations,
      #files,
      total_errors
    )
  )
  os.exit(1)
end

print(string.format("OK: %d keys.lua file(s) conform to LazyKeysSpec.", #files))
os.exit(0)
