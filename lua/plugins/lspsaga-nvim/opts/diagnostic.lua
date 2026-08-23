local diagnostic = {
  show_layout = "float",
  show_normal_height = 10,
  jump_num_shortcut = true,
  auto_preview = false,
  max_width = 0.8,
  max_height = 0.6,
  max_show_width = 0.9,
  max_show_height = 0.6,
  wrap_long_lines = true,
  extend_relatedInformation = false,
  diagnostic_only_current = false,
  keys = {
    exec_action = "o",
    quit = "q",
    toggle_or_jump = "<CR>",
    quit_in_show = {
      "q",
      "<ESC>",
    },
  },
}

return diagnostic
