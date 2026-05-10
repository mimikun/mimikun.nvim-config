---@type string | string[] | nil
local highlight = require("plugins.indent-blankline-nvim.opts.highlight").rd

---@type ibl.config.scope
local scope = {
  -- Enables or disables scope
  ---@type boolean
  enabled = true,

  -- Character, or list of characters, that get used to display the scope indentation guide
  -- Each character has to have a display width of 0 or 1
  ---@type string | string[] | nil
  char = nil,

  -- Shows an underline on the first line of the scope
  ---@type boolean
  show_start = true,

  -- Shows an underline on the last line of the scope
  ---@type boolean
  show_end = true,

  -- Always shows an underline on the last line of the scope (default is to ignore some cases) and starts the scope underline at the actual beginning of the scope (even if it is to the right of the indent level)
  ---@type boolean
  show_exact_scope = false,

  -- Checks for the current scope in injected treesitter languages This also influences if the scope gets excluded or not
  ---@type boolean
  injected_languages = true,

  -- Highlight group, or list of highlight groups, that get applied to the scope
  ---@type string | string[] | nil
  highlight = highlight,

  -- Virtual text priority for the scope
  ---@type number
  priority = 1024,

  -- Configures additional nodes to be used as scope
  ---@type ibl.config.scope.include?
  include = {
    -- map of language to a list of node types which can be used as scope
    -- Use `*` as a wildcard for all languages
    ---@type table<string, string[]>
    node_type = {},
  },

  -- Configures nodes or languages to be excluded from scope
  ---@type ibl.config.scope.exclude
  exclude = {
    --- List of treesitter languages for which scope is disabled
    ---@type string[]
    language = {},

    --- map of language to a list of node types which should not be used as scope
    --- Use `*` as a wildcard for all languages
    ---@type table<string, string[]>
    node_type = {
      ["*"] = {
        "source_file",
        "program",
      },
      lua = {
        "chunk",
      },
      python = {
        "module",
      },
    },
  },
}

return scope
