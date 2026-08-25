--- Experimental options.
---@type markview.config.experimental
local experimental = {
  -- When `true`, enables preview on **all buffers** with an active `tree-sitter parser`.
  ---@type boolean
  fancy_comments = nil,

  -- List of lua patterns for detecting date in YAML.
  ---@type string[]
  date_formats = {
    -- YYYY-MM-DD
    "^%d%d%d%d%-%d%d%-%d%d$",

    -- DD-MM-YYYY, MM-DD-YYYY
    "^%d%d%-%d%d%-%d%d%d%d$",

    -- DD-MM-YY, MM-DD-YY, YY-MM-DD
    "^%d%d%-%d%d%-%d%d$",

    -- YYYY/MM/DD
    "^%d%d%d%d%/%d%d%/%d%d$",

    -- DD/MM/YYYY, MM/DD/YYYY
    "^%d%d%/%d%d%/%d%d%d%d$",

    -- YYYY.MM.DD
    "^%d%d%d%d%.%d%d%.%d%d$",

    -- DD.MM.YYYY, MM.DD.YYYY
    "^%d%d%.%d%d%.%d%d%d%d$",

    -- DD Month YYYY
    "^%d%d %a+ %d%d%d%d$",

    -- Month DD, YYYY
    "^%a+ %d%d %d%d%d%d$",

    -- YYYY Month DD
    "^%d%d%d%d %a+ %d%d$",

    -- Day, Month DD, YYYY
    "^%a+%, %a+ %d%d%, %d%d%d%d$",
  },

  -- List of lua patterns for detecting date & time in YAML.
  ---@type string[]
  date_time_formats = {
    -- UNIX date time
    "^%a%a%a %a%a%a %d%d %d%d%:%d%d%:%d%d ... %d%d%d%d$",

    -- ISO 8601
    "^%d%d%d%d%-%d%d%-%d%dT%d%d%:%d%d%:%d%dZ$",
  },

  -- Command used to open files inside Neovim.
  ---@type string
  file_open_command = nil,

  -- Maximum number of empty lines that can stay between text of a list item.
  ---@type integer
  list_empty_line_tolerance = 3,

  -- Opens text file inside Neovim.
  ---@type boolean
  prefer_nvim = nil,

  -- Number of `bytes` to check before opening a link. Used for detecting when to open files inside Neovim.
  ---@type integer
  read_chunk_size = 1024,
}

return experimental
