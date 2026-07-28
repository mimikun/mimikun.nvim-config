---@type table
local opts = {
  -- Recommended by the README: skip the preview labels for matches that
  -- start with whitespace or sit mid-word, so the first keypress does not
  -- light up the whole screen.
  ---@param ch0 string
  ---@param ch1 string
  ---@param ch2 string
  ---@return boolean
  preview = function(ch0, ch1, ch2)
    return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
  end,
}

return opts
