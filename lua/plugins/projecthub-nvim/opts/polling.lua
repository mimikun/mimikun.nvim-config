-- Whatever the band, these stay immediate:
-- the selected project (every 5s - it is the one you are reading), returning to the window, and saving a file.
local polling = {
  -- up to here: full sweep every 30 seconds
  active_days = 7,

  -- up to here: full sweep every 5 minutes
  warm_days = 30,

  -- beyond: only on open, on focus, or when selected
  -- seconds between sweeps of the middle band
  warm_interval = 300,
}

return polling
