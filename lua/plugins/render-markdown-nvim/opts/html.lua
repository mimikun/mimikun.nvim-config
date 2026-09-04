---@type render.md.html.Config
local html = {
  -- Turn on / off all HTML rendering.
  enabled = true,

  -- Additional modes to render HTML.
  render_modes = false,

  ---@type render.md.html.comment.Config
  comment = {
    -- Useful context to have when evaluating values.
    --   text: text value of the comment node

    -- Turn on / off HTML comment concealing.
    ---@type boolean
    conceal = true,

    -- Text to inline before the concealed comment.
    -- Output is evaluated depending on the type.
    --   function: `value(context)`
    --   string: `value`
    --   nil: nothing
    ---@type render.md.html.comment.String | string | fun(ctx: render.md.html.comment.Context): string? | nil
    text = nil,

    -- Highlight for the inlined text.
    ---@type string
    highlight = "RenderMarkdownHtmlComment",
  },

  -- HTML tags whose start and end will be hidden and icon shown.
  -- The key is matched against the tag name, value type below.
  --   icon: optional icon inlined at start of tag
  --   highlight: optional highlight for the icon
  --   scope_highlight: optional highlight for item associated with tag
  ---@type table<string, render.md.html.Tag>
  tag = {
    ---@field icon? string
    ---@field highlight? string
    ---@field scope_highlight? string
  },
}

return html
