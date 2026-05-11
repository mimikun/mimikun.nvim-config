---@type LspsagaConfig.Definition
local definition = {
  -- defines float window width
  ---@type number
  width = 0.6,

  -- defines float window height
  ---@type number
  height = 0.5,

  -- Saves cursor position
  ---@type boolean
  save_pos = false,

  number = vim.o.number,
  relativenumber = vim.o.relativenumber,

  ---@type LspsagaConfig.Definition.Keys
  keys = {
    ---@type string | string[]
    edit = "<C-o>",

    -- open in vsplit
    ---@type string | string[]
    vsplit = "<C-v>",

    -- open in hsplit
    ---@type string | string[]
    split = "<C-x>",

    -- open in tabe
    ---@type string | string[]
    tabe = "<C-t>",

    ---@type string | string[]
    tabnew = "<C-c>n",

    -- quit the definition
    ---@type string | string[]
    quit = "q",

    -- close the definition
    ---@type string | string[]
    close = "<ESC>",
  },
}

return definition
