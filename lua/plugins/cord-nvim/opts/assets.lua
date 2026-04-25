-- Assets configuration
---@type CordAssetConfig[]
local assets = {
  [".rs"] = {
    -- Asset icon
    ---@type string | fun(opts: CordOpts):string
    icon = function(opts)
      local icon

      icon = "rust"

      return icon
    end,

    -- Asset tooltip
    ---@type string | fun(opts: CordOpts):string
    tooltip = function(opts)
      local tooltip

      tooltip = "Rust"

      return tooltip
    end,

    -- Asset text
    ---@type string | fun(opts: CordOpts):string
    text = function(opts)
      local text

      text = "Writing in Rust"

      return text
    end,
  },
  netrw = {
    -- Asset name
    ---@type string | fun(opts: CordOpts):string
    name = function(opts)
      local name

      name = "Netrw"

      return name
    end,

    -- Asset type
    ---@type string | fun(opts: CordOpts):string
    type = function(opts)
      local type

      type = "file_browser"

      return type
    end,
  },
}

return assets
