---@type string | string[] | nil
local highlight = require("plugins.indent-blankline-nvim.opts.highlight").whitespace

---@type ibl.config.whitespace
local whitespace = {
  -- Highlight group, or list of highlight groups, that get applied to the whitespace
  ---@type string | string[] | nil
  highlight = highlight,

  -- Removes trailing whitespace on blanklines
  -- Turn this off if you want to add background color to the whitespace highlight group
  ---@type boolean
  remove_blankline_trail = true,
}

return whitespace
