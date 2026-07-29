---@type table
local opts = {
  -- Function producing jump spots (byte indexed) for a particular line.
  -- For more information see |MiniJump2d.start|.
  -- If `nil` (default) - use |MiniJump2d.default_spotter|
  spotter = nil,

  -- Characters used for labels of jump spots (in supplied order)
  labels = "abcdefghijklmnopqrstuvwxyz",

  -- Options for visual effects
  view = {
    -- Whether to dim lines with at least one jump spot
    dim = false,

    -- How many steps ahead to show.
    -- Set to big number to show all steps.
    n_steps_ahead = 0,
  },

  -- Which lines are used for computing spots
  allowed_lines = {
    -- Blank line (not sent to spotter even if `true`)
    blank = true,

    -- Lines before cursor line
    cursor_before = true,

    -- Cursor line
    cursor_at = true,

    -- Lines after cursor line
    cursor_after = true,

    -- Start of fold (not sent to spotter even if `true`)
    fold = true,
  },

  -- Which windows from current tabpage are used for visible lines
  allowed_windows = {
    current = true,
    not_current = true,
  },

  -- Functions to be executed at certain events
  hooks = {
    -- Before jump start
    before_start = nil,

    -- After jump was actually done
    after_jump = nil,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  -- Disabled: the jump is bound in keys.lua instead. Keeping the default
  -- <CR> here would shadow the built-in tag jump in help and man buffers,
  -- which the plugin does not correct for (it only reverts <CR> for qf
  -- buffers and the command-line window).
  mappings = {
    start_jumping = "",
  },

  -- Whether to disable showing non-error feedback
  -- This also affects (purely informational) helper messages shown after idle time if user input is required.
  silent = false,
}

return opts
