local M = {}

--- Default configuration.
--- All options are optional; the plugin works with zero configuration.
M.defaults = {
  -- Shell to launch inside a `.term` terminal. `nil` uses Neovim's 'shell'.
  -- May be a string ("/bin/bash") or a list ({ "/bin/bash", "--login" }).
  shell = nil,

  -- When reopening a `.term` file, replay the recorded raw output so the
  -- session's history (with its original colors) is rendered again.
  restore = true,

  -- Text inserted between restored output and the new shell prompt. Set to an
  -- empty string to preserve the old directly-appended behaviour.
  delimiter = "\n",

  -- Maximum number of bytes of recorded output kept in a `.term` file. Older
  -- output beyond this is trimmed from the front.
  max_bytes = 256 * 1024,

  -- Enter terminal-mode (insert) automatically when a `.term` buffer becomes
  -- the current window. Off by default so file-picker previews stay calm.
  start_insert = false,

  -- Window-local options restored when a window stops showing a `.term`
  -- buffer. "global" resets the options termfile changes to Neovim's global
  -- fallback values (`:setlocal option<`). A table applies explicit values.
  default_win_opts = "global",

  -- Persist terminal output to disk on unload / write / Neovim exit.
  auto_save = true,

  -- Filename glob that identifies terminal-session files.
  pattern = "*.term",
}

--- Merge user options over the defaults.
---@param opts table|nil
---@return table
function M.extend(opts)
  return vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
end

return M
