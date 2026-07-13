---@module "render-markdown"
---@type render.md.UserConfig
local opts = {
  -- Whether markdown should be rendered by default.
  ---@type boolean
  enabled = true,

  -- Vim modes that will show a rendered view of the markdown file, :h mode(), for all enabled components.
  -- Individual components can be enabled for other modes.
  -- Remaining modes will be unaffected by this plugin.
  ---@type render.md.Modes
  render_modes = {
    "n",
    "c",
    "t",
  },

  -- Milliseconds that must pass before updating marks, updates occur.
  -- within the context of the visible window, not the entire buffer.
  ---@type integer
  debounce = 100,

  -- Pre configured settings that will attempt to mimic various target user experiences.
  -- User provided settings will take precedence.
  -- obsidian: mimic Obsidian UI
  -- lazy: will attempt to stay up to date with LazyVim configuration
  -- none: does nothing
  ---@type render.md.config.Preset
  preset = "none",

  -- The level of logs to write to file:
  -- vim.fn.stdpath('state') .. '/render-markdown.log'.
  -- Only intended to be used for plugin development / debugging.
  ---@type render.md.log.Level
  log_level = "error",

  -- Print runtime of main update method.
  -- Only intended to be used for plugin development / debugging.
  ---@type boolean
  log_runtime = false,

  -- Filetypes this plugin will run on.
  ---@type string[]
  file_types = {
    "markdown",
  },

  -- Maximum file size (in MB) that this plugin will attempt to render.
  -- File larger than this will effectively be ignored.
  ---@type number
  max_file_size = 10.0,

  -- Takes buffer as input, if it returns true this plugin will not attach to the buffer.
  ---@type fun(buf: integer): boolean
  ignore = function(buf)
    return false
  end,

  -- Whether markdown should be rendered when nested inside markdown,
  -- i.e. markdown code block inside markdown file.
  ---@type boolean
  nested = true,

  -- Additional events that will trigger this plugin's render loop.
  ---@type string[]
  change_events = {
    -- TODO: it
  },

  -- Whether the treesitter highlighter should be restarted after this plugin attaches to its first buffer for the first time.
  -- May be necessary if this plugin is lazy loaded to clear highlights that have been dynamically disabled.
  ---@type boolean
  restart_highlighter = false,

  ---@type render.md.injection.Configs
  injections = require("plugins.render-markdown-nvim.opts.injections"),

  ---@type render.md.pattern.Configs
  patterns = require("plugins.render-markdown-nvim.opts.patterns"),

  ---@type render.md.anti.conceal.Config
  anti_conceal = require("plugins.render-markdown-nvim.opts.anti_conceal"),

  ---@type render.md.padding.Config
  padding = require("plugins.render-markdown-nvim.opts.padding"),

  ---@type render.md.latex.Config
  latex = require("plugins.render-markdown-nvim.opts.latex"),

  ---@type render.md.on.Config
  on = require("plugins.render-markdown-nvim.opts.on"),

  ---@type render.md.completions.Config
  completions = require("plugins.render-markdown-nvim.opts.completions"),

  ---@type render.md.heading.Config
  heading = require("plugins.render-markdown-nvim.opts.heading"),

  ---@type render.md.paragraph.Config
  paragraph = require("plugins.render-markdown-nvim.opts.paragraph"),

  ---@type render.md.code.Config
  code = require("plugins.render-markdown-nvim.opts.code"),

  ---@type render.md.dash.Config
  dash = require("plugins.render-markdown-nvim.opts.dash"),

  ---@type render.md.document.Config
  document = require("plugins.render-markdown-nvim.opts.document"),

  ---@type render.md.bullet.Config
  bullet = require("plugins.render-markdown-nvim.opts.bullet"),

  ---@type render.md.checkbox.Config
  checkbox = require("plugins.render-markdown-nvim.opts.checkbox"),

  ---@type render.md.quote.Config
  quote = require("plugins.render-markdown-nvim.opts.quote"),

  ---@type render.md.render.Config
  render = require("plugins.render-markdown-nvim.opts.render"),

  ---@type render.md.table.Config
  pipe_table = require("plugins.render-markdown-nvim.opts.pipe_table"),

  ---@type render.md.callout.Configs
  callout = require("plugins.render-markdown-nvim.opts.callout"),

  ---@type render.md.link.Config
  link = require("plugins.render-markdown-nvim.opts.link"),

  ---@type render.md.sign.Config
  sign = require("plugins.render-markdown-nvim.opts.sign"),

  ---@type render.md.inline.highlight.Config
  inline_highlight = require("plugins.render-markdown-nvim.opts.inline_highlight"),

  ---@type render.md.indent.Config
  indent = require("plugins.render-markdown-nvim.opts.indent"),

  ---@type render.md.html.Config
  html = require("plugins.render-markdown-nvim.opts.html"),

  ---@type render.md.window.Configs
  win_options = require("plugins.render-markdown-nvim.opts.win_options"),

  ---@type render.md.overrides.Config
  overrides = require("plugins.render-markdown-nvim.opts.overrides"),

  ---@type table<string, render.md.Handler>
  custom_handlers = require("plugins.render-markdown-nvim.opts.custom_handlers"),

  ---@type render.md.yaml.Config
  yaml = require("plugins.render-markdown-nvim.opts.yaml"),
}

return opts
