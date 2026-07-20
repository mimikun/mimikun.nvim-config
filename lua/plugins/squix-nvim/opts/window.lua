local window = {
  ---@type string | "botright" | "topleft" | "vertical" | "float"
  position = "botright",

  -- fraction of the editor for split positions
  split_ratio = 0.4,

  -- focus (and enter) the TUI window when it opens
  -- false opens it in the background
  auto_focus = true,

  -- only when position = "float"
  float = {
    width = "80%",
    height = "80%",
    row = "center",
    col = "center",
    relative = "editor",
    border = "rounded",
  },
}

return window
