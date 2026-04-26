---@type blink.pairs.MappingsConfig
local mappings = {
  -- you can call require("blink.pairs.mappings").enable()
  -- and require("blink.pairs.mappings").disable()
  -- to enable/disable mappings at runtime
  ---@type boolean
  enabled = true,

  ---@type boolean
  cmdline = true,

  -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
  -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
  ---@type string[]
  disabled_filetypes = {},

  ---@type blink.pairs.WrapDefinitions
  wrap = {
    -- move closing pair via motion
    ["<C-b>"] = "motion",
    -- move opening pair via motion
    ["<C-S-b>"] = "motion_reverse",
    -- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
    -- set to nil, '' or false to disable the mapping
    -- treesitter node cycling: move closing pair to next/prev TS node boundary
    -- ['<C-l>'] = 'treesitter',
    -- ['<C-h>'] = 'treesitter_reverse',
    -- for normal mode mappings, only supports 'motion' and 'motion_reverse'
    normal_mode = {
      -- move closing pair via motion
      -- ['<C-b>'] = 'motion',
      -- move opening pair via motion
      -- ['<C-S-b>'] = 'motion_reverse',
    },
  },

  -- see the defaults:
  -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
  --- @type blink.pairs.RuleDefinitions
  pairs = {
    ["!"] = {
      {
        "<!--",
        "-->",
        languages = {
          "html",
          "markdown",
          "markdown_inline",
        },
      },
    },
    ["("] = ")",
    ["["] = {
      {
        "[",
        "]",
        space = function(ctx)
          return not ctx.ts:is_language("markdown")
            -- ignore markdown todo items (bullets and numbered)
            or (
              not ctx:text_before_cursor():match("^%s*[%*%-+]%s+%[%s*$")
              and not ctx:text_before_cursor():match("^%s*%d+%.%s+%[%s*$")
            )
        end,
      },
    },
    ["{"] = "}",
    ["'"] = {
      {
        "'''",
        when = function(ctx)
          return ctx:text_before_cursor(2) == "''"
        end,
        languages = {
          "python",
          "toml",
        },
      },
      {
        "'",
        enter = false,
        space = false,
        when = function(ctx)
          -- The `plaintex` filetype has no treesitter parser, so we can't disable
          -- this pair in math environments. Thus, disable this pair completely.
          -- TODO: disable inside "" strings?
          return ctx.ft ~= "plaintext"
            and ctx.ft ~= "scheme"
            and ctx.ft ~= "fennel"
            and (not ctx.char_under_cursor:match("%w") or ctx:is_after_cursor("'"))
            and ctx.ts:blacklist("singlequote").matches
        end,
      },
    },
    ['"'] = {
      {
        'r#"',
        '"#',
        languages = {
          "rust",
        },
        priority = 100,
      },
      {
        '"""',
        when = function(ctx)
          return ctx:text_before_cursor(2) == '""'
        end,
        languages = {
          "python",
          "elixir",
          "julia",
          "kotlin",
          "scala",
          "toml",
        },
      },
      {
        '"',
        enter = false,
        space = false,
      },
    },
    ["`"] = {
      {
        "```",
        when = function(ctx)
          return ctx:text_before_cursor(2) == "``"
        end,
        languages = {
          "markdown",
          "markdown_inline",
          "typst",
          "vimwiki",
          "rmarkdown",
          "rmd",
          "quarto",
        },
      },
      {
        "`",
        "'",
        languages = {
          "bibtex",
          "latex",
          "plaintex",
        },
      },
      {
        "`",
        enter = false,
        space = false,
      },
    },
    ["_"] = {
      {
        "_",
        when = function(ctx)
          return not ctx.char_under_cursor:match("%w") and ctx.ts:blacklist("underscore").matches
        end,
        languages = {
          "typst",
        },
      },
    },
    ["*"] = {
      {
        "*",
        when = function(ctx)
          return ctx.ts:blacklist("asterisk").matches
        end,
        languages = {
          "typst",
        },
      },
    },
    ["<"] = {
      {
        "<",
        ">",
        when = function(ctx)
          return ctx.ts:whitelist("angle").matches
        end,
        languages = {
          "rust",
        },
      },
    },
    ["$"] = {
      {
        "$",
        languages = {
          "markdown",
          "markdown_inline",
          "typst",
          "latex",
          "plaintex",
        },
      },
    },
  },
}

return mappings
