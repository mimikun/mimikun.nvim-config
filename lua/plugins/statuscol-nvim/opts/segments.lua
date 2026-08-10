local _builtin = require("statuscol.builtin")
local oil_cols = require("statuscol-oil")
local lj = require("line-justice")

-- Default segments (fold -> sign -> line number + separator), explained below
---@type table
local segments = {
  -- NOTE: segments_1
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

  -- NOTE: segments_2
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

  -- NOTE: segments_3
  {
    text = {
      --builtin.lnumfunc,
      --" ",
      lj.segment,
    },

    --condition = {
    --  true,
    --  builtin.not_empty,
    --},

    click = "v:lua.ScLa",
  },

  -- NOTE: segments_4
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

  -- permission: permission
  -- size: file size
  -- mtime: last updated time
  -- owner: owner of file/folder
  -- group: The group to which the file belongs
  -- whitespace: single whitespace

  -- NOTE: segments: oils
  oil_cols.permission,
  oil_cols.whitespace,

  oil_cols.owner,
  oil_cols.whitespace,

  oil_cols.size,
  oil_cols.whitespace,

  --oil_cols.icon,
}

return segments
