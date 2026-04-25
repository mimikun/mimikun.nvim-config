-- Idle configuration
---@type CordIdleConfig
local idle = {
  -- Whether idle detection is enabled
  ---@type boolean
  enabled = true,

  -- Idle timeout in milliseconds
  ---@type integer
  timeout = 300000,

  -- Whether to show idle status
  ---@type boolean
  show_status = true,

  -- Whether to show idle when editor is focused
  ---@type boolean
  ignore_focus = true,

  -- Whether to unidle the session when editor gains focus
  ---@type boolean
  unidle_on_focus = true,

  -- Whether to enable smart idle feature
  ---@type boolean
  smart_idle = true,

  -- Details shown when idle
  ---@type string | fun(opts: CordOpts):string
  details = function(opts)
    local deitals

    deitals = "Idling"

    return deitals
  end,

  -- State shown when idle
  ---@type string | fun(opts: CordOpts):string
  state = function(opts)
    local state

    state = nil

    return nil
  end,

  -- Tooltip shown when hovering over idle icon
  ---@type string | fun(opts: CordOpts):string
  tooltip = function(opts)
    local tooltip

    tooltip = "💤"

    return tooltip
  end,

  -- Idle icon
  ---@type string | fun(opts: CordOpts):string
  icon = function(opts)
    local icon

    icon = nil

    return icon
  end,
}

return idle
