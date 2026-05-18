---@class TriptychConfigGitSignDefineOptions
---@field icon? string
---@field linehl? string
---@field numhl? string
---@field text? string
---@field texthl? string
---@field culhl? string

---@alias KeyMapping (string | string[])

---@type TriptychConfig
local opts = {
  ---@type TriptychConfigMappings
  mappings = {
    -- Everything below is buffer-local, meaning it will only apply to Triptych windows
    ---@type KeyMapping
    show_help = "g?",

    -- Pressing again will toggle back
    ---@type KeyMapping
    jump_to_cwd = ".",

    ---@type KeyMapping
    nav_left = "h",

    -- If target is a file, opens the file in-place
    ---@type KeyMapping
    nav_right = {
      "l",
      "<CR>",
    },

    ---@type KeyMapping
    open_hsplit = {
      "-",
    },

    ---@type KeyMapping
    open_vsplit = {
      "|",
    },

    ---@type KeyMapping
    open_tab = {
      "<C-t>",
    },

    ---@type KeyMapping
    cd = "<leader>cd",

    ---@type KeyMapping
    delete = "d",

    ---@type KeyMapping
    add = "a",

    ---@type KeyMapping
    copy = "c",

    ---@type KeyMapping
    rename = "r",

    ---@type KeyMapping
    rename_from_scratch = "R",

    ---@type KeyMapping
    cut = "x",

    ---@type KeyMapping
    paste = "p",

    ---@type KeyMapping
    quit = "q",

    ---@type KeyMapping
    toggle_hidden = "<leader>.",

    ---@type KeyMapping
    toggle_collapse_dirs = "z",
  },

  ---@type { [string]: ExtensionMapping }
  extension_mappings = {
    ["<c-f>"] = {
      mode = "n",
      fn = function(target, _)
        require("telescope.builtin").live_grep({
          search_dirs = {
            target.path,
          },
        })
      end,
    },
  },

  ---@type TriptychConfigOptions
  options = {
    ---@type boolean
    dirs_first = true,

    ---@type boolean
    show_hidden = false,

    ---@type boolean
    collapse_dirs = true,

    ---@type TriptychConfigLineNumbers
    line_numbers = {
      ---@type boolean
      enabled = true,

      ---@type boolean
      relative = false,
    },

    ---@type TriptychConfigFileIcons
    file_icons = {
      ---@type boolean
      enabled = true,

      ---@type string
      directory_icon = "",

      ---@type string
      fallback_file_icon = "",
    },

    ---@type { [string]: number[] }
    responsive_column_widths = {
      -- Keys are breakpoints, values are column widths
      -- A breakpoint means "when vim.o.columns >= x, use these column widths"
      -- Columns widths must add up to 1 after rounding to 2 decimal places
      -- Parent or child windows can be hidden by setting a width of 0
      ["0"] = {
        0,
        0.5,
        0.5,
      },
      ["120"] = {
        0.2,
        0.3,
        0.5,
      },
      ["200"] = {
        0.25,
        0.25,
        0.5,
      },
    },

    -- Highlight groups to use. See `:highlight` or `:h highlight`
    ---@type TriptychConfigHighlights
    highlights = {
      ---@type string
      file_names = "NONE",

      ---@type string
      directory_names = "NONE",
    },

    -- Applies to file previews
    ---@type TriptychConfigSyntaxHighlighting
    syntax_highlighting = {
      ---@type boolean
      enabled = true,

      ---@type number
      debounce_ms = 100,
    },
    -- Backdrop opacity.
    -- 0 is fully opaque, 100 is fully transparent (disables the feature)
    ---@type number
    backdrop = 60,

    -- 0 is fully opaque, 100 is fully transparent
    ---@type number
    transparency = 0,

    -- See :h nvim_open_win for border options
    ---@type string | table
    border = "single",

    ---@type number
    max_height = 45,

    ---@type number
    max_width = 220,

    -- Space left and right
    ---@type number
    margin_x = 4,

    -- Space above and below
    ---@type number
    margin_y = 4,
  },
  ---@type TriptychConfigGitSigns
  git_signs = {
    ---@type boolean
    enabled = true,

    ---@type TriptychConfigGitSignsSigns
    signs = {
      -- The value can be either a string or a table.
      -- If a string, will be basic text.
      -- If a table, will be passed as the {dict} argument to vim.fn.sign_define
      -- If you want to add color, you can specify a highlight group in the table.
      ---@type string | TriptychConfigGitSignDefineOptions
      add = "+",

      ---@type string | TriptychConfigGitSignDefineOptions
      modify = "~",

      ---@type string | TriptychConfigGitSignDefineOptions
      rename = "r",

      ---@type string | TriptychConfigGitSignDefineOptions
      untracked = "?",
    },
  },

  ---@type TriptychConfigDiagnostic
  diagnostic_signs = {
    ---@type boolean
    enabled = true,
  },
}

return opts
