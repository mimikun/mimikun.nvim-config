---@type BafaUserConfigUi | nil
local ui = {
  -- 🪄 Rendering configuration
  ---@type BafaUserConfigUiRender | nil
  render = {
    -- Custom buffer line format function, default is nil.
    -- The function receives a BafaUiBufferLine as argument and should return a string to be displayed in the UI.
    ---@type fun(buffer_line: BafaUiBufferLine): string|nil|nil
    custom_format_buffer_line = nil,
  },

  -- 🧭 Buffer ordering configuration
  ---@type BafaUserConfigUiSort | nil
  sort = {
    -- Buffer ordering strategy
    -- "default": Buffers are ordered by last usage time
    -- "last_used": Buffers are ordered by their buffer number
    -- "manual": Buffers are ordered manually by the user
    ---@type string | BafaSorting | nil | "last_used" | "manual" | "default"
    method = "default",

    -- Only applicable when `method` is "default" or "last_used"
    -- When true, instead of focusing the current buffer, the previously used buffer will be focused when opening the UI
    ---@type boolean | nil
    focus_alternate_buffer = false,
  },

  -- 🦘 Jump-labels configuration
  ---@type BafaUserConfigUiJumpLabels | nil
  jump_labels = {
    -- Keys to use for jump-labels in order of preference
    -- Should be unique characters
    -- Duplicates will be ignored
    -- require('bafa.utils.keys').protected_jump_label_keys are also protected and will be ignored
    -- You can customize this to your keyboard layout will also use uppercase variants of these keys if the lower-case ones are exhausted
    -- This should give us roughly 46 unique keys (minus the protected ones)
    -- That should be enough for most use-cases but when we run out of keys, only the first buffers (in order, from top to bottom) will get jump-labels assigned
    ---@type string[] | nil
    keys = {
      "a",
      "s",
      "d",
      "f",
      "j",
      "k",
      "l",
      ";",
      "q",
      "w",
      "e",
      "r",
      "u",
      "i",
      "o",
      "p",
      "z",
      "x",
      "c",
      "n",
      "m",
      ",",
      ".",
    },
  },

  -- 🚨 Show diagnostics in the UI
  ---@type boolean | nil
  diagnostics = true,

  -- 📄 Show line numbers in the UI
  ---@type boolean | nil
  line_numbers = false,

  -- 👀 Title configuration
  ---@type BafaUserConfigUiTitle | nil
  title = {
    -- Title of the floating window
    ---@type string | nil
    text = "🦥",

    -- Position of the title
    ---@type string | BafaConfigUiTitlePos | nil | "center" | "left" | "right"
    pos = "center",
  },

  -- 🎨 Floating window border configuration
  ---@type string | BafaConfigUiBorder | nil | "none" | "single" | "double" | "rounded" | "solid" | "shadow"
  border = "rounded",

  -- 🎨 Floating window style configuration
  ---@type string | BafaConfigUiStyle | nil | "minimal" | "classic" | "minimal_inset"
  style = "minimal",

  -- 📏 Floating window alignment configuration
  ---@type BafaUserConfigUiPosition | nil
  position = {
    -- Window position preset:
    ---@type string | BafaConfigWindowPosition | nil | "center" | "top-center" | "bottom-center" | "top-left" | "top-right" | "bottom-left" | "bottom-right" | "center-left" | "center-right"
    preset = "center",

    -- Custom row position (overrides preset if set)
    -- also supports a function that returns a number
    ---@type number | nil
    row = nil,

    -- Custom column position (overrides preset if set)
    -- also supports a function that returns a number
    ---@type number | nil
    col = nil,
  },

  -- 💄 Icons configuration
  icons = {
    -- 🚨 Diagnostics icons configuration
    ---@type BafaConfigIconsDiagnostics
    diagnostics = {
      -- Icon for error diagnostics
      ---@type string
      Error = "",

      -- Icon for warning diagnostics
      ---@type string
      Warn = "",

      -- Icon for info diagnostics
      ---@type string
      Info = "",

      -- Icon for hint diagnostics
      ---@type string
      Hint = "",
    },

    -- 🖊️ Buffer changes sign configuration
    ---@type BafaConfigIconsSign
    sign = {
      -- Sign character for modified/deleted buffers
      ---@type string
      changes = "┃",
    },
  },

  -- 🎨 Highlight groups configuration
  ---@type BafaUserConfigHl | nil
  hl = {
    -- 🖊️ Buffer changes sign highlight groups configuration
    ---@type BafaConfigHlSign
    sign = {
      -- Highlight group for modified buffer signs (fallback: DiffChange)
      ---@type string
      modified = "GitSignsChange",

      -- Highlight group for deleted buffer signs (fallback: DiffDelete)
      ---@type string
      deleted = "GitSignsDelete",
    },
  },
}

return ui
