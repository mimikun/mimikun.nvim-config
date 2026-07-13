---@type render.md.pattern.Configs
local patterns = {
  -- Highlight patterns to disable for filetypes,
  -- i.e. lines concealed around code blocks
  markdown = {
    ---@field disable? boolean
    disable = true,
    ---@field directives? render.md.directive.UserConfig[]
    directives = {
      {
        id = 17,
        name = "conceal_lines",
      },
      {
        id = 18,
        name = "conceal_lines",
      },
    },
  },
}

return patterns
