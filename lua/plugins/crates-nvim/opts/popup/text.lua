---@type crates.UserPopupTextConfig
local text

---@type crates.UserPopupTextConfig
local _plain = {
  ---@type string
  title = "# %s",

  ---@type string
  pill_left = "",

  ---@type string
  pill_right = "",

  ---@type string
  created_label = "created        ",

  ---@type string
  updated_label = "updated        ",

  ---@type string
  downloads_label = "downloads      ",

  ---@type string
  homepage_label = "homepage       ",

  ---@type string
  repository_label = "repository     ",

  ---@type string
  documentation_label = "documentation  ",

  ---@type string
  crates_io_label = "crates.io      ",

  ---@type string
  lib_rs_label = "lib.rs         ",

  ---@type string
  categories_label = "categories     ",

  ---@type string
  keywords_label = "keywords       ",

  ---@type string
  version = "%s",

  ---@type string
  prerelease = "%s pre-release",

  ---@type string
  yanked = "%s yanked",

  ---@type string
  enabled = "* s",

  ---@type string
  transitive = "~ s",

  ---@type string
  normal_dependencies_title = "  Dependencies",

  ---@type string
  build_dependencies_title = "  Build dependencies",

  ---@type string
  dev_dependencies_title = "  Dev dependencies",

  ---@type string
  optional = "? %s",

  ---@type string
  loading = " ...",
}

---@type crates.UserPopupTextConfig
local rich = {
  ---@type string
  title = " %s",

  ---@type string
  pill_left = "",

  ---@type string
  pill_right = "",

  ---@type string
  description = "%s",

  ---@type string
  created_label = " created        ",

  ---@type string
  created = "%s",

  ---@type string
  updated_label = " updated        ",

  ---@type string
  updated = "%s",

  ---@type string
  downloads_label = " downloads      ",

  ---@type string
  downloads = "%s",

  ---@type string
  homepage_label = " homepage       ",

  ---@type string
  homepage = "%s",

  ---@type string
  repository_label = " repository     ",

  ---@type string
  repository = "%s",

  ---@type string
  documentation_label = " documentation  ",

  ---@type string
  documentation = "%s",

  ---@type string
  crates_io_label = " crates.io      ",

  ---@type string
  crates_io = "%s",

  ---@type string
  lib_rs_label = " lib.rs         ",

  ---@type string
  lib_rs = "%s",

  ---@type string
  categories_label = " categories     ",

  ---@type string
  keywords_label = " keywords       ",

  ---@type string
  version = "  %s",

  ---@type string
  prerelease = " %s",

  ---@type string
  yanked = " %s",

  ---@type string
  version_date = "  %s",

  ---@type string
  feature = "  %s",

  ---@type string
  enabled = " %s",

  ---@type string
  transitive = " %s",

  ---@type string
  normal_dependencies_title = " Dependencies",

  ---@type string
  build_dependencies_title = " Build dependencies",

  ---@type string
  dev_dependencies_title = " Dev dependencies",

  ---@type string
  dependency = "  %s",

  ---@type string
  optional = " %s",

  ---@type string
  dependency_version = "  %s",

  ---@type string
  loading = "  ",
}

text = rich

return text
