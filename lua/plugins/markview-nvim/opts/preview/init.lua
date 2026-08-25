-- Preview options
---@type markview.config.preview
local preview = {
  -- Enables *preview* when attaching to new buffers.
  ---@type boolean
  enable = nil,

  -- Re-maps `gx` to custom URL opener.
  ---@type boolean
  map_gx = nil,

  -- Callback functions.
  ---@type markview.config.preview.callbacks
  callbacks = {},

  -- Buffer filetypes where the plugin should attach.
  ---@type string[]
  filetypes = {},

  -- Buftypes that should be ignored(e.g. nofile).
  ---@type string[]
  ignore_buftypes = {},

  ignore_previews = {},

  -- Debounce delay for updating previews.
  ---@type integer
  debounce = nil,

  -- Icon provider.
  -- "": Disable icons.
  -- "internal": Internal icon provider.
  -- "devicons": `nvim-web-devicons` as icon provider.
  -- "mini": `mini.icons` as icon provider.
  -- nil: nil
  ---@type string | "" | "internal" | "devicons" | "mini" | nil
  icon_provider = nil,

  -- Maximum number of lines a buffer can have before switching to partial rendering.
  ---@type integer
  max_buf_lines = 100,

  -- Vim-modes where previews will be shown.
  ---@type string[]
  modes = {},

  -- Vim-modes where `hybrid mode` is enabled. Options that should/shouldn't be previewed in `hybrid_modes`.
  ---@type string[]
  hybrid_modes = {},

  -- Clear lines around the cursor in `hybrid mode`, instead of nodes.
  ---@type boolean
  linewise_hybrid_mode = nil,

  -- Lines above & below the cursor to show preview.
  ---@type [ integer, integer ]
  draw_range = {},

  -- Lines above & below the cursor to not preview in `hybrid mode`.
  ---@type [ integer, integer ]
  edit_range = {},

  -- Window options for the `splitview` window. See `:h nvim.open_win()`.
  ---@type table
  splitview_winopts = {},

  -- Enables `hybrid mode` when attaching to new buffers.
  ---@type boolean
  enable_hybrid_mode = true,
}

return preview

-- Condition to check if a buffer should be attached or not.
-- Overrides `preview.filetypes` & `preview.ignore_buftypes`.
-- If `nil` is returned, `preview.filetypes` & `preview.ignore_buftypes` are checked.
---@type fun(buffer: integer): boolean?

-- Options that will show up as raw in hybrid mode.
---@type markview.config.preview.raw
