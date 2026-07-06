---@type table
local opts = {
  -- Whether to set the 'statuscolumn' option, may be set to false for those who want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
  -- Although I recommend just using the segments field below to build your statuscolumn to benefit from the performance optimizations in this plugin.
  setopt = true,

  -- builtin.lnumfunc number string options
  -- or line number thousands separator string ("." / ",")
  thousands = false,

  -- whether to right-align the cursor line number with 'relativenumber' set
  relculright = true,

  -- Builtin 'statuscolumn' options
  -- Lua table with 'filetype' values for which 'statuscolumn' will be unset
  ft_ignore = nil,

  -- Lua table with 'buftype' values for which 'statuscolumn' will be unset
  bt_ignore = nil,

  -- Default segments (fold -> sign -> line number + separator), explained below
  segments = require("plugins.statuscol-nvim.opts.segments"),

  -- modifier used for certain actions in the builtin clickhandlers: "a" for Alt, "c" for Ctrl and "m" for Meta.
  clickmod = "c",

  -- builtin click handlers, keys are pattern matched
  clickhandlers = require("plugins.statuscol-nvim.opts.clickhandlers"),
}

return opts
