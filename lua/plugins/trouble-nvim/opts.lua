---@type string
local opts_icons_last
--opts_icons_last = "└╴"
--opts_icons_last = "-╴"
opts_icons_last = "╰╴"

---@type trouble.Config
local opts = {
  -- auto close when there are no items
  auto_close = false,

  -- auto open when there are items
  auto_open = false,

  -- automatically open preview when on an item
  auto_preview = true,

  -- auto refresh when open
  auto_refresh = true,

  -- auto jump to the item when there's only one
  auto_jump = false,

  -- Focus the window when opened
  focus = false,

  -- restores the last location in the list when opening
  restore = true,

  -- Follow the current item
  follow = true,

  -- show indent guides
  indent_guides = true,

  -- limit number of items that can be displayed per section
  max_items = 200,

  -- render multi-line messages
  multiline = true,

  -- When pinned, the opened trouble window will be bound to the current buffer
  pinned = false,

  -- show a warning when there are no results
  warn_no_results = true,

  -- open the trouble window when there are no results
  open_no_results = false,

  -- window options for the results window.
  -- Can be a split or a floating window.
  ---@type trouble.Window.opts
  win = {},

  -- Window options for the preview window.
  -- Can be a split, floating window, or `main` to show the preview in the main editor window.
  ---@type trouble.Window.opts
  preview = {
    type = "main",

    -- when a buffer is not yet loaded, the preview window will be created in a scratch buffer with only syntax highlighting enabled.
    -- Set to false, if you want the preview to always be a real loaded buffer.
    scratch = true,
  },

  -- Throttle/Debounce settings.
  -- Should usually not be changed.
  ---@type table<string, number|{ms:number, debounce?:boolean}>
  throttle = {
    -- fetches new data when needed
    refresh = 20,

    -- updates the window
    update = 10,

    -- renders the window
    render = 10,

    -- follows the current item
    follow = 100,

    -- shows the preview for the current item
    preview = {
      ms = 100,

      debounce = true,
    },
  },

  -- Key mappings can be set to the name of a builtin action, or you can define your own custom action.
  ---@type table<string, trouble.Action.spec|false>
  keys = {
    ["?"] = "help",
    r = "refresh",
    R = "toggle_refresh",
    q = "close",
    o = "jump_close",
    ["<esc>"] = "cancel",
    ["<cr>"] = "jump",
    ["<2-leftmouse>"] = "jump",
    ["<c-s>"] = "jump_split",
    ["<c-v>"] = "jump_vsplit",

    -- go down to next item (accepts count)
    j = "next",

    ["}"] = "next",
    ["]]"] = "next",

    -- go up to prev item (accepts count)
    k = "prev",

    ["{"] = "prev",
    ["[["] = "prev",
    dd = "delete",
    d = {
      action = "delete",
      mode = "v",
    },
    i = "inspect",
    p = "preview",
    P = "toggle_preview",
    zo = "fold_open",
    zO = "fold_open_recursive",
    zc = "fold_close",
    zC = "fold_close_recursive",
    za = "fold_toggle",
    zA = "fold_toggle_recursive",
    zm = "fold_more",
    zM = "fold_close_all",
    zr = "fold_reduce",
    zR = "fold_open_all",
    zx = "fold_update",
    zX = "fold_update_all",
    zn = "fold_disable",
    zN = "fold_enable",
    zi = "fold_toggle_enable",

    -- example of a custom action that toggles the active view filter
    gb = {
      action = function(view)
        view:filter({
          buf = 0,
        }, {
          toggle = true,
        })
      end,
      desc = "Toggle Current Buffer Filter",
    },

    -- example of a custom action that toggles the severity
    s = {
      action = function(view)
        local f = view:get_filter("severity")
        local severity = ((f and f.filter.severity or 0) + 1) % 5
        view:filter({
          severity = severity,
        }, {
          id = "severity",
          template = "{hl:Title}Filter:{hl} {severity}",
          del = severity == 0,
        })
      end,
      desc = "Toggle Severity Filter",
    },
  },

  ---@type table<string, trouble.Mode>
  modes = {
    -- sources define their own modes, which you can use directly, or override like in the example below
    lsp_references = {
      -- some modes are configurable, see the source code for more details
      params = {
        include_declaration = true,
      },
    },

    -- The LSP base mode for:
    -- * lsp_definitions, lsp_references, lsp_implementations
    -- * lsp_type_definitions, lsp_declarations, lsp_command
    lsp_base = {
      params = {
        -- don't include the current location in the results
        include_current = false,
      },
    },

    -- more advanced example that extends the lsp_document_symbols
    symbols = {
      desc = "document symbols",
      mode = "lsp_document_symbols",
      focus = false,
      win = {
        position = "right",
      },
      filter = {
        -- remove Package since luals uses it for control flow structures
        ["not"] = {
          ft = "lua",
          kind = "Package",
        },
        any = {
          -- all symbol kinds for help / markdown files
          ft = {
            "help",
            "markdown",
          },

          -- default set of symbol kinds
          kind = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
          },
        },
      },
    },
  },

  icons = {
    ---@type trouble.Indent.symbols
    indent = {
      top = "│ ",
      middle = "├╴",
      last = opts_icons_last,
      fold_open = " ",
      fold_closed = " ",
      ws = "  ",
    },
    folder_closed = " ",
    folder_open = " ",
    kinds = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = " ",
      Constant = "󰏿 ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Function = "󰊕 ",
      Interface = " ",
      Key = " ",
      Method = "󰊕 ",
      Module = " ",
      Namespace = "󰦮 ",
      Null = " ",
      Number = "󰎠 ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      String = " ",
      Struct = "󰆼 ",
      TypeParameter = " ",
      Variable = "󰀫 ",
    },
  },
}

return opts
