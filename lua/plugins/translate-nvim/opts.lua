---@type table
local opts = {
  default = {
    parse_before = "trim,natural",
    command = "google",
    parse_after = "head",
    output = "floating",
  },
  preset = {
    parse_after = {
      window = {
        width = 0.8,
      },
    },
    output = {
      split = {
        append = true,
      },
    },
  },
}

return opts
