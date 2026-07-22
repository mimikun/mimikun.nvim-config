---@type table
local opts = {
  -- Enable/disable the plugin
  enabled = true,

  -- Disable warnings for debugging highlight issues
  disable_warnings = true,

  -- Automatically reload highlights when colorscheme changes
  -- When enabled, cached highlights will be refreshed on ColorScheme autocmd
  autoreload = false,

  -- Animation refresh rate in milliseconds
  refresh_interval_ms = 8,

  -- Timeout in milliseconds to wait after the last edit before processing animations
  -- This uses a debouncing approach: the timer restarts on each edit, and only fires when edits stop for this duration.
  -- This properly handles multi-location atomic edits from surround plugins and similar tools (default: 50)
  text_change_batch_timeout_ms = 50,

  -- Automatic keybinding overwrites
  overwrite = {
    -- Automatically map keys to overwrite operations
    -- Set to false if you have custom mappings or prefer manual API calls
    auto_map = true,

    -- Yank operation animation
    yank = {
      enabled = true,
      default_animation = "fade",
    },

    -- Search navigation animation
    search = {
      enabled = false,
      default_animation = "pulse",
      -- Key for next match
      next_mapping = "n",

      -- Key for previous match
      prev_mapping = "N",
    },

    -- Paste operation animation
    paste = {
      enabled = true,
      default_animation = "reverse_fade",
      -- Paste after cursor
      paste_mapping = "p",

      -- Paste before cursor
      Paste_mapping = "P",
    },

    -- Undo operation animation
    undo = {
      enabled = false,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "DiffDelete",
          max_duration = 500,
          min_duration = 500,
        },
      },
      undo_mapping = "u",
    },

    -- Redo operation animation
    redo = {
      enabled = false,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "DiffAdd",
          max_duration = 500,
          min_duration = 500,
        },
      },
      redo_mapping = "<c-r>",
    },
  },

  -- Third-party plugin integrations
  support = {
    substitute = {
      enabled = true,
      default_animation = "fade",
    },
  },

  -- Override background color for animations (for transparent backgrounds)
  transparency_color = nil,

  -- Filetypes to disable hijacking/overwrites
  hijack_ft_disabled = {
    "alpha",
    "snacks_dashboard",
    "dashboard",
    "neo-tree",
  },

  -- Virtual text display priority
  virt_text = {
    -- Higher values appear above other plugins
    priority = 2048,
  },
}

return opts
