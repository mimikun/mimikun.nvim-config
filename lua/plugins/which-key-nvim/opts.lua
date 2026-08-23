---@type wk.Opts
local opts = {
  ---@type false | "classic" | "modern" | "helix"
  preset = "classic",

  -- Delay before showing the popup. Can be a number or a function that returns a number.
  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,

  ---@param mapping wk.Mapping
  filter = function(_mapping)
    -- example to exclude mappings without a description
    --return mapping.desc and mapping.desc ~= ""
    return true
  end,

  --- You can add any mappings here, or use `require('which-key').add()` later Group labels.
  --- Without these the first level of the popup shows a bare "+" and gives no hint what a prefix holds, so the prefix has to be memorised even though which-key is open.
  ---@type wk.Spec
  spec = {
    {
      "<leader>a",
      group = "ai",
    },
    {
      "<leader>C",
      group = "cord",
    },
    {
      "<leader>d",
      group = "diagnostics",
    },
    {
      "<leader>j",
      group = "jump2d",
    },
    {
      "<leader>l",
      group = "leap",
    },
    {
      "<leader>o",
      group = "github",
    },
    {
      "<leader>q",
      group = "session",
    },
    {
      "<leader>u",
      group = "toggle",
    },
    {
      "<leader>x",
      group = "trouble",
    },
    {
      "<leader>z",
      group = "telekasten",
    },
  },

  -- show a warning when issues were detected with your mappings
  notify = true,

  -- Which-key automatically sets up triggers for your mappings.
  -- But you can disable this and setup the triggers manually.
  -- Check the docs for more info.
  ---@type wk.Spec
  triggers = {
    {
      "<auto>",
      mode = "nxso",
    },
  },

  -- Start hidden and wait for a key to be pressed before showing the popup
  -- Only used by enabled xo mapping modes.
  ---@param ctx { mode: string, operator: string }
  defer = function(ctx)
    return ctx.mode == "V" or ctx.mode == "<C-V>"
  end,

  plugins = {
    -- shows a list of your marks on ' and `
    marks = true,

    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    registers = true,

    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      enabled = true,

      -- how many suggestions should be shown in the list?
      suggestions = 20,
    },

    presets = {
      -- adds help for operators like d, y, ...
      operators = true,

      -- adds help for motions
      motions = true,

      -- help for text objects triggered after entering an operator
      text_objects = true,

      -- default bindings on <c-w>
      windows = true,

      -- misc bindings to work with windows
      nav = true,

      -- bindings for folds, spelling and others prefixed with z
      z = true,

      -- bindings for prefixed with g
      g = true,
    },
  },

  ---@type wk.Win.opts
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,

    --width = 1,
    --height = { min = 4, max = 25 },
    --col = 0,
    --row = math.huge,
    --border = "none",
    -- extra window padding [top/bottom, right/left]
    padding = {
      1,
      2,
    },

    title = true,

    title_pos = "center",

    zindex = 1000,

    -- Additional vim.wo and vim.bo options
    bo = {
      --it
    },

    wo = {
      -- value between 0-100 0 for fully opaque and 100 for fully transparent
      --winblend = 10,
    },
  },

  layout = {
    -- min and max width of the columns
    width = {
      min = 20,
    },

    -- spacing between columns
    spacing = 3,
  },

  keys = {
    -- binding to scroll down inside the popup
    scroll_down = "<c-d>",

    -- binding to scroll up inside the popup
    scroll_up = "<c-u>",
  },

  ---@type (string | wk.Sorter)[]
  --- Mappings are sorted using configured sorters and natural sort of the keys
  --- Available sorters:
  --- * local: buffer-local mappings first
  --- * order: order of the items (Used by plugins like marks / registers)
  --- * group: groups last
  --- * alphanum: alpha-numerical first
  --- * mod: special modifier keys last
  --- * manual: the order the mappings were added
  --- * case: lower-case first
  sort = {
    "local",
    "order",
    "group",
    "alphanum",
    "mod",
  },

  -- Expand groups holding <= n mappings.
  -- Must stay a number.

  -- This was a function returning 0.
  -- The function form is used directly as a condition (lua/which-key/view.lua:307-308) and 0 is truthy in Lua, so it expanded every group instead of none: the first level of the popup became a flat list of 289 rows with no group entries at all.
  -- As a number it takes the intended path (view.lua:311) and the whole leader map fits on one screen as "j -> +jump2d", "l -> +leap", "z -> +19 keymaps" and so on.

  -- To expand all nodes without a description instead:
  --   expand = function(node) return not node.desc end
  --expand = function(_node)
  --  local expand
  --  expand = 0
  --  -- expand all nodes without a description
  --  --expand = not node.desc
  --  return expand
  --end,
  ---@type number | fun(node: wk.Node):boolean?
  expand = 0,

  -- Functions/Lua Patterns for formatting the labels
  ---@type table<string, ({[1]:string, [2]:string} | fun(str:string):string)[]>
  replace = {
    key = {
      function(key)
        return require("which-key.view").format(key)
      end,
      --{
      --  "<Space>",
      --  "SPC",
      --},
    },

    desc = {
      {
        "<Plug>%(?(.*)%)?",
        "%1",
      },
      {
        "^%+",
        "",
      },
      {
        "<[cC]md>",
        "",
      },
      {
        "<[cC][rR]>",
        "",
      },
      {
        "<[sS]ilent>",
        "",
      },
      {
        "^lua%s+",
        "",
      },
      {
        "^call%s+",
        "",
      },
      {
        "^:%s*",
        "",
      },
    },
  },

  icons = {
    -- symbol used in the command line area that shows your active key combo
    breadcrumb = "»",

    -- symbol used between a key and it's label
    separator = "➜",

    -- symbol prepended to a group
    group = "+",

    ellipsis = "…",

    -- set to false to disable all mapping icons, both those explicitly added in a mapping and those from rules
    mappings = true,

    --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons from rules
    ---@type wk.IconRule[] | false
    rules = {
      --it
    },

    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,

    -- used by key format
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "󰘴 ",
      M = "󰘵 ",
      D = "󰘳 ",
      S = "󰘶 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },
  },

  -- show a help message in the command line for using WhichKey
  show_help = true,

  -- show the currently pressed key and its label as a message in the command line
  show_keys = true,

  -- disable WhichKey for certain buf types and file types.
  disable = {
    ft = {
      --it
    },

    bt = {
      --it
    },
  },

  -- enable wk.log in the current directory
  debug = false,
}

return opts
