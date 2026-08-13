---@type table
local opts = {
  -- Acceleration modes
  -- time_driven:
  -- The default one.
  -- With this mode, if the interval of key-repeat takes more than `acceleration_limit` ms, the step is reset.
  -- If you want to decelerate up/down moving by time instead of reset, set `enable_deceleration` to `true`.
  -- In addition, if you want to change deceleration rate, set `deceleration_table` to a proper value. Even better, you can accelerate other movements (such as `w`, `b`) through `acceleration_motions`.
  -- position_driven:
  -- Reset steps using only position determination.
  -- Not sensitive enough, the effect is not good as the `time_driven` mode.
  -- Note that `acceleration_motions` isn't supported by this mode.
  ---@type string | "time_driven" | "position_driven"
  mode = "time_driven",

  -- Whether to enable deceleration
  ---@type boolean
  enable_deceleration = false,

  -- The additional accelerated motions for `time_driven` mode, such as {'w', 'b'}.
  ---@type table
  acceleration_motions = {},

  ---@type integer
  -- The accelerated limit for `time_driven` mode
  acceleration_limit = 150,

  -- Indexs represent steps of j/k mappings, values represent required number of typing j/k to advance steps.
  -- In the case of {5, 15, 29}, if j is hited: 1)less than 5 times, the acceleration step is 1, 2)more than 5 times and less than 15 times, the acceleration steps is 2, 3)more than 15 times and less than 29 times, the acceleration steps is 3, 4)and after 29 j hits, the acceleration steps is 4.
  ---@type table
  acceleration_table = {
    7,
    12,
    17,
    21,
    24,
    26,
    28,
    30,
  },

  -- Every element is a pair which the first element is elapsed time after last j/k typed and the second element is the count to decelerate steps.
  -- In the case of {{200, 3}, {300, 7}}, if the elapsed time: 1)less than 200ms, the deceleration step is 1, 2)more than 200ms and less than 300ms, the deceleration steps is 3, 3)more than 300ms, then deceleration steps is 7.
  ---@type table
  deceleration_table = {
    { 150, 9999 },
    --{ 200, 3 },
    --{ 300, 7 },
    --{ 450, 11 },
    --{ 600, 15 },
    --{ 750, 21 },
    --{ 900, 9999 },
  },
}

return opts
