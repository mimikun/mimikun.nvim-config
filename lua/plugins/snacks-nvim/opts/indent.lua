---@type string
local hl_string = "SnacksIndent"

-- can be a list of hl groups to cycle through
---@type string[]
local _hl_table = {
  "SnacksIndent1",
  "SnacksIndent2",
  "SnacksIndent3",
  "SnacksIndent4",
  "SnacksIndent5",
  "SnacksIndent6",
  "SnacksIndent7",
  "SnacksIndent8",
}

-- Disabled: another plugin in this config already owns the feature.
-- indent-blankline-nvim / virt-column-nvim
---@type snacks.indent.Config
local indent = {
  enabled = false,
  indent = {
    priority = 1,

    -- enable indent guides
    enabled = true,
    char = "│",

    -- only show indent guides of the scope
    only_scope = false,

    -- only show indent guides in the current window
    only_current = false,

    -- hl groups for indent guides
    ---@type string | string[]
    hl = hl_string,
  },

  -- animate scopes.
  -- Enabled by default for Neovim >= 0.10
  -- Works on older versions but has to trigger redraws during animation.
  --- * out: animate outwards from the cursor
  --- * up: animate upwards from the cursor
  --- * down: animate downwards from the cursor
  --- * up_down: animate up or down based on the cursor position
  ---@class snacks.indent.animate: snacks.animate.Config
  ---@type snacks.animate.Config
  animate = {
    ---@type boolean
    enabled = vim.fn.has("nvim-0.10") == 1,

    ---@type string | "out" | "up_down" | "down" | "up"
    style = "out",

    easing = "linear",
    duration = {
      -- ms per step
      step = 20,

      -- maximum duration
      total = 500,
    },
  },

  ---@class snacks.indent.Scope.Config: snacks.scope.Config
  ---@type snacks.scope.Config
  scope = {
    -- enable highlighting the current scope
    enabled = true,

    priority = 200,
    char = "│",

    -- underline the start of the scope
    underline = false,

    -- only show scope in the current window
    only_current = false,

    -- hl group for scopes
    ---@type string | string[]
    hl = "SnacksIndentScope",
  },

  chunk = {
    -- when enabled, scopes will be rendered as chunks, except for the top-level scope which will be rendered as a scope.
    enabled = false,

    -- only show chunk scopes in the current window
    only_current = false,

    priority = 200,

    -- hl group for chunk scopes
    ---@type string|string[]
    hl = "SnacksIndentChunk",
    char = {
      corner_top = "┌",
      --corner_top = "╭",
      corner_bottom = "└",
      --corner_bottom = "╰",
      horizontal = "─",
      vertical = "│",
      arrow = ">",
    },
  },

  -- filter for buffers to enable indent guides
  ---@param buf number
  ---@param win number
  filter = function(buf, _win)
    return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
  end,
}

return indent
