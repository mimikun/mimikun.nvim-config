local augend = require("dial.augend")

---Augends shared by every group.
---@type table
local common = {
  -- numbers
  augend.integer.alias.decimal_int,
  augend.integer.alias.hex,
  augend.integer.alias.binary,
  augend.integer.alias.octal,
  augend.decimal_fraction.new({
    signed = true,
  }),

  -- date and time
  augend.date.alias["%Y/%m/%d"],
  augend.date.alias["%Y-%m-%d"],
  augend.date.alias["%Y年%-m月%-d日"],
  augend.date.alias["%H:%M:%S"],
  augend.date.alias["%H:%M"],

  -- constants
  augend.constant.alias.bool,
  augend.constant.alias.Bool,
  augend.constant.new({
    elements = {
      "&&",
      "||",
    },
    word = false,
    cyclic = true,
  }),
  augend.constant.new({
    elements = {
      "and",
      "or",
    },
    word = true,
    cyclic = true,
  }),
  augend.constant.new({
    elements = {
      "yes",
      "no",
    },
    word = true,
    cyclic = true,
  }),

  -- misc
  augend.semver.alias.semver,
  augend.hexcolor.new({
    case = "lower",
  }),
  augend.misc.alias.markdown_header,
}

---@type table
local opts = {
  ---Used when no group name is given.
  default = common,

  ---Used in VISUAL mode: alphabet sequences are only useful on a selection.
  visual = vim.list_extend(vim.list_extend({}, common), {
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  }),
}

return opts
