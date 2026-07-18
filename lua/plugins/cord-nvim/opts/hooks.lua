---@type table
local _quotes = {
  "Vanitas vanitatum et omnia vanitas.",
}

-- Hooks configuration
---@type CordHooksConfig
local hooks = {
  ---@alias CordManagerHook fun(manager: ActivityManager):nil | {fun: fun(manager: ActivityManager):nil, priority: number}
  ---@type CordManagerHook
  ready = function(_manager)
    local ready

    ready = nil

    return ready
  end,

  ---@alias CordEmptyHook fun():nil | {fun: fun():nil, priority: number}
  ---@type CordEmptyHook
  shutdown = function(_opts)
    local shutdown

    shutdown = nil

    return shutdown
  end,

  ---@alias CordHook fun(opts: CordOpts):nil | {fun: fun(opts: CordOpts):nil, priority: number}
  ---@type CordHook
  pre_activity = function(_opts)
    local pre_activity

    pre_activity = nil

    return pre_activity
  end,

  ---@alias CordActivityHook fun(opts: CordOpts, activity: Activity):nil | {fun: fun(opts: CordOpts, activity: Activity):nil, priority: number}
  ---@type CordActivityHook
  post_activity = function(_opts, _activity)
    local post_activity

    post_activity = nil

    -- TODO: it
    -- Show Quotes
    --activity.details = quotes[math.random(#quotes)]
    -- Neovim Version in Small Tooltip
    --local version = vim.version()
    --activity.assets.small_text = string.format('Neovim %s.%s.%s', version.major, version.minor, version.patch)
    return post_activity
  end,

  ---@alias CordHook fun(opts: CordOpts):nil | {fun: fun(opts: CordOpts):nil, priority: number}
  ---@type CordHook
  idle_enter = function(_opts)
    local idle_enter

    idle_enter = nil

    return idle_enter
  end,

  ---@alias CordHook fun(opts: CordOpts):nil | {fun: fun(opts: CordOpts):nil, priority: number}
  ---@type CordHook
  idle_leave = function(_opts)
    local idle_leave

    idle_leave = nil

    return idle_leave
  end,

  ---@alias CordHook fun(opts: CordOpts):nil | {fun: fun(opts: CordOpts):nil, priority: number}
  ---@type CordHook
  workspace_change = function(_opts)
    local workspace_change

    workspace_change = nil

    return workspace_change
  end,

  ---@alias CordManagerHook fun(manager: ActivityManager):nil | {fun: fun(manager: ActivityManager):nil, priority: number}
  ---@type CordManagerHook
  buf_enter = function(_manager)
    local buf_enter

    buf_enter = nil

    return buf_enter
  end,
}

return hooks
