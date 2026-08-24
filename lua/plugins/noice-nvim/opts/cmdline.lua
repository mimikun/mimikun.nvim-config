local cmdline = {
  -- enables the Noice cmdline UI
  enabled = true,

  -- view for rendering the cmdline.
  -- Change to `cmdline` to get a classic cmdline at the bottom
  view = "cmdline_popup",

  -- global options for the cmdline.
  -- See section on views
  opts = {},

  ---@type table<string, CmdlineFormat>
  format = {
    -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
    -- view: (default is cmdline view)
    -- opts: any options passed to the view
    -- icon_hl_group: optional hl_group for the icon
    -- title: set to anything or empty string to hide
    cmdline = {
      pattern = "^:",
      icon = "",
      lang = "vim",
    },
    search_down = {
      kind = "search",
      pattern = "^/",
      icon = " ",
      lang = "regex",
    },
    search_up = {
      kind = "search",
      pattern = "^%?",
      icon = " ",
      lang = "regex",
    },
    filter = {
      pattern = "^:%s*!",
      icon = "$",
      lang = "bash",
    },
    lua = {
      pattern = {
        "^:%s*lua%s+",
        "^:%s*lua%s*=%s*",
        "^:%s*=%s*",
      },
      icon = "",
      lang = "lua",
    },
    help = {
      pattern = "^:%s*he?l?p?%s+",
      icon = "",
    },
    calculator = {
      pattern = "^=",
      icon = "",
      lang = "vimnormal",
    },
    input = {
      view = "cmdline_input",
      icon = "󰥻 ",
    },
  },
}

return cmdline
