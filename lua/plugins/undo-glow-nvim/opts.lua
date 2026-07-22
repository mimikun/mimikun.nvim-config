---Animation type aliases.
---@alias UndoGlow.AnimationTypeString
---| '"fade"'
---| '"fade_reverse"'
---| '"blink"'
---| '"pulse"'
---| '"jitter"'
---| '"spring"'
---| '"desaturate"'
---| '"strobe"'
---| '"zoom"'
---| '"rainbow"'
---| '"slide"'
---@alias UndoGlow.AnimationTypeFn fun(opts: UndoGlow.Animation)

---Easing function aliases.
---@alias UndoGlow.EasingString
---| '"linear"'
---| '"in_quad"'
---| '"out_quad"'
---| '"in_out_quad"'
---| '"out_in_quad"'
---| '"in_cubic"'
---| '"out_cubic"'
---| '"in_out_cubic"'
---| '"out_in_cubic"'
---| '"in_quart"'
---| '"out_quart"'
---| '"in_out_quart"'
---| '"out_in_quart"'
---| '"in_quint"'
---| '"out_quint"'
---| '"in_out_quint"'
---| '"out_in_quint"'
---| '"in_sine"'
---| '"out_sine"'
---| '"in_out_sine"'
---| '"out_in_sine"'
---| '"in_expo"'
---| '"out_expo"'
---| '"in_out_expo"'
---| '"out_in_expo"'
---| '"in_circ"'
---| '"out_circ"'
---| '"in_out_circ"'
---| '"out_in_circ"'
---| '"in_elastic"'
---| '"out_elastic"'
---| '"in_out_elastic"'
---| '"out_in_elastic"'
---| '"in_back"'
---| '"out_back"'
---| '"in_out_back"'
---| '"out_in_back"'
---| '"in_bounce"'
---| '"out_bounce"'
---| '"in_out_bounce"'
---| '"out_in_bounce"'
---@alias UndoGlow.EasingFn fun(opts: UndoGlow.EasingOpts): number

---@type UndoGlow.Config
local opts = {

  -- Configuration for animations.
  ---@type UndoGlow.Config.Animation
  animation = {
    -- Whether animation is enabled.
    ---@type boolean
    enabled = true,

    -- Duration of the highlight animation in milliseconds.
    ---@type number
    duration = 300,

    -- Animation type (a string key or a custom function).
    ---@type UndoGlow.AnimationTypeString | UndoGlow.AnimationTypeFn
    animation_type = "zoom",

    -- Frames per second for the animation.
    ---@type number
    fps = 120,

    -- Easing function (a string key or a custom function).
    ---@type UndoGlow.EasingString | UndoGlow.EasingFn
    easing = "in_out_cubic",

    -- If enabled, the highlight effect is constrained to the current active window, even if the buffer is shared across splits.
    ---@type boolean
    window_scoped = true,
  },

  -- Fallback color for when the highlight is transparent.
  ---@type UndoGlow.Config.FallbackForTransparency
  fallback_for_transparency = {

    -- Background color as a hex string.
    ---@type string
    bg = nil,

    -- Optional foreground color as a hex string.
    ---@type string
    fg = nil,
  },

  -- Extmark priority to render the highlight (Default 4096)
  ---@type integer
  priority = 2048 * 3,
}

return opts
