---@alias render.md.pattern.UserConfigs table<string, render.md.pattern.UserConfig>

---@type render.md.pattern.Configs
local patterns = {
  -- Highlight patterns to disable for filetypes, i.e. lines concealed around code blocks
  markdown = {
    ---@type boolean
    disable = true,
    ---@type render.md.directive.Config[]
    directives = {
      {
        ---@type integer
        id = 17,
        ---@type string
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
