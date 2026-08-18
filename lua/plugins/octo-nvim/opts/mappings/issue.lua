local issue = {
  issue_options = {
    lhs = "<CR>",
    desc = "show issue options",
  },
  close_issue = {
    lhs = "<localleader>ic",
    desc = "close issue",
  },
  reopen_issue = {
    lhs = "<localleader>io",
    desc = "reopen issue",
  },
  list_issues = {
    lhs = "<localleader>il",
    desc = "list open issues on same repo",
  },
  reload = {
    lhs = "<C-r>",
    desc = "reload issue",
  },
  open_in_browser = {
    lhs = "<C-b>",
    desc = "open issue in browser",
  },
  copy_url = {
    lhs = "<C-y>",
    desc = "copy url to system clipboard",
  },
  add_assignee = {
    lhs = "<localleader>aa",
    desc = "add assignee",
  },
  remove_assignee = {
    lhs = "<localleader>ad",
    desc = "remove assignee",
  },
  create_label = {
    lhs = "<localleader>lc",
    desc = "create label",
  },
  add_label = {
    lhs = "<localleader>la",
    desc = "add label",
  },
  remove_label = {
    lhs = "<localleader>ld",
    desc = "remove label",
  },
  goto_issue = {
    lhs = "<localleader>gi",
    desc = "navigate to a local repo issue",
  },
  add_comment = {
    lhs = "<localleader>ca",
    desc = "add comment",
  },
  add_reply = {
    lhs = "<localleader>cr",
    desc = "add reply",
  },
  delete_comment = {
    lhs = "<localleader>cd",
    desc = "delete comment",
  },
  comment_edits = {
    lhs = "<localleader>ce",
    desc = "show comment edit history",
  },
  reference_in_new_issue = {
    lhs = "<localleader>ri",
    desc = "reference comment in new issue",
  },
  next_comment = {
    lhs = "]c",
    desc = "go to next comment",
  },
  prev_comment = {
    lhs = "[c",
    desc = "go to previous comment",
  },
  react_hooray = {
    lhs = "<localleader>rp",
    desc = "add/remove 🎉 reaction",
  },
  react_heart = {
    lhs = "<localleader>rh",
    desc = "add/remove ❤️ reaction",
  },
  react_eyes = {
    lhs = "<localleader>re",
    desc = "add/remove 👀 reaction",
  },
  react_thumbs_up = {
    lhs = "<localleader>r+",
    desc = "add/remove 👍 reaction",
  },
  react_thumbs_down = {
    lhs = "<localleader>r-",
    desc = "add/remove 👎 reaction",
  },
  react_rocket = {
    lhs = "<localleader>rr",
    desc = "add/remove 🚀 reaction",
  },
  react_laugh = {
    lhs = "<localleader>rl",
    desc = "add/remove 😄 reaction",
  },
  react_confused = {
    lhs = "<localleader>rc",
    desc = "add/remove 😕 reaction",
  },
}

return issue
