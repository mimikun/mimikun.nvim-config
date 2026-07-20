vim.g.mapleader = " "

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- clipboard integration
-- Clipboard provider definitions live in config.clipboard as a single source of
-- truth; reference them here instead of redefining tables inline.
local cb = require("config.clipboard")

-- Select the clipboard provider from the actual display environment instead of
-- the hostname, so every machine (pure X11, pure Wayland, WSLg, macOS, Windows)
-- behaves correctly without a per-host allowlist.
--
-- Force the wl-clipboard provider only when a Wayland display is actually
-- reachable AND wl-copy is installed. This is the WSLg case, where both DISPLAY
-- and WAYLAND_DISPLAY are set and letting Neovim auto-detect would pick xsel and
-- error on startup. Everywhere else leave it nil so Neovim auto-detects the
-- native provider (xsel/xclip, pbcopy, win32yank, ...); this avoids blocking on
-- wl-copy's background daemon, which is what freezes startup when the Wayland
-- tools are pointed at a machine that has no Wayland server.
local wayland_display = vim.env.WAYLAND_DISPLAY
if wayland_display and wayland_display ~= "" and vim.fn.executable("wl-copy") == 1 then
  vim.g.clipboard = cb.wl_clipboard
else
  vim.g.clipboard = nil
end
