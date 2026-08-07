-- Keymaps
local keymaps = {
  -- Toggle global todos
  toggle_window = "<leader>td",

  -- Toggle project-specific todos
  open_project_todo = "<leader>tD",

  -- Show due items window
  show_due_notification = "<leader>tN",

  new_todo = "i",

  -- Create nested subtask under current todo
  create_nested_task = "<leader>tn",

  toggle_todo = "x",
  delete_todo = "d",
  delete_completed = "D",
  close_window = "q",
  undo_delete = "u",
  add_due_date = "H",
  remove_due_date = "r",
  toggle_help = "?",
  toggle_tags = "t",
  toggle_priority = "<Space>",
  clear_filter = "c",
  edit_todo = "e",
  edit_tag = "e",
  edit_priorities = "p",
  delete_tag = "d",
  search_todos = "/",
  add_time_estimation = "T",
  remove_time_estimation = "R",
  import_todos = "I",
  export_todos = "E",
  remove_duplicates = "<leader>D",
  open_todo_scratchpad = "<leader>p",
  refresh_todos = "f",
}

return keymaps
