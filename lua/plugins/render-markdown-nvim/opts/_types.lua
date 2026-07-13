---@class (exact) render.md.directive.UserConfig
---@field id? integer
---@field name? string

---@alias render.md.window.UserConfigs table<string, render.md.window.UserConfig>

---@class (exact) render.md.window.UserConfig
---@field default? render.md.option.Value
---@field rendered? render.md.option.Value

---@class (exact) render.md.raw.UserConfig
---@field raw? string
