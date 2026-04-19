-- global window options for edgebar windows
---@type vim.wo
local wo = {
  -- Setting to `true`, will add an edgy winbar.
  -- Setting to `false`, won't set any winbar.
  -- Setting to a string, will set the winbar to that string.
  winbar = true,
  winfixwidth = true,
  winfixheight = false,
  winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
  spell = false,
  signcolumn = "no",
}

return wo
