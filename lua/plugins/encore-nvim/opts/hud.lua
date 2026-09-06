local hud = {
  ---@type boolean
  enabled = true,

  -- how long each popup stays visible, ms
  ---@type integer
  timeout = 4000,

  -- number of stacked popups
  ---@type integer
  max = 3,

  -- consecutive repeats of the same action merge into one popup with a count
  ---@type boolean
  merge = true,

  ---@type string | "bottom-right" | "top-right" | "bottom-left" | "top-left"
  position = "bottom-right",

  -- width relative to editor columns (float < 1), absolute cols otherwise
  ---@type number
  width = 0.4,

  ---@type integer
  zindex = 100,
}

return hud
