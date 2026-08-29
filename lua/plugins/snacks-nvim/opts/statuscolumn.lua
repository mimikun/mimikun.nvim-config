-- Disabled: another plugin in this config already owns the feature.
-- statuscol-nvim
---@type snacks.statuscolumn.Config
local statuscolumn = {
  ---@type boolean
  enabled = false,

  -- priority of signs on the left (high to low)
  ---@type snacks.statuscolumn.Components
  left = {
    "mark",
    "sign",
  },

  -- priority of signs on the right (high to low)
  ---@type snacks.statuscolumn.Components
  right = {
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
