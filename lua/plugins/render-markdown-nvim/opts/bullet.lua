---@type render.md.bullet.Config
local bullet = {
  -- Useful context to have when evaluating values.
  --   level: how deeply nested the list is, 1-indexed
  --   index: how far down the item is at that level, 1-indexed
  --   value: text value of the marker node

  -- Turn on / off list bullet rendering
  enabled = true,

  -- Additional modes to render list bullets
  render_modes = false,

  -- Replaces '-'|'+'|'*' of 'list_item'.
  -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
  -- Output is evaluated depending on the type.
  --   function:| `value(context)`
  --   string:| `value`
  --   string[]:| `cycle(value, context.level)`
  --   string[][]:| `clamp(cycle(value, context.level), context.index)`
  ---@type render.md.bullet.String
  icons = {
    "●",
    "○",
    "◆",
    "◇",
  },
  --icons = {
  --  "",
  --  "",
  --},
  -- Nested
  --icons = {
  --  {
  --    "󰫶 ",
  --    "󱂉 ",
  --  },
  --},

  -- Replaces 'n.'|'n)' of 'list_item'.
  -- Output is evaluated using the same logic as 'icons'.
  ---@type render.md.bullet.String
  ordered_icons = function(ctx)
    local value = vim.trim(ctx.value)
    local index = tonumber(value:sub(1, #value - 1))
    return ("%d."):format(index > 1 and index or ctx.index)
  end,

  -- Padding to add to the left of bullet point.
  -- Output is evaluated depending on the type.
  --   function: `value(context)`
  --   integer: `value`
  ---@type render.md.bullet.Integer
  left_pad = 0,

  -- Padding to add to the right of bullet point.
  -- Output is evaluated using the same logic as 'left_pad'.
  ---@type render.md.bullet.Integer
  right_pad = 0,

  -- Highlight for the bullet icon.
  -- Output is evaluated using the same logic as 'icons'.
  ---@type render.md.bullet.String
  highlight = "RenderMarkdownBullet",

  -- Highlight for item associated with the bullet point.
  -- Output is evaluated using the same logic as 'icons'.
  ---@type render.md.bullet.String
  scope_highlight = {},

  -- Priority to assign to scope highlight.
  ---@type integer
  scope_priority = nil,
}

return bullet
