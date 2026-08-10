---@type blink.cmp.CompletionConfig
local completion = {
  ---@type blink.cmp.CompletionTriggerConfig
  trigger = {
    -- Show the menu after typing alphanumerics, `-` or `_`
    ---@type boolean
    show_on_keyword = true,

    -- Show the menu after typing a trigger character
    ---@type boolean
    show_on_trigger_character = true,

    -- Keep completing inside a snippet placeholder
    ---@type boolean
    show_in_snippet = true,
  },

  ---@type blink.cmp.CompletionListConfig
  list = {
    -- Maximum number of items to display
    ---@type integer
    max_items = 200,

    ---@type blink.cmp.CompletionListSelectionConfig
    selection = {
      -- Nothing is selected until <Tab> is pressed, so <CR> stays a newline
      -- while the menu is open but no candidate has been chosen.
      -- Recommended by the 'enter' keymap preset.
      ---@type boolean | fun(ctx: blink.cmp.Context): boolean
      preselect = false,

      -- Only write the item into the buffer on <CR>, not while cycling with <Tab>
      ---@type boolean | fun(ctx: blink.cmp.Context): boolean
      auto_insert = false,
    },
  },

  ---@type blink.cmp.CompletionMenuConfig
  menu = {
    ---@type boolean | fun(): boolean
    auto_show = true,

    ---@type integer
    auto_show_delay_ms = 0,

    ---@type integer
    min_width = 15,

    ---@type integer
    max_height = 10,

    -- nil inherits vim.o.winborder
    ---@type blink.cmp.WindowBorder
    border = nil,

    ---@type boolean
    scrollbar = true,
  },

  ---@type blink.cmp.CompletionDocumentationConfig
  documentation = {
    -- Show the documentation window when selecting an item
    ---@type boolean
    auto_show = true,

    ---@type integer
    auto_show_delay_ms = 500,

    ---@type boolean
    treesitter_highlighting = true,

    ---@type blink.cmp.CompletionDocumentationWindowConfig
    window = {
      ---@type integer
      max_width = 80,

      ---@type integer
      max_height = 20,

      -- nil inherits vim.o.winborder
      ---@type blink.cmp.WindowBorder
      border = nil,
    },
  },

  ---@type blink.cmp.CompletionGhostTextConfig
  ghost_text = {
    ---@type boolean | fun(): boolean
    enabled = false,
  },
}

return completion
