---@type DoraConfig
local opts = {
  -- Whether to show file icons.
  -- Set to true or "nvim-web-devicons" to use nvim-web-devicons, or "mini.icons" to use mini.icons.
  ---@type DoraIconConfig | boolean | "nvim-web-devicons" | "mini.icons"
  icons = true,

  -- Number of columns used for each level of tree indentation.
  ---@type integer
  tree_indent = 4,

  -- Whether to show the current browsed directory as the tree root.
  ---@type boolean
  show_root = false,

  -- Whether <Esc> in insert mode closes prompts.
  ---@type boolean
  prompt_insert_esc_closes = true,

  -- Whether to show keymap hints for two-key normal mode mappings.
  ---@type boolean
  show_keymap_hints = true,

  -- Whether hidden files should be shown by default.
  ---@type boolean
  show_hidden_files = true,

  -- Function used to determine what files should be hidden.
  ---@type fun(file: DoraFile, files: DoraFile[], dir: string): boolean
  is_hidden_file = function(file)
    ---@class DoraFile
    ---@field name string
    ---@field type DoraFileType
    ---@field size? integer
    ---@field mtime? table
    ---@field birthtime? table
    return vim.startswith(file.name, ".")
  end,

  -- Which side of the window the preview opens on.
  ---@type string | "left" | "right" | "above" | "below"
  preview_split = "right",

  -- Default file sorting order.
  -- ("name"|"name_desc"|"modified"|"modified_desc"|"created"|"created_desc"|"size"|"size_desc"|"extension"|"extension_desc")
  ---@type DoraSortOrder | "name" | "name_desc" | "modified" | "modified_desc" | "created" | "created_desc" | "size" | "size_desc" | "extension" | "extension_desc"
  sort_order = "name",

  -- Timeout in milliseconds for LSP willRenameFiles requests.
  -- (0 to disable)
  ---@type number
  lsp_timeout = 1000,

  ---@type table<string, DoraKeymapSpec>
  keymaps = require("plugins.nvim-dora.opts.keymaps"),
}

return opts
