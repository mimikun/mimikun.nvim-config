---@type snacks.indent.Config
local indent = {
  enabled = true,
  indent = {
    -- enable indent guides
    enabled = true,
    priority = 1,
    char = "│",
    -- only show indent guides of the scope
    only_scope = false,
    -- only show indent guides in the current window
    only_current = false,
    --hl = "SnacksIndent",
    ---@type string|string[] hl groups for indent guides
    hl = {
      "SnacksIndent1",
      "SnacksIndent2",
      "SnacksIndent3",
      "SnacksIndent4",
      "SnacksIndent5",
      "SnacksIndent6",
      "SnacksIndent7",
      "SnacksIndent8",
    },
  },
  ---@type snacks.indent.animate
  animate = {
    enabled = true,
    --- * out: animate outwards from the cursor
    --- * up: animate upwards from the cursor
    --- * down: animate downwards from the cursor
    --- * up_down: animate up or down based on the cursor position
    ---@type string "out"|"up_down"|"down"|"up"
    style = "out",
    easing = "linear",
    duration = {
      -- ms per step
      step = 20,
      -- maximum duration
      total = 500,
    },
  },
  ---@type snacks.indent.Scope.Config
  scope = {
    -- enable highlighting the current scope
    enabled = true,
    priority = 200,
    char = "│",
    -- underline the start of the scope
    underline = false,
    -- only show scope in the current window
    only_current = false,
    ---@type string|string[] hl group for scopes
    hl = "SnacksIndentScope",
  },
  chunk = {
    -- when enabled, scopes will be rendered as chunks, except for the top-level scope which will be rendered as a scope.
    enabled = false,
    -- only show chunk scopes in the current window
    only_current = false,
    priority = 200,
    ---@type string|string[] hl group for chunk scopes
    hl = "SnacksIndentChunk",
    char = {
      corner_top = "┌",
      corner_bottom = "└",
      -- corner_top = "╭",
      -- corner_bottom = "╰",
      horizontal = "─",
      vertical = "│",
      arrow = ">",
    },
  },
  filter = function(buf, win)
    return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
  end,
}

return indent
