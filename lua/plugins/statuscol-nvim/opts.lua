local builtin = require("statuscol.builtin")

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
  segments = {
    {
      -- table of strings or functions returning a string
      text = {
        "%C",
      },
      -- %@ click function label, applies to each text element
      click = "v:lua.ScFa",
      -- %# highlight group label, applies to each text element
      hl = "FoldColumn",
      -- table of booleans or functions returning a boolean
      condition = {
        true,
      },
      -- table of fields that configure a sign segment
      sign = {
        -- at least one of "name", "text", and "namespace" is required
        -- legacy signs are matched against the defined sign name e.g. "DapBreakpoint"
        -- extmark signs can be matched against either the namespace or the sign text itself
        -- table of Lua patterns to match the legacy sign name against
        name = {
          ".*",
        },
        -- table of Lua patterns to match the extmark sign text against
        text = {
          ".*",
        },
        -- table of Lua patterns to match the extmark sign namespace against
        namespace = {
          ".*",
        },
        -- below values list the default when omitted:
        -- maximum number of signs that will be displayed in this segment
        maxwidth = 1,
        -- number of display cells per sign in this segment
        colwidth = 2,
        -- boolean or string indicating what will be drawn when no signs
        auto = false,
        -- matching the pattern are currently placed in the buffer.
        -- when true, signs in this segment will also be drawn on the
        wrap = false,
        -- virtual or wrapped part of a line (when v:virtnum != 0).
        -- character used to fill a segment with less signs than maxwidth
        fillchar = " ",
        -- highlight group used for fillchar (SignColumn/CursorLineSign if omitted)
        fillcharhl = nil,
        -- when true, show signs from lines in a closed fold on the first line
        foldclosed = false,
      },
    },
    {
      --text = {
      --  "%s",
      --},
      sign = {
        namespace = {
          "diagnostic/signs",
        },
        maxwidth = 2,
        auto = true,
      },
      click = "v:lua.ScSa",
    },
    {
      text = {
        builtin.lnumfunc,
        --" ",
      },
      --condition = {
      --  true,
      --  builtin.not_empty,
      --},
      click = "v:lua.ScLa",
    },
    {
      sign = {
        name = {
          ".*",
        },
        maxwidth = 2,
        colwidth = 1,
        auto = true,
        wrap = true,
      },
      click = "v:lua.ScSa",
    },
  },
  -- modifier used for certain actions in the builtin clickhandlers: "a" for Alt, "c" for Ctrl and "m" for Meta.
  clickmod = "c",

  -- builtin click handlers, keys are pattern matched
  clickhandlers = {
    Lnum = builtin.lnum_click,
    FoldClose = builtin.foldclose_click,
    FoldOpen = builtin.foldopen_click,
    FoldOther = builtin.foldother_click,
    DapBreakpointRejected = builtin.toggle_breakpoint,
    DapBreakpoint = builtin.toggle_breakpoint,
    DapBreakpointCondition = builtin.toggle_breakpoint,
    ["diagnostic/signs"] = builtin.diagnostic_click,
    gitsigns = builtin.gitsigns_click,
  },
}

return opts
