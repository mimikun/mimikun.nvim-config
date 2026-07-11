-- Lifecycle hooks
---@type pomodoro.HooksConfig
local hooks = {
  ---@type fun(payload: pomodoro.HookPayload)
  on_work_start = function()
    ---@type pomodoro.HookPayload
    local payload = {
      ---@type number
      duration_min = nil,

      ---@type string | "short"|"long"
      kind = "short",

      ---@type number
      cycle_index = nil,
    }

    payload = nil

    return payload
  end,

  ---@type fun(payload: pomodoro.HookPayload)
  on_work_end = function()
    return nil
  end,

  ---@type fun(payload: pomodoro.HookPayload)
  on_break_start = function()
    return nil
  end,

  ---@type fun(payload: pomodoro.HookPayload)
  on_break_end = function()
    return nil
  end,

  ---@type fun(payload: pomodoro.HookPayload)
  on_cycle_complete = function()
    return nil
  end,
}

return hooks
