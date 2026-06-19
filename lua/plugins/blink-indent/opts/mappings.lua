---@type blink.indent.MappingsConfig
local mappings = {
  -- Border to include when using textobjects
  ---@type string | "top" | "bottom" | "both" | "none"
  border = "both",

  -- Textobject for scope (e.g. `y2ii` to yank current and outer scope)
  -- set to '' to disable
  ---@type string | "ii"
  object_scope = "ii",

  -- Textobject for scope including the line above and below (e.g. `yai` to yank current scope)
  ---@type string | "ai"
  object_scope_with_border = "ai",

  -- Jump to top of scope
  ---@type string | "[i"
  goto_top = "[i",

  -- Jump to bottom of scope
  ---@type string | "]i"
  goto_bottom = "]i",
}

return mappings
