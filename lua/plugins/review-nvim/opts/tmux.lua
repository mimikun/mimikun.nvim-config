---@type ReviewTmuxConfig
local tmux = {
  -- Target window/pane (e.g., "!" for last active pane, or a window name)
  ---@type string
  target = "!",

  -- Whether to send Enter key after pasting
  ---@type boolean
  auto_enter = false,
}

return tmux
