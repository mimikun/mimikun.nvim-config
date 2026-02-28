---@type table
local base = {
  -- Smear cursor when switching buffers or windows.
  smear_between_buffers = true,

  -- Smear cursor when moving within line or to neighbor lines.
  -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
  smear_between_neighbor_lines = true,

  -- Only smear cursor when moving at least these distances
  min_horizontal_distance_smear = 0,
  min_vertical_distance_smear = 0,

  -- Toggles for directions
  smear_horizontally = true,
  smear_vertically = true,
  -- Neither horizontal nor vertical
  smear_diagonally = true,

  -- Smear cursor when entering or leaving command line mode
  smear_to_cmd = true,

  -- Draw the smear in buffer space instead of screen space when scrolling
  scroll_buffer_space = true,

  -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
  -- Smears and particles will look a lot less blocky.
  legacy_computing_symbols_support = false,
  legacy_computing_symbols_support_vertical_bars = false,
  -- Only effective if `legacy_computing_symbols_support` is `true`
  use_diagonal_blocks = true,

  -- Set to `true` if your cursor is a vertical bar in normal mode.
  vertical_bar_cursor = false,

  -- Smear cursor in insert mode.
  -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
  smear_insert_mode = true,
  -- Set to `true` if your cursor is a vertical bar in insert mode.
  vertical_bar_cursor_insert_mode = true,

  -- Smear cursor in replace mode.
  smear_replace_mode = false,

  -- Smear cursor in terminal mode.
  -- If the smear goes to the wrong location when enabled, try increasing `delay_after_key`.
  smear_terminal_mode = false,

  -- Set to `true` if your cursor is a horizontal bar in replace mode.
  horizontal_bar_cursor_replace_mode = true,

  -- Set to `true` to prevent the smear from overlapping the target character, hiding it until the animation is over.
  never_draw_over_target = false,

  -- Attempt to hide the real cursor by drawing a character below it.
  -- Can be useful when not using `termguicolors`
  -- Do not set to `true` if `never_draw_over_target` is `false`.
  hide_target_hack = false,

  -- Number of windows that stay open for rendering.
  max_kept_windows = 50,

  -- Adjust to have the smear appear above or below other floating windows
  windows_zindex = 300,

  -- List of filetypes where the plugin is disabled.
  filetypes_disabled = {},

  -- Sets animation framerate
  -- milliseconds
  time_interval = 17,

  -- Disable smear in the current buffer if the animation is stuck for at least this amount of time.
  -- Set to nil to disable this feature.
  -- milliseconds
  delay_disable = nil,

  -- Amount of time the cursor has to stay still before triggering animation.
  -- Useful if the target changes and rapidly comes back to its original position.
  -- E.g. when hitting a keybinding that triggers CmdlineEnter.
  -- Increase if the cursor makes weird jumps when hitting keys.
  -- milliseconds
  delay_event_to_smear = 1,

  -- Delay for `vim.on_key` to avoid redundancy with vim events triggers.
  -- milliseconds
  delay_after_key = 5,
}

return base
