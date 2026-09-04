---@type render.md.completions.Config
local completions = {
  -- Settings for blink.cmp completions source
  ---@type render.md.completion.UserConfig
  blink = {
    ---@type boolean
    enabled = true,
  },

  -- Settings for coq_nvim completions source
  ---@type render.md.completion.UserConfig
  coq = {
    ---@type boolean
    enabled = false,
  },

  -- Settings for in-process language server completions
  ---@type render.md.completion.UserConfig
  lsp = {
    ---@type boolean
    enabled = true,
  },

  ---@type render.md.completion.filter.UserConfig
  filter = {
    ---@type fun(value: render.md.callout.UserConfig): boolean
    callout = function(_value)
      -- example to exclude obsidian callouts
      --return value.category ~= "obsidian"
      return true
    end,
    ---@type fun(value: render.md.checkbox.custom.UserConfig): boolean
    checkbox = function(_value)
      return true
    end,
  },
}

return completions
