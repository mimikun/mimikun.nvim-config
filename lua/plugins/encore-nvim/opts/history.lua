local history = {
  -- width/height relative to the editor (float < 1), absolute cells otherwise
  ---@type number
  width = 0.45,

  height = 0.5,

  ---@type integer
  zindex = 55,

  show_description = true,

  show_time = true,

  -- fold consecutive repeats of the same action with native vim folds
  ---@type boolean
  fold_repeats = true,

  -- minimum run length to fold (runs shorter than this stay flat)
  ---@type integer
  fold_min = 3,

  --- max rows rendered in the view (keeps full re-renders bounded);
  --- set to 0 for no limit
  ---@type integer
  render_limit = 5000,
}

return history
