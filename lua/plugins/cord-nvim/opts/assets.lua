-- Assets configuration
---@type CordAssetConfig[]
local assets = {
  [".rs"] = {
    -- Asset icon
    ---@type string | fun(opts: CordOpts):string
    icon = function(_opts)
      local icon

      icon = "rust"

      return icon
    end,

    -- Asset tooltip
    ---@type string | fun(opts: CordOpts):string
    tooltip = function(_opts)
      local tooltip

      tooltip = "Rust"

      return tooltip
    end,

    -- Asset text
    ---@type string | fun(opts: CordOpts):string
    text = function(_opts)
      local text

      text = "Writing in Rust"

      return text
    end,
  },
  netrw = {
    -- Asset name
    ---@type string | fun(opts: CordOpts):string
    name = function(_opts)
      local name

      name = "Netrw"

      return name
    end,

    -- Asset type
    ---@type string | fun(opts: CordOpts):string
    type = function(_opts)
      local type

      type = "file_browser"

      return type
    end,
  },
}

return assets
