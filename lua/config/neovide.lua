-- Neovide GUI settings.
--
-- Only loaded inside the Neovide client (`vim.g.neovide` is set by Neovide
-- itself). Every value here is a sensible, stability-leaning baseline meant to
-- be tuned to taste; each block cites the relevant section of the bundled
-- reference docs under `neovide-docs/`.
--
-- Font and line spacing are intentionally NOT set here: they are plain Neovim
-- options (`guifont`, `linespace`) already owned by config.options, and Neovide
-- reads them directly. Keep GUI-only `vim.g.neovide_*` knobs in this file.

if not vim.g.neovide then
  return
end

local host = require("config.host")

-- Display / scaling (neovide-docs/01_Display.md) --------------------------

-- Scale the whole UI without redefining `guifont`. 1.0 = font's native size.
vim.g.neovide_scale_factor = 1.0

-- Background-colored gutter between the window border and the grid.
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_padding_right = 0

-- Blur radius applied to floating windows on each axis.
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- Drop shadow behind floating windows for depth separation.
vim.g.neovide_floating_shadow = true

-- Follow the system light/dark theme where the platform supports it.
vim.g.neovide_theme = "auto"

-- Window transparency is disabled by default. Uncomment to enable; keep
-- `neovide_normal_opacity` at 1.0 to keep buffer text fully opaque.
-- vim.g.neovide_opacity = 0.9
-- vim.g.neovide_normal_opacity = 1.0

-- Functionality (neovide-docs/02_Functionality.md) ------------------------

-- Frame rate while focused / idle. Idle rate saves battery when unfocused;
-- both only take effect when vsync is off (`--no-vsync`).
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5

-- Ask for confirmation when quitting with unsaved changes (Neovide default).
vim.g.neovide_confirm_quit = true

-- Restore the previous session's window size on startup.
vim.g.neovide_remember_window_size = true

-- Keep the cursor from flickering to the command line spuriously. Disable if
-- the hack itself misbehaves and cursor animations are off.
vim.g.neovide_cursor_hack = true

-- Input (neovide-docs/03_Input-Settings.md) -------------------------------

-- Enable IME so East Asian input works in the GUI.
vim.g.neovide_input_ime = true

-- On macOS, treat the left Option key as Meta so `<M-...>` mappings fire
-- instead of inserting special characters.
if host.is_mac() then
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
end

-- Cursor (neovide-docs/04_Cursor-Settings.md) -----------------------------

-- Cursor travel animation duration; the short variant covers 1-2 char typing
-- moves. Set either to 0 to disable that animation.
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_short_animation_length = 0.04

-- How much the tail lags the head (0.0 smoothest/laggier .. 1.0 instant).
vim.g.neovide_cursor_trail_size = 0.8

-- Antialias the cursor quad; disable to work around cursor rendering glitches.
vim.g.neovide_cursor_antialiasing = true
