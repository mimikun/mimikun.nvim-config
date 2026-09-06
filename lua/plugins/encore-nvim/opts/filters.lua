local filters = {
  -- Drop matching actions from a view.
  -- `pattern` is a Lua pattern matched against the action's name as it appears in the HUD and history
  -- (the part after the icon, e.g. "j", "scroll", "diw", ":cnext", "ihello").
  -- Plain letters match as a substring, so use "^name$" for an exact name.
  -- `views` limits the filter to "hud" and/or "history" (default: both).

  -- hide scrolling from the HUD, but keep it recorded in the history
  {
    pattern = "^scroll$",
    views = {
      "hud",
    },
  },

  -- drop :w everywhere (neither HUD nor history)
  {
    pattern = "^:w$",
  },

  -- substring match: anything whose name contains "j" (j, 3j, dj, ...)
  {
    pattern = "j",
  },
}

return filters
