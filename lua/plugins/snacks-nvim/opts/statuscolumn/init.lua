---@type snacks.statuscolumn.Config
local statuscolumn = {
  enabled = true,
  ---@type snacks.statuscolumn.Components
  left = {
    -- priority of signs on the left (high to low)
    "mark",
    "sign",
  },
  ---@type snacks.statuscolumn.Components
  right = {
    -- priority of signs on the right (high to low)
    "fold",
    "git",
  },
  folds = {
    -- show open fold icons
    open = false,
    -- use Git Signs hl for fold icons
    git_hl = false,
  },
  git = {
    -- patterns to match Git signs
    patterns = {
      "GitSign",
      "MiniDiffSign",
    },
  },
  -- refresh at most every 50ms
  refresh = 50,
}

return statuscolumn
