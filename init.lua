if vim.loader then
  vim.loader.enable()
end

vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.fileformats = {
  "unix",
  "dos",
  "mac",
}

vim.opt.fileencodings = {
  "utf-8",
  "cp932",
  "ucs-bombs",
  "euc-jp",
  "ucs-bom",
  "default",
  "latin1",
}

vim.opt.number = true
vim.opt.relativenumber = true
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

local wl_clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline",
  },
  cache_enabled = 0,
}

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
  vim.g.clipboard = wl_clipboard
else
  vim.g.clipboard = nil
end
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

require("config.lazy")

vim.cmd.colorscheme("tokyonight")

vim.keymap.set("n", "<Esc><Esc>", function()
  vim.cmd("nohlsearch")
end, { silent = true })

-- https://github.com/iterative/dvc
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Dvcfile", "*.dvc", "dvc.lock" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})
