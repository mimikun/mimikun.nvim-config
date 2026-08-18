local file_panel = {
  submit_review = {
    lhs = "<localleader>vs",
    desc = "submit review",
  },
  discard_review = {
    lhs = "<localleader>vd",
    desc = "discard review",
  },
  next_entry = {
    lhs = "j",
    desc = "move to next changed file",
  },
  prev_entry = {
    lhs = "k",
    desc = "move to previous changed file",
  },
  select_entry = {
    lhs = "<cr>",
    desc = "show selected changed file diffs",
  },
  refresh_files = {
    lhs = "R",
    desc = "refresh changed files panel",
  },
  focus_files = {
    lhs = "<localleader>e",
    desc = "move focus to changed file panel",
  },
  toggle_files = {
    lhs = "<localleader>b",
    desc = "hide/show changed files panel",
  },
  select_next_entry = {
    lhs = "]q",
    desc = "move to next changed file",
  },
  select_prev_entry = {
    lhs = "[q",
    desc = "move to previous changed file",
  },
  select_first_entry = {
    lhs = "[Q",
    desc = "move to first changed file",
  },
  select_last_entry = {
    lhs = "]Q",
    desc = "move to last changed file",
  },
  select_next_unviewed_entry = {
    lhs = "]u",
    desc = "move to next unviewed file",
  },
  select_prev_unviewed_entry = {
    lhs = "[u",
    desc = "move to previous unviewed file",
  },
  close_review_tab = {
    lhs = "<C-c>",
    desc = "close review tab",
  },
  toggle_viewed = {
    lhs = "<localleader><space>",
    desc = "toggle viewer viewed state",
  },
  review_commits = {
    lhs = "<localleader>C",
    desc = "review PR commits",
  },
}

return file_panel
