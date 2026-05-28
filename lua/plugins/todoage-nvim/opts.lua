---@type table
local opts = {
  --`keywords` replaces the default list wholesale, not merges.
  --If you want the defaults plus extras, list them all.
  --Each keyword must contain only letters, digits, and underscores — `setup()` raises an error otherwise.
  keywords = {
    "TODO",
    "FIXME",
    "HACK",
    "XXX",
    "NOTE",
  },

  -- `format` receives the age in days and must return a string.
  -- It controls only the text; the highlight color is applied separately.
  -- Errors in your `format` function are not caught — fix the function if annotations stop appearing.
  format = function(age_days)
    return string.format("(%d days)", age_days)
  end,
}

return opts
