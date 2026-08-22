-- Configuration options for vimdoc
---@type helpview.vimdoc
local vimdoc = {
  -- When `false`, doesn't render vimdoc.
  ---@type boolean
  --enable = true,

  -- Configuration for {arguments}.
  ---@type vimdoc.arguments
  arguments = require("plugins.helpview-nvim.opts.vimdoc.arguments"),

  -- Configuration for code blocks.
  ---@type vimdoc.code_blocks
  code_blocks = require("plugins.helpview-nvim.opts.vimdoc.code_blocks"),

  -- Configuration for headings.
  ---@type vimdoc.headings
  headings = require("plugins.helpview-nvim.opts.vimdoc.headings"),

  -- Configuration for highlight group names.
  ---@type vimdoc.highlights
  highlight_groups = require("plugins.helpview-nvim.opts.vimdoc.highlight_groups"),

  -- Configuration for horizontal rules.
  ---@type vimdoc.hr
  horizontal_rules = require("plugins.helpview-nvim.opts.vimdoc.horizontal_rules"),

  -- Configuration for
  ---@type vimdoc.inline_codes
  inline_codes = require("plugins.helpview-nvim.opts.vimdoc.inline_codes"),

  -- Configuration for <Keycodes>.
  ---@type vimdoc.keycodes
  keycodes = require("plugins.helpview-nvim.opts.vimdoc.keycodes"),

  -- Configuration for vim:modeline:.
  ---@type vimdoc.modelines
  modelines = require("plugins.helpview-nvim.opts.vimdoc.modelines"),

  -- Configuration for Note.
  ---@type vimdoc.notes
  notes = require("plugins.helpview-nvim.opts.vimdoc.notes"),

  -- Configuration for 'optionlink'.
  ---@type vimdoc.optionlinks
  optionlinks = require("plugins.helpview-nvim.opts.vimdoc.optionlinks"),

  -- Configuration for *tag*.
  ---@type vimdoc.tags
  tags = require("plugins.helpview-nvim.opts.vimdoc.tags"),

  -- Configuration for |taglink|.
  ---@type vimdoc.taglinks
  taglinks = require("plugins.helpview-nvim.opts.vimdoc.taglinks"),

  urls = require("plugins.helpview-nvim.opts.vimdoc.urls"),
}

return vimdoc
