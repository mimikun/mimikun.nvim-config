---@type table
local opts = {
  ring = {
    ---@type number Define the number of yanked items that will be saved and used for ring.
    history_length = 100,

    ---@type string | "shada" | "sqlite" | "memory"
    storage = "sqlite",

    ---@type string
    storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",

    ---@type boolean
    sync_with_numbered_registers = true,

    ---@type string | "update" | "move"
    cancel_event = "update",

    ---@type table Define registeres to be ignored.
    ignore_registers = {
      -- black hole register
      "_",
    },

    ---@type boolean
    update_register_on_cycle = false,
    permanent_wrapper = require("yanky.wrappers").remove_carriage_return,
  },
  picker = {
    select = {
      action = nil,
    },
    telescope = {
      ---@type boolean
      use_default_mappings = true,
      mappings = nil,
    },
  },
  system_clipboard = {
    ---@type boolean
    sync_with_ring = true,

    ---@type string | "*" | nil
    clipboard_register = nil,
  },
  highlight = {
    -- NOTE: Use y3owk1n/undo-glow.nvim

    -- Define if highlight put text feature is enabled.
    ---@type boolean
    on_put = false,

    -- NOTE: Use y3owk1n/undo-glow.nvim

    -- Define if highlight yanked text feature is enabled.
    ---@type boolean
    on_yank = false,

    ---@type number Define the duration of highlight.
    timer = 500,
  },

  preserve_cursor_position = {
    -- By default in Neovim, when yanking text, cursor moves to the start of the yanked text.
    -- Could be annoying especially when yanking a large text object such as a paragraph or a large text object.
    -- With this feature, yank will function exactly the same as previously with the one difference being that the cursor position will not change after performing a yank.
    -- Define if cursor position should be preserved on yank.
    -- This works only if mappings has been defined.
    ---@type boolean
    enabled = true,
  },
  textobj = {
    enabled = false,
  },
}

return opts
