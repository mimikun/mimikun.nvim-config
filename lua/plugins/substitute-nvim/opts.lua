---@type table
local opts = {
  yank_substituted_text = false,
  preserve_cursor_position = false,
  highlight_substituted_text = {
    enabled = true,
    timer = 500,
  },
  range = {
    prefix = "s",
    prompt_current_text = false,
    confirm = false,
    complete_word = false,
    suffix = "",
    auto_apply = false,
    cursor_position = "end",
  },
  exchange = {
    motion = false,
    use_esc_to_cancel = true,
    preserve_cursor_position = false,
  },
}

return opts
