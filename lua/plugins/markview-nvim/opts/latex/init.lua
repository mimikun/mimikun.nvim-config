--- Creates a configuration table for a LaTeX command.
-- Command name(Text to show).
---@param name string
-- `virt_text_pos` extmark options.
---@param text_pos? "overlay" | "inline"
-- Characters to conceal.
---@param cmd_conceal? integer
-- Highlight group for the command.
---@param cmd_hl? string
---@return markview.config.latex.commands.opts
local operator = function(name, text_pos, cmd_conceal, cmd_hl)
  return {
    condition = function(item)
      return #item.args == 1
    end,

    on_command = function(item)
      local symbols = require("markview.symbols")

      return {
        end_col = item.range[2] + (cmd_conceal or 1),
        conceal = "",

        virt_text_pos = text_pos or "overlay",
        virt_text = {
          {
            symbols.tostring("default", name),
            cmd_hl or "@keyword.function",
          },
        },

        hl_mode = "combine",
      }
    end,

    on_args = {
      {
        on_before = function(item)
          return {
            end_col = item.range[2] + 1,

            virt_text_pos = "overlay",
            virt_text = {
              {
                "(",
                "@punctuation.bracket",
              },
            },

            hl_mode = "combine",
          }
        end,

        after_offset = function(range)
          return {
            range[1],
            range[2],
            range[3],
            range[4] - 1,
          }
        end,

        on_after = function(item)
          return {
            end_col = item.range[4],

            virt_text_pos = "overlay",
            virt_text = {
              {
                ")",
                "@punctuation.bracket",
              },
            },

            hl_mode = "combine",
          }
        end,
      },
    },
  }
end

-- Configuration for LaTeX.
---@type markview.config.latex
local latex = {
  -- Enable **LaTeX** rendering.
  ---@type boolean
  enable = nil,

  -- LaTeX blocks configuration(typically made with `$$...$$`).
  ---@type markview.config.latex.blocks
  blocks = {
    -- Enable rendering of `LaTeX blocks`.
    ---@type boolean
    enable = true,

    -- Highlight group for the block.
    ---@type string
    hl = "MarkviewCode",

    -- Number of `pad_char`s to add before each line.
    ---@type integer
    pad_amount = 3,

    -- Character to use as padding.
    ---@type string
    pad_char = " ",

    -- Label text shown on the top right side.
    ---@type string
    text = "  LaTeX ",

    -- Highlight group for the label.
    ---@type string
    text_hl = "MarkviewCodeInfo",
  },

  -- Inline LaTeX configuration(typically made with `$...$`).
  ---@type markview.config.latex.inlines
  inlines = {
    -- Enables preview of inline latex maths.
    ---@type boolean
    enable = true,

    -- Left corner.
    ---@type string
    --corner_left=nil,

    -- Highlight group for left corner.
    ---@type string
    --corner_left_hl=nil,

    -- string Right corner.
    ---@type string
    --corner_right=nil,

    -- Highlight group for right corner.
    ---@type string
    --corner_right_hl=nil,

    -- Base Highlight group.
    ---@type string
    hl = "MarkviewInlineCode",

    -- Left padding.
    ---@type string
    padding_left = " ",

    -- Highlight group for left padding.
    ---@type string
    --padding_left_hl=nil,

    -- Right padding.
    ---@type string
    padding_right = " ",

    -- Highlight group for right padding.
    ---@type string
    --padding_right_hl=nil,
  },

  -- LaTeX commands configuration(e.g. `\frac{x}{y}`).
  ---@type markview.config.latex.commands
  commands = {
    -- Enables rendering of LaTeX commands.
    ---@type boolean
    enable = true,

    -- Options for `\string` command.
    ---@field [string] markview.config.latex.commands.opts
    ["boxed"] = {
      -- Condition used to determine if a command is valid.
      ---@type fun(item: markview.parsed.latex.commands): boolean
      condition = function(item)
        return #item.args == 1
      end,

      -- Extmark configuration to use on the command.
      ---@type table
      on_command = {
        conceal = "",
      },

      -- Configuration table for each argument.
      ---@type markview.config.latex.commands.arg_opts[]?
      on_args = {
        {
          on_before = function(item)
            return {
              end_col = item.range[2] + 1,
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  " ",
                  "MarkviewPalette4Fg",
                },
                {
                  "[",
                  "@punctuation.bracket.latex",
                },
              },

              hl_mode = "combine",
            }
          end,

          after_offset = function(range)
            return {
              range[1],
              range[2],
              range[3],
              range[4] - 1,
            }
          end,
          on_after = function(item)
            return {
              end_col = item.range[4],
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  "]",
                  "@punctuation.bracket",
                },
              },

              hl_mode = "combine",
            }
          end,
        },
      },

      -- Modifies the command's range(`{ row_start, col_start, row_end, col_end }`).
      ---@type fun(range: integer[]): integer[]
      --command_offset=nil,
    },

    ["frac"] = {
      condition = function(item)
        return #item.args == 2
      end,
      on_command = {
        conceal = "",
      },

      on_args = {
        {
          on_before = function(item)
            return {
              end_col = item.range[2] + 1,
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  "(",
                  "@punctuation.bracket",
                },
              },

              hl_mode = "combine",
            }
          end,

          after_offset = function(range)
            return {
              range[1],
              range[2],
              range[3],
              range[4] - 1,
            }
          end,
          on_after = function(item)
            return {
              end_col = item.range[4],
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  ")",
                  "@punctuation.bracket",
                },
                {
                  " ÷ ",
                  "@keyword.function",
                },
              },

              hl_mode = "combine",
            }
          end,
        },
        {
          on_before = function(item)
            return {
              end_col = item.range[2] + 1,
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  "(",
                  "@punctuation.bracket",
                },
              },

              hl_mode = "combine",
            }
          end,

          after_offset = function(range)
            return {
              range[1],
              range[2],
              range[3],
              range[4] - 1,
            }
          end,
          on_after = function(item)
            return {
              end_col = item.range[4],
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  ")",
                  "@punctuation.bracket",
                },
              },

              hl_mode = "combine",
            }
          end,
        },
      },
    },

    ["vec"] = {
      condition = function(item)
        return #item.args == 1
      end,
      on_command = {
        conceal = "",
      },

      on_args = {
        {
          on_before = function(item)
            return {
              end_col = item.range[2] + 1,
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  "󱈥 ",
                  "MarkviewPalette2Fg",
                },
                {
                  "(",
                  "@punctuation.bracket.latex",
                },
              },

              hl_mode = "combine",
            }
          end,

          after_offset = function(range)
            return {
              range[1],
              range[2],
              range[3],
              range[4] - 1,
            }
          end,
          on_after = function(item)
            return {
              end_col = item.range[4],
              conceal = "",

              virt_text_pos = "inline",
              virt_text = {
                {
                  ")",
                  "@punctuation.bracket",
                },
              },

              hl_mode = "combine",
            }
          end,
        },
      },
    },

    ["sin"] = operator("sin"),
    ["cos"] = operator("cos"),
    ["tan"] = operator("tan"),

    ["sinh"] = operator("sinh"),
    ["cosh"] = operator("cosh"),
    ["tanh"] = operator("tanh"),

    ["csc"] = operator("csc"),
    ["sec"] = operator("sec"),
    ["cot"] = operator("cot"),

    ["csch"] = operator("csch"),
    ["sech"] = operator("sech"),
    ["coth"] = operator("coth"),

    ["arcsin"] = operator("arcsin"),
    ["arccos"] = operator("arccos"),
    ["arctan"] = operator("arctan"),

    ["arg"] = operator("arg"),
    ["deg"] = operator("deg"),
    ["det"] = operator("det"),
    ["dim"] = operator("dim"),
    ["exp"] = operator("exp"),
    ["gcd"] = operator("gcd"),
    ["hom"] = operator("hom"),
    ["inf"] = operator("inf"),
    ["ker"] = operator("ker"),
    ["lg"] = operator("lg"),

    ["lim"] = operator("lim"),
    ["liminf"] = operator("lim inf", "inline", 7),
    ["limsup"] = operator("lim sup", "inline", 7),

    ["ln"] = operator("ln"),
    ["log"] = operator("log"),
    ["min"] = operator("min"),
    ["max"] = operator("max"),
    ["Pr"] = operator("Pr"),
    ["sup"] = operator("sup"),

    ---@diagnostic disable:assign-type-mismatch
    ["sqrt"] = function()
      local symbols = require("markview.symbols")
      return operator(symbols.entries.sqrt, "inline", 5)
    end,
    ["lvert"] = function()
      local symbols = require("markview.symbols")
      return operator(symbols.entries.vert, "inline", 6)
    end,
    ["lVert"] = function()
      local symbols = require("markview.symbols")
      return operator(symbols.entries.Vert, "inline", 6)
    end,
    ---@diagnostic enable:assign-type-mismatch
  },

  -- LaTeX escaped characters configuration.
  ---@type markview.config.latex.escapes
  escapes = {
    -- Enable rendering of **escaped character**.
    ---@type boolean
    enable = true,

    -- Highlight group for the escaped character.
    ---@type string
    --hl=nil,
  },

  -- Configuration for hiding `{}`.
  ---@type markview.config.latex.parenthesis
  parenthesis = {
    -- Enable rendering of parenthesis.
    ---@type boolean
    enable = true,
  },

  -- LaTeX fonts configuration(e.g. `\mathtt{}`).
  ---@type markview.config.latex.fonts
  fonts = {
    -- Enable rendering of math fonts.
    ---@type boolean
    enable = true,

    -- Options for the default font.
    ---@type markview.config.latex.fonts.opts
    default = {
      -- Enable rendering of this font.
      ---@type boolean
      enable = true,

      -- string: Highlight group for this font.
      -- fun: Use the buffer & item data and return a group for this font.
      ---@type string | fun(buffer: integer, item: markview.parsed.latex.fonts): string?
      hl = "MarkviewSpecial",
    },

    -- Options for `string` font.
    ---@field [string] markview.config.latex.fonts.opts
    mathbf = {
      enable = true,
    },

    mathbfit = {
      enable = true,
    },

    mathcal = {
      enable = true,
    },

    mathscr = {
      enable = true,
    },

    mathbfscr = {
      enable = true,
    },

    mathfrak = {
      enable = true,
    },

    mathbb = {
      enable = true,
    },

    mathbffrak = {
      enable = true,
    },

    mathsf = {
      enable = true,
    },

    mathsfbf = {
      enable = true,
    },

    mathsfit = {
      enable = true,
    },

    mathsfbfit = {
      enable = true,
    },

    mathtt = {
      enable = true,
    },

    mathrm = {
      enable = true,
    },
  },

  -- LaTeX subscript configuration(`_{}`, `_x`).
  ---@type markview.config.latex.subscripts
  subscripts = {
    -- Enables preview of subscript text.
    ---@type boolean
    enable = true,

    -- Use Unicode characters to mimic subscript text.
    ---@type boolean
    --fake_preview=nil,

    -- Highlight group for the subscript text.
    -- Can be a list to use different hl for nested subscripts.
    ---@type string | string[]
    hl = "MarkviewSubscript",
  },

  -- LaTeX superscript configuration(`^{}`, `^x`).
  ---@type markview.config.latex.superscripts
  superscripts = {
    -- Enables preview of superscript text.
    ---@type boolean
    enable = true,

    -- Use Unicode characters to mimic superscript text.
    ---@type boolean
    --fake_preview=nil,

    -- Highlight group for the superscript text.
    -- Can be a list to use different hl for nested superscripts.
    ---@type string | string[]
    hl = "MarkviewSuperscript",
  },

  -- TeX math symbols configuration(e.g. `\alpha`).
  ---@type markview.config.latex.symbols
  symbols = {
    -- Enable rendering of Math symbols.
    ---@type boolean
    enable = true,

    -- Highlight group for the symbols.
    ---@type string
    hl = "MarkviewComment",
  },

  -- Text block configuration(`\text{}`).
  ---@type markview.config.latex.texts
  texts = {
    -- Enable rendering of text blocks.
    ---@type boolean
    enable = true,
  },
}

return latex
