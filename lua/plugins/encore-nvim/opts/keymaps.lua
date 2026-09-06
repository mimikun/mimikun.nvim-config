local keymaps = {
  history = {
    quit = {
      "<C-c>",
      "q",
    },
    replay = "<CR>",
    replay_range = "<CR>",
    delete = "dd",
    macro = "M",
    report = "r",
    help = "?",
  },
  report = {
    quit = {
      "<C-c>",
      "q",
    },
    toggle_scope = "<Tab>",
    export = "y",
    focus_next = ">",
    focus_prev = "<",
    help = "?",
  },
  help = {
    quit = {
      "<C-c>",
      "q",
    },
  },
}

return keymaps
