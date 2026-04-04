---@type TodoOptions
local opts = {
  -- show icons in the signs column
  signs = true,
  -- sign priority
  sign_priority = 8,
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      -- icon used for the sign, and in search results
      icon = " ",
      -- can be a hex color, or a named color (see below)
      color = "error",
      -- a set of other keywords that all map to this FIX keywords
      alt = {
        "FIXME",
        "BUG",
        "FIXIT",
        "ISSUE",
      },
      -- configure signs for some keywords individually
      --signs = false,
    },
    TODO = {
      icon = " ",
      color = "info",
    },
    HACK = {
      icon = " ",
      color = "warning",
    },
    WARN = {
      icon = " ",
      color = "warning",
      alt = {
        "WARNING",
        "XXX",
      },
    },
    PERF = {
      icon = " ",
      alt = {
        "OPTIM",
        "PERFORMANCE",
        "OPTIMIZE",
      },
    },
    NOTE = {
      icon = " ",
      color = "hint",
      alt = {
        "INFO",
      },
    },
    TEST = {
      icon = "⏲ ",
      color = "test",
      alt = {
        "TESTING",
        "PASSED",
        "FAILED",
      },
    },
  },
  gui_style = {
    -- The gui style to use for the fg highlight group.
    fg = "NONE",
    -- The gui style to use for the bg highlight group.
    bg = "BOLD",
  },
  -- when true, custom keywords will be merged with the defaults
  merge_keywords = true,
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    -- enable multine todo comments
    multiline = true,
    -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_pattern = "^.",
    -- extra lines that will be re-evaluated when changing a line
    multiline_context = 10,
    ---@type string | "fg" | "bg" | ""
    before = "",
    -- wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg
    ---@type string | "fg" | "bg" | "wide" | "wide_bg" | "wide_fg" | ""
    keyword = "wide",
    ---@type string | "fg" | "bg" | ""
    after = "fg",
    -- pattern or table of patterns, used for highlighting (vim regex)
    pattern = [[.*<(KEYWORDS)\s*:]],
    -- uses treesitter to match keywords in comments only
    comments_only = true,
    -- ignore lines longer than this
    max_line_len = 400,
    -- list of file types to exclude highlighting
    exclude = {},
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of highlight groups or use the hex color if hl not found as a fallback
  colors = {
    error = {
      "DiagnosticError",
      "ErrorMsg",
      "#DC2626",
    },
    warning = {
      "DiagnosticWarn",
      "WarningMsg",
      "#FBBF24",
    },
    info = {
      "DiagnosticInfo",
      "#2563EB",
    },
    hint = {
      "DiagnosticHint",
      "#10B981",
    },
    default = {
      "Identifier",
      "#7C3AED",
    },
    test = {
      "Identifier",
      "#FF00FF",
    },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    -- ripgrep regex
    pattern = [[\b(KEYWORDS):]],
    -- match without the extra colon. You'll likely get false positives
    --pattern = [[\b(KEYWORDS)\b]],
  },
}

return opts
