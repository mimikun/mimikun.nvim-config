---@type table<string, function>
local renderers = {
  --- Custom renderer for YAML properties.
  -- Namespace to use for extmarks.
  ---@param ns integer
  -- Buffer where
  ---@param buffer integer
  -- The parsed version of a node.
  ---@param item table
  yaml_property = function(_ns, _buffer, _item)
    --- Do stuff.
  end,
}

return renderers
