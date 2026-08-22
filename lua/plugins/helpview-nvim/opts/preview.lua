-- Preview options
---@type helpview.preview
local preview = {
  -- When `true`, newly attached buffers --- show preview.
  ---@type boolean
  enable = true,

  -- When `true`, hybrid mode is enabled on newly attached buffers.
  ---@type boolean
  enable_hybrid_mode = true,

  -- Modes where previews are shown.
  ---@type string[]
  modes = {
    "n",
    "c",
    "no",
  },

  -- Modes where hybrid mode is used.
  ---@type string[]
  hybrid_modes = {
    --it
  },

  -- Enables linewise-hybrid mode.
  ---@type boolean
  linewise_hybrid_mode = false,

  -- List of filetypes to enable preview for.
  ---@type string[]
  filetypes = {
    "help",
  },

  -- Items that won't be affected by `hybrid mode`.
  ---@type preview.ignore
  ignore_previews = {
    ---@type ignore_vimdoc[]
    --"arguments"
    --"code_blocks"
    --"headings"
    --"highlight_groups"
    --"horizontal_rules"
    --"inline_codes"
    --"keycodes"
    --"modelines"
    --"notes"
    --"optionlinks"
    --"tags"
    --"taglinks"
    --"urls"
    --"!arguments"

    -- Hybrid mode will no longer affect code blocks.
    "!code_blocks",

    --"!headings"
    --"!highlight_groups"
    --"!horizontal_rules"
    --"!inline_codes"
    --"!keycodes"
    --"!modelines"
    --"!notes"
    --"!optionlinks"
    --"!tags"
    --"!taglinks"
    --"!urls"
  },

  -- List of 'buftype' to ignore.
  ---@type string[]
  ignore_buftypes = {
    --it
  },

  -- Additional condition for attaching to new buffers.
  ---@type fun(buffer: integer): boolean
  condition = function(buffer)
    local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt

    --- Only attaches to any kind of help files and `nofile` buffers(for the other filetypes).
    if ft == "help" then
      return true
    elseif bt ~= "nofile" then
      return true
    else
      return false
    end
  end,
  --condition = nil,

  -- Maximum number of lines a buffer can have for it to be rendered entirely.
  ---@type integer
  max_buf_lines = 1000,

  -- Number of lines above & below the cursor to parse and draw.
  ---@type [ integer, integer ]
  draw_range = {
    2 * vim.o.lines,
    2 * vim.o.lines,
  },

  -- Number of lines above & below the cursor that will be affected by `hybrid mode.
  ---@type [ integer, integer ]
  edit_range = {
    0,
    0,
  },

  -- Debounce delay for updating previews.
  ---@type integer
  debounce = 150,

  -- Callback functions.
  ---@type { [string]: function }
  callbacks = {
    --it
  },

  -- Icon provider for code blocks.
  -- "internal": Internal icon provider.
  -- "devicons": `nvim-web-devicons` as icon provider.
  -- "mini": `mini.icons` as icon provider.
  ---@type string | "internal" | "mini" | "devicons"
  icon_provider = "devicons",

  -- Window options for the splitview window.
  ---@type table.
  splitview_winopts = {
    split = "right",
  },

  -- Window options for the overlay window in `:Help`.
  ---@type table.
  preview_winopts = {
    width = math.floor(80),
  },

  ---@type table.
  overlay_winopts = {
    --it
  },
}

return preview
