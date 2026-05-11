---@type LspsagaConfig.Hierarchy
local typehierarchy = {
  ---@type string | "float" | "normal"
  layout = "float",

  -- Width of left panel
  ---@type number
  left_width = 0.2,

  ---@type LspsagaConfig.Hierarchy.Keys
  keys = {
    ---@type string | string[]
    edit = "e",

    -- open in vsplit
    ---@type string | string[]
    vsplit = "s",

    -- open in hsplit
    ---@type string | string[]
    split = "i",

    -- open in tabe
    ---@type string | string[]
    tabe = "t",

    -- close the hierarchy
    ---@type string | string[]
    close = "<C-c>k",

    -- quit the hierarchy
    ---@type string | string[]
    quit = "q",

    -- shuttle between the hierarchy
    ---@type string | string[]
    shuttle = "[w",

    -- toggle or do request
    ---@type string | string[]
    toggle_or_req = "u",
  },
}

return typehierarchy
