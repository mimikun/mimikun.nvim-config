local quicker = require("quicker")

---@module "quicker"
---@type quicker.SetupOptions
local opts = {
  -- Local options to set for quickfix
  ---@type table<string, any>
  opts = {
    buflisted = false,
    number = false,
    relativenumber = false,
    signcolumn = "auto",
    winfixheight = true,
    wrap = false,
  },

  -- Set to false to disable the default options in `opts`
  ---@type boolean
  use_default_opts = true,

  -- Keymaps to set for the quickfix buffer
  ---@type quicker.Keymap[]
  keys = {
    {
      ">",
      function()
        quicker.expand({
          before = 2,
          after = 2,
          add_to_existing = true,
        })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        quicker.collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },

  -- Callback function to run any custom logic or keymaps for the quickfix buffer
  ---@type fun(bufnr: number)
  on_qf = function(bufnr)
    -- it
  end,

  ---@type quicker.SetupEditConfig
  edit = {
    -- Enable editing the quickfix like a normal buffer
    ---@type boolean
    enabled = true,

    -- Set to true to write buffers after applying edits.
    -- Set to "unmodified" to only write unmodified buffers.
    ---@type boolean | string | "unmodified"
    autosave = "unmodified",
  },

  -- Keep the cursor to the right of the filename and lnum columns
  ---@type boolean
  constrain_cursor = true,

  -- Configure syntax highlighting
  ---@type quicker.SetupHighlightConfig
  highlight = {
    -- Use treesitter highlighting
    ---@type boolean
    treesitter = true,

    -- Use LSP semantic token highlighting
    ---@type boolean
    lsp = true,

    -- Load the referenced buffers to apply more accurate highlights (may be slow)
    ---@type boolean
    load_buffers = false,
  },

  -- Configure cursor following
  ---@type quicker.SetupFollowConfig
  follow = {
    -- When quickfix window is open, scroll to closest item to the cursor
    ---@type boolean
    enabled = false,
  },

  -- Map of quickfix item type to icon
  ---@type table<string, string>
  type_icons = {
    E = "󰅚 ",
    W = "󰀪 ",
    I = " ",
    N = " ",
    H = " ",
  },

  -- Border characters
  -- Characters used for drawing the borders
  ---@type quicker.SetupBorders
  borders = {
    ---@type string
    vert = "┃",

    -- Strong headers separate results from different files
    ---@type string
    strong_header = "━",

    ---@type string
    strong_cross = "╋",

    ---@type string
    strong_end = "┫",

    -- Soft headers separate results within the same file
    ---@type string
    soft_header = "╌",

    ---@type string
    soft_cross = "╂",

    ---@type string
    soft_end = "┨",
  },

  -- How to trim the leading whitespace from results.
  -- Can be 'all', 'common', or false
  ---@type quicker.TrimEnum | string | boolean | "all" | "common" | false
  trim_leading_whitespace = "common",

  -- Maximum width of the filename column
  ---@type fun(): integer
  max_filename_width = function()
    return math.floor(math.min(95, vim.o.columns / 2))
  end,

  -- How far the header should extend to the right
  ---@type fun(type: "hard" | "soft", start_col: integer): integer
  header_length = function(type, start_col)
    return vim.o.columns - start_col
  end,
}

return opts
