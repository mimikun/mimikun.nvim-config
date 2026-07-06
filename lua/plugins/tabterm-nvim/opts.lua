---@type tabterm.Config
local opts = {
  ---@type tabterm.UIConfig
  ui = {
    ---@type string | "single" | "double" | "round" | "none"
    border = "single",

    ---@type integer
    sidebar_width = 30,

    ---@type tabterm.FloatConfig
    float = {
      ---@type number
      width = 0.70,

      ---@type number
      height = 0.70,
    },
  },

  ---@type tabterm.ShellIntegrationConfig
  shell_integration = {
    ---@type boolean
    enabled = true,

    ---@type tabterm.ShellIntegrationShellsConfig
    shells = {
      ---@type boolean
      bash = true,

      ---@type boolean
      zsh = true,
    },
  },
}

return opts
