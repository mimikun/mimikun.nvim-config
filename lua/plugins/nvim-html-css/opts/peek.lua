---@type Peek
local peek = {
  ---@type boolean
  enabled = true,

  ---@type string | "rounded" | "single" | "double" | "shadow" | "none"
  border = "rounded",

  ---@type string | "cursor" | "center"
  position = "center",

  -- fraction of editor width (0.0–1.0)
  ---@type number
  width = 0.5,

  -- fraction of editor height (0.0–1.0)
  ---@type number
  height = 0.5,

  -- whether the float steals focus on open
  ---@type boolean
  focus = true,

  ---@type string
  style = "minimal",
}

return peek
