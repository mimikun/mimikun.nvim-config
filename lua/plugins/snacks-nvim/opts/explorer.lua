-- Disabled: another plugin in this config already owns the feature.
-- oil-nvim / fyler-nvim / triptych-nvim / otree-nvim
---@type snacks.explorer.Config
local explorer = {
  enabled = false,

  -- Replace netrw with the snacks explorer
  replace_netrw = true,

  -- Use the system trash when deleting files
  trash = true,
}

return explorer
