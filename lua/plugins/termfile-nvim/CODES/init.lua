-- termfile.nvim
--
-- `*.term` files are terminal sessions. Opening one launches a terminal instead
-- of showing the file's contents; the file itself holds the raw output stream so
-- the session's history can be replayed (with color) after Neovim is relaunched.
-- No commands, no manual invocation -- everything is driven by autocommands.

local config_mod = require("termfile.config")
local terminal = require("termfile.terminal")

local M = {}

M.config = vim.deepcopy(config_mod.defaults)

local augroup_name = "termfile"
local initialised = false
local termfile_windows = {}
local terminal_win_opts = { number = false, relativenumber = false }

local function set_window_options(win, options)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  for name, value in pairs(options) do
    vim.api.nvim_set_option_value(name, value, { scope = "local", win = win })
  end
end

local function hide_line_numbers(win)
  set_window_options(win, terminal_win_opts)
end

local function restore_window_options(win)
  if M.config.default_win_opts ~= "global" then
    set_window_options(win, M.config.default_win_opts)
    return
  end
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  vim.api.nvim_win_call(win, function()
    for name in pairs(terminal_win_opts) do
      -- Window-local options have a global fallback used for normal buffers.
      -- `<` copies that configured fallback into the local value.
      vim.cmd("setlocal " .. name .. "<")
    end
  end)
end

--- Register the autocommands that drive the whole plugin. Idempotent.
local function install_autocmds()
  local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
  local pattern = M.config.pattern

  -- Existing file (`BufReadCmd` -- we take over reading entirely so the raw
  -- recording is never shown as text) and brand new file (`BufNewFile`).
  vim.api.nvim_create_autocmd({ "BufReadCmd", "BufNewFile" }, {
    group = group,
    pattern = pattern,
    nested = true,
    desc = "Open .term files as terminals",
    callback = function(ev)
      local path = vim.fn.fnamemodify(ev.match, ":p")
      terminal.open(ev.buf, path, M.config)
      if terminal.is_managed(ev.buf) then
        -- Snacks normally excludes 'buftype=terminal' buffers when selecting a
        -- main window for files. This explicit marker keeps the current
        -- termfile window eligible, so a selected file can replace it.
        vim.b[ev.buf].snacks_main = true
        for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
          termfile_windows[win] = true
          hide_line_numbers(win)
        end
      end
    end,
  })

  -- Track windows that show a `.term` buffer. When another buffer replaces the
  -- terminal, apply explicit normal-window defaults instead of restoring a
  -- snapshot. BufWinEnter (rather than BufLeave) avoids changing the terminal
  -- window merely because focus moved to a different split.
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    desc = "Scope .term window settings to their windows",
    callback = function(ev)
      local managed = terminal.is_managed(ev.buf)
      for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
        if managed then
          termfile_windows[win] = true
          hide_line_numbers(win)
        elseif termfile_windows[win] then
          termfile_windows[win] = nil
          restore_window_options(win)
        end
      end
    end,
  })

  -- Reassert terminal options when returning to an existing `.term` window.
  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    pattern = pattern,
    desc = "Keep line numbers off in .term windows",
    callback = function(ev)
      if terminal.is_managed(ev.buf) then
        local win = vim.api.nvim_get_current_win()
        termfile_windows[win] = true
        hide_line_numbers(win)
      end
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    desc = "Forget closed .term windows",
    callback = function(ev)
      termfile_windows[tonumber(ev.match)] = nil
    end,
  })

  if not M.config.auto_save then
    return
  end

  -- Persist on explicit write (`:w`).
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    group = group,
    pattern = pattern,
    desc = "Persist .term session on write",
    callback = function(ev)
      if terminal.is_managed(ev.buf) then
        terminal.save(ev.buf)
        pcall(function()
          vim.bo[ev.buf].modified = false
        end)
      end
    end,
  })

  -- Persist and tear down when the buffer goes away (`:bd`, window close).
  vim.api.nvim_create_autocmd("BufUnload", {
    group = group,
    pattern = pattern,
    desc = "Persist and clean up .term session on unload",
    callback = function(ev)
      if terminal.is_managed(ev.buf) then
        terminal.cleanup(ev.buf)
      end
    end,
  })

  -- Persist every open session right before Neovim quits.
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    desc = "Persist all .term sessions on exit",
    callback = function()
      for _, b in ipairs(terminal.managed_buffers()) do
        terminal.save(b)
      end
    end,
  })
end

--- Set up the plugin. Calling this is optional -- the plugin auto-initialises
--- with defaults on load. Call it only to override configuration.
---@param opts table|nil
function M.setup(opts)
  M.config = config_mod.extend(opts)
  install_autocmds()
  initialised = true
end

--- Auto-initialise with defaults (used by plugin/termfile.lua). Does nothing if
--- the user has already called setup() to avoid clobbering their config.
function M.init()
  if initialised then
    return
  end
  install_autocmds()
  initialised = true
end

return M
