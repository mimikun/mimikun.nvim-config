local review_thread = {
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
  add_suggestion = {
    lhs = "<localleader>sa",
    desc = "add suggestion",
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
  resolve_thread = {
    lhs = "<localleader>rt",
    desc = "resolve PR thread",
  },
  unresolve_thread = {
    lhs = "<localleader>rT",
    desc = "unresolve PR thread",
  },
}

return review_thread
