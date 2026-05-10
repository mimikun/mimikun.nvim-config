-- Configures the viewport of where indentation guides are generated
---@type ibl.config.viewport_buffer
local viewport_buffer = {
  -- Minimum number of lines above and below of what is currently visible in the window for which indentation guides will be generated
  ---@type number
  min = 30,

  -- Maximum number of lines above and below of what is currently visible in the window for which indentation guides will be generated
  ---@type number
  max = 500,
}

return viewport_buffer
