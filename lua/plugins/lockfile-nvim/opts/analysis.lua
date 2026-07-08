---@type lockfile.AnalysisConfig
local analysis = {
  -- flag major version bumps
  ---@type boolean
  flag_major = true,

  -- flag version downgrades
  ---@type boolean
  flag_downgrade = true,

  -- flag a package's source url changing
  ---@type boolean
  flag_source_change = true,

  -- flag same-version checksum changes
  ---@type boolean
  flag_checksum_change = true,

  -- flag added packages from git/url/path
  ---@type boolean
  flag_new_git_source = true,

  -- added deps from one change to flag as "big"
  ---@type integer
  big_transitive_threshold = 10,
}

return analysis
