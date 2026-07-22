-- severity: "error" | "warn" | "hint"
-- sources: list of findings keys to merge into this display category
---@type table
local categories = {
  -- UNUSED CODE (dead code — hint severity)
  unused_exports = {
    icon = "󰘍",
    label = "Unused Exports",
    section = "unused_code",
    order = 1,
    severity = "hint",
  },
  unused_files = {
    icon = "󰈔",
    label = "Unused Files",
    section = "unused_code",
    order = 2,
    severity = "hint",
  },
  unused_types = {
    icon = "T",
    label = "Unused Types",
    section = "unused_code",
    order = 3,
    severity = "hint",
  },
  unused_members = {
    icon = "•",
    label = "Unused Members",
    section = "unused_code",
    order = 4,
    severity = "hint",
    sources = {
      "unused_enum_members",
      "unused_class_members",
    },
  },
  unused_all_deps = {
    icon = "󰒓",
    label = "Dependencies",
    section = "unused_code",
    order = 5,
    severity = "hint",
    sources = {
      "unused_deps",
      "unused_dev_deps",
      "unused_optional_deps",
    },
  },
  unlisted_deps = {
    icon = "󰌶",
    label = "Unlisted Deps",
    section = "unused_code",
    order = 6,
    severity = "warn",
  },

  -- ISSUES (actual bugs — error/warn severity)
  unresolved_imports = {
    icon = "󰌶",
    label = "Unresolved Imports",
    section = "issues",
    order = 1,
    severity = "error",
  },
  circular_deps = {
    icon = "󰑷",
    label = "Circular Deps",
    section = "issues",
    order = 2,
    severity = "warn",
  },
  duplicate_exports = {
    icon = "󰏗",
    label = "Duplicate Exports",
    section = "issues",
    order = 3,
    severity = "warn",
  },

  -- DUPLICATES
  clone_groups = {
    icon = "󰏗",
    label = "Clone Groups",
    section = "duplicates",
    order = 1,
    severity = "hint",
  },

  -- HEALTH
  health_complexity = {
    icon = "ƒ",
    label = "Complexity",
    section = "health",
    order = 1,
    severity = "warn",
  },
  health_hotspots = {
    icon = "󱐋",
    label = "Hotspot Candidates",
    section = "health",
    order = 2,
    severity = "hint",
  },
  health_targets = {
    icon = "↑",
    label = "Refactoring",
    section = "health",
    order = 3,
    severity = "hint",
  },

  -- ARCHITECTURE
  boundary_violations = {
    icon = "󰑷",
    label = "Boundary Violations",
    section = "architecture",
    order = 1,
    severity = "error",
  },
}

return categories
