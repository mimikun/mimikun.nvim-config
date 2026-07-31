-- Statusline configuration
---@type EcologStatuslineConfig
local statusline = {
  -- Hide when no env file active
  -- Hide when no env file selected (default: false)
  ---@type boolean
  hidden_mode = false,

  -- Icon configuration
  ---@type EcologStatuslineIconsConfig
  icons = {
    -- Enable icons (default: true)
    ---@type boolean
    enabled = true,

    -- Environment icon (default: "")
    ---@type string
    env = "",
  },

  -- Custom formatters
  ---@type EcologStatuslineFormatConfig
  format = {
    -- Format env file name
    ---@type fun(name: string): string
    env_file = function(name)
      return name
    end,

    -- Format variable count
    ---@type fun(count: number): string
    vars_count = function(count)
      return tostring(count)
      --return string.format("%d", count)
    end,
  },

  -- Highlight configuration
  ---@type EcologStatuslineHighlightsConfig
  highlights = {
    -- Enable highlights (default: true)
    ---@type boolean
    enabled = true,

    -- Highlight group or hex color (default: "EcologStatusFile")
    ---@type string
    env_file = "EcologStatusFile",

    -- Highlight group or hex color (default: "EcologStatusCount")
    ---@type string
    vars_count = "EcologStatusCount",

    -- Highlight group or hex color (default: "EcologStatusIcons")
    ---@type string
    icons = "EcologStatusIcons",

    -- Highlight group or hex for enabled sources (default: "EcologStatusSources")
    ---@type string
    sources = "EcologStatusSources",

    -- Highlight group for disabled sources (default: "EcologStatusSourcesDisabled")
    ---@type string
    sources_disabled = "EcologStatusSourcesDisabled",

    -- Highlight group for interpolation enabled (default: "EcologStatusInterpolation")
    ---@type string
    interpolation = "EcologStatusInterpolation",

    -- Highlight group for interpolation disabled (default: "EcologStatusInterpolationDisabled")
    ---@type string
    interpolation_disabled = "EcologStatusInterpolationDisabled",
  },

  -- Sources display configuration
  ---@type EcologStatuslineSourcesConfig
  sources = {
    -- Show sources section (default: true)
    ---@type boolean
    enabled = true,

    -- Show disabled sources dimmed (default: false)
    ---@type boolean
    show_disabled = false,

    -- "compact" (SF) or "badges" ([S] [F])
    -- Display format (default: "compact")
    ---@type string | "compact" | "badges"
    format = "compact",

    -- Custom icons/letters per source
    ---@type EcologStatuslineSourcesIconsConfig
    icons = {
      -- Icon/letter for Shell source (default: "S")
      ---@type string
      shell = "S",

      -- Icon/letter for File source (default: "F")
      ---@type string
      file = "F",

      -- Icon/letter for Remote source (default: "R")
      ---@type string
      remote = "R",
    },
  },

  -- Interpolation indicator configuration
  ---@type EcologStatuslineInterpolationConfig
  interpolation = {
    -- Show interpolation indicator (default: true)
    ---@type boolean
    enabled = true,

    -- Show indicator when interpolation is disabled (default: true)
    ---@type boolean
    show_disabled = true,

    -- Icon/letter for interpolation (default: "I")
    ---@type string
    icon = "I",
  },
}

return statusline
-- Statuslines
