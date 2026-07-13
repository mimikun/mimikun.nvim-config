---@type render.md.inline.highlight.Config
local inline_highlight = {
  -- Mimics Obsidian inline highlights when content is surrounded by double equals.
  -- The equals on both ends are concealed and the inner content is highlighted.

  -- Turn on / off inline highlight rendering.
  enabled = true,

  -- Additional modes to render inline highlights.
  render_modes = false,

  -- Applies to background of surrounded text.
  ---@type string
  highlight = "RenderMarkdownInlineHighlight",

  -- Define custom highlights based on text prefix.
  -- The key is for healthcheck and to allow users to change its values, value type below.
  -- prefix: matched against text body, @see :h vim.startswith()
  -- highlight: highlight for text body
  ---@type table<string, render.md.inline.highlight.custom.UserConfig>
  custom = {
    -- TODO: it
  },
}

return inline_highlight
