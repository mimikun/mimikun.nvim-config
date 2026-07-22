---@type SatelliteConfig
local opts = {
  -- Whether satellite should only be displayed in the current window.
  ---@type boolean
  current_only = false,

  -- Level of transparency for scrollbars.
  -- Must be between `0` (opaque) and `100` (transparent).
  ---@type integer
  winblend = 50,

  -- Z-index for scrollbars.
  ---@type integer
  zindex = 40,

  -- File types for which scrollbars should not be displayed.
  ---@type string[]
  excluded_filetypes = {
    --it
  },

  width = 2,

  ---@type HandlerConfigs
  handlers = {
    ---@type Satellite.Handlers.BaseConfig
    cursor = {
      -- Whether the handler is enabled
      ---@type boolean
      enable = true,

      -- Supports any number of symbols
      ---@type string[]
      symbols = {
        "⎺",
        "⎻",
        "⎼",
        "⎽",
        --"⎻",
        --"⎼",
      },
    },

    ---@type Satellite.Handlers.SearchConfig
    search = {
      -- Whether the handler is enabled
      ---@type boolean
      enable = true,
    },

    ---@type Satellite.Handlers.DiagnosticConfig
    diagnostic = {
      -- Whether the handler is enabled
      ---@type boolean
      enable = true,

      signs = {
        "-",
        "=",
        "≡",
      },

      min_severity = vim.diagnostic.severity.HINT,
    },

    ---@type Satellite.Handlers.GitsignsConfig
    gitsigns = {
      -- Whether the handler is enabled
      ---@type boolean
      enable = true,

      -- can only be a single character (multibyte is okay)
      signs = {
        add = "│",
        change = "│",
        delete = "-",
      },
    },

    ---@type Satellite.Handlers.MarksConfig
    marks = {
      -- Whether the handler is enabled
      ---@type boolean
      enable = true,

      -- shows the builtin marks like [ ] < >
      ---@type boolean
      show_builtins = false,

      ---@type string
      key = "m",
    },

    ---@type Satellite.Handlers.BaseConfig
    quickfix = {
      -- Whether the handler is enabled
      ---@type boolean
      enable = true,
      signs = {
        "-",
        "=",
        "≡",
      },
    },
  },
}

return opts
