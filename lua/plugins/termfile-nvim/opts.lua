---@type table
local opts = {
  -- Shell to launch inside a `.term` terminal.
  -- `nil` uses Neovim's 'shell'.
  -- May be a string ("/bin/bash") or a list ({ "/bin/bash", "--login" }).
  ---@type string | string[] | nil
  shell = nil,

  -- When reopening a `.term` file, replay the recorded raw output so the session's history (with its original colors) is rendered again.
  ---@type boolean
  restore = true,

  -- Text inserted between restored output and the new shell prompt.
  -- Set to an empty string to preserve the old directly-appended behaviour.
  ---@type string
  delimiter = "\n",

  -- Maximum number of bytes of recorded output kept in a `.term` file.
  -- Older output beyond this is trimmed from the front.
  ---@type number
  max_bytes = 256 * 1024,

  -- Enter terminal-mode (insert) automatically when a `.term` buffer becomes the current window.
  -- Off by default so file-picker previews stay calm.
  ---@type boolean
  start_insert = false,

  -- Window-local options restored when a window stops showing a `.term` buffer.
  -- "global" resets the options termfile changes to Neovim's global fallback values (`:setlocal option<`).
  -- A table applies explicit values.
  ---@type string | table | "global"
  default_win_opts = "global",

  -- Persist terminal output to disk on unload / write / Neovim exit.
  ---@type boolean
  auto_save = true,

  -- Filename glob that identifies terminal-session files.
  ---@type string
  pattern = "*.term",
}

return opts
