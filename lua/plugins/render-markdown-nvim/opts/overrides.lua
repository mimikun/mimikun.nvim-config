---@type render.md.overrides.Config
local overrides = {
  -- More granular configuration mechanism, allows different aspects of buffers to have their own behavior.
  -- Values default to the top level configuration if no override is provided.
  -- Supports the following fields:
  --   enabled, render_modes, debounce, anti_conceal, bullet, callout, checkbox, code, dash,
  --   document, heading, html, indent, inline_highlight, latex, link, padding, paragraph,
  --   pipe_table, quote, sign, win_options, yaml

  -- Override for different buflisted values, @see :h 'buflisted'.
  ---@type table<boolean, render.md.partial.UserConfig>
  buflisted = {},

  -- Override for different buftype values, @see :h 'buftype'.
  ---@type table<string, render.md.partial.UserConfig>
  buftype = {
    nofile = {
      render_modes = true,
      sign = {
        enabled = false,
      },
    },
  },

  -- Override for different filetype values, @see :h 'filetype'.
  ---@type table<string, render.md.partial.UserConfig>
  filetype = {},

  -- Override for preview buffer.
  ---@type render.md.partial.UserConfig
  preview = {
    render_modes = true,
  },
}

return overrides
