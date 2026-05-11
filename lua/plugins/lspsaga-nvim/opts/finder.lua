---@type LspsagaConfig.Finder
local finder = {
  -- max_height of the finder window (float layout)
  ---@type number
  max_height = 0.5,

  -- width of left panel in finder window
  ---@type number
  left_width = 0.4,

  ---@type LspMethods
  methods = {
    -- Keys are alias of LSP methods.
    -- Values are LSP methods, which you want to show in finder.
    ---@type string
    --"hoge" = nil,
  },

  -- Default search results shown
  -- ref: references
  -- imp: implementation
  -- def: definition
  -- any in config.methods
  ---@type string | "ref" | "imp" | "def"
  default = "ref+imp",

  ---@type string | "float" | "normal"
  layout = "float",

  -- If it’s true, it will disable show the no response message
  ---@type boolean
  silent = false,

  -- Filter search results
  ---@type string[]
  filter = {},

  -- Filename substitution function
  ---@type function
  fname_sub = function()
    return nil
  end,

  ---@type boolean
  sp_inexist = false,

  ---@type boolean
  sp_global = false,

  ---@type boolean
  ly_botright = false,

  number = vim.o.number,
  relativenumber = vim.o.relativenumber,

  ---@type boolean
  ref_opt = true,

  ---@type LspsagaConfig.Finder.Keys
  keys = {
    -- shuttle between the finder layout window
    ---@type string | string[]
    shuttle = "[w",

    -- toggle expand or open
    ---@type string | string[]
    toggle_or_open = "o",

    -- open in vsplit
    ---@type string | string[]
    vsplit = "s",

    -- open in hsplit
    ---@type string | string[]
    split = "i",

    -- open in tabe
    ---@type string | string[]
    tabe = "t",

    -- open in new tab
    ---@type string | string[]
    tabnew = "r",

    -- quit the finder; only works in layout left window
    ---@type string | string[]
    quit = "q",

    -- close the finder
    ---@type string | string[]
    close = "<C-c>k",
  },
}

return finder
