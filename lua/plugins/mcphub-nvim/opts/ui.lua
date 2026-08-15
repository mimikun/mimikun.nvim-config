---@type MCPHub.UIConfig
local ui = {
  window = {
    -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
    ---@type string | number
    width = 0.8,

    -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
    ---@type string | number
    height = 0.8,

    ---@type string | "center" | "top-left" | "top-right" | "bottom-left" | "bottom-right" | "top" | "bottom" | "left" | "right"
    align = "center",

    relative = "editor",

    zindex = 50,

    ---@type string | "none" | "single" | "double" | "rounded" | "solid" | "shadow"
    border = "rounded",
  },

  -- window-scoped options (vim.wo)
  wo = {
    winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
  },
}

return ui
