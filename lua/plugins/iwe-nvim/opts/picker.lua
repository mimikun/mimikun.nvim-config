-- Picker backend configuration
---@type IWE.Config.Picker
local picker = {
  -- Backend: "auto", "telescope", "fzf_lua", "snacks", "mini", "vim_ui", or function
  ---@type string | "auto" | "telescope" | "fzf_lua" | "snacks" | "mini" | "vim_ui" | function
  backend = "auto",

  -- Whether to notify when falling back to another backend
  ---@type boolean
  fallback_notify = true,
}

return picker
