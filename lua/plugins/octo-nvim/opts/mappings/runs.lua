local runs = {
  expand_step = {
    lhs = "o",
    desc = "expand workflow step",
  },
  next_step = {
    lhs = "]s",
    desc = "next workflow step",
  },
  prev_step = {
    lhs = "[s",
    desc = "previous workflow step",
  },
  next_job = {
    lhs = "]j",
    desc = "next workflow job",
  },
  prev_job = {
    lhs = "[j",
    desc = "previous workflow job",
  },
  open_in_browser = {
    lhs = "<C-b>",
    desc = "open workflow run in browser",
  },
  refresh = {
    lhs = "<C-r>",
    desc = "refresh workflow",
  },
  rerun = {
    lhs = "<C-o>",
    desc = "rerun workflow",
  },
  rerun_failed = {
    lhs = "<C-f>",
    desc = "rerun failed workflow",
  },
  cancel = {
    lhs = "<C-x>",
    desc = "cancel workflow",
  },
  copy_url = {
    lhs = "<C-y>",
    desc = "copy url to system clipboard",
  },
}

return runs
