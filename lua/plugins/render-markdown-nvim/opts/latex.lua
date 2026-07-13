---@type render.md.latex.Config
local latex = {
  -- Turn on / off latex rendering.
  enabled = true,

  -- Additional modes to render latex.
  render_modes = false,

  -- Executable used to convert latex formula to rendered unicode.
  -- If a list is provided the commands run in order until the first success.
  ---@field converter? string|string[]
  converter = {
    "utftex",
    "latex2text",
  },

  -- Render inline latex formulas.
  ---@field inline? boolean
  inline = true,

  -- Render block latex formulas.
  ---@field block? boolean
  block = true,

  -- Highlight for latex blocks.
  ---@field highlight? string
  highlight = "RenderMarkdownMath",

  -- Determines where latex formula is rendered relative to block.
  -- above: above latex block
  -- below: below latex block
  -- center: centered with latex block (must be single line)
  ---@field position? render.md.latex.Position
  position = "center",

  -- Number of empty lines above latex blocks.
  ---@field top_pad? integer
  top_pad = 0,

  -- Number of empty lines below latex blocks.
  ---@field bottom_pad? integer
  bottom_pad = 0,
}

return latex
