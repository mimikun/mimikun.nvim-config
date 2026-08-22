-- General setup options
---@type nvim-ts-autotag.Opts
local options = {
  -- Whether or not to auto rename paired tags
  ---@type boolean
  enable_rename = true,

  -- Whether or not to auto close tags
  ---@type boolean
  enable_close = true,

  -- Whether or not to auto close tags when a `/` is inserted
  ---@type boolean
  enable_close_on_slash = false,
}

return options
