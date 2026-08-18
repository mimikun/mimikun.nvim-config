local pull_request = {
  pr_options = {
    lhs = "<CR>",
    desc = "show PR options",
  },
  checkout_pr = {
    lhs = "<localleader>po",
    desc = "checkout PR",
  },
  merge_pr = {
    lhs = "<localleader>pm",
    desc = "merge commit PR",
  },
  squash_and_merge_pr = {
    lhs = "<localleader>psm",
    desc = "squash and merge PR",
  },
  rebase_and_merge_pr = {
    lhs = "<localleader>prm",
    desc = "rebase and merge PR",
  },
  merge_pr_queue = {
    lhs = "<localleader>pq",
    desc = "merge commit PR and add to merge queue (Merge queue must be enabled in the repo)",
  },
  squash_and_merge_queue = {
    lhs = "<localleader>psq",
    desc = "squash and add to merge queue (Merge queue must be enabled in the repo)",
  },
  rebase_and_merge_queue = {
    lhs = "<localleader>prq",
    desc = "rebase and add to merge queue (Merge queue must be enabled in the repo)",
  },
  list_commits = {
    lhs = "<localleader>pc",
    desc = "list PR commits",
  },
  list_changed_files = {
    lhs = "<localleader>pf",
    desc = "list PR changed files",
  },
  show_pr_diff = {
    lhs = "<localleader>pd",
    desc = "show PR diff",
  },
  add_reviewer = {
    lhs = "<localleader>va",
    desc = "add reviewer",
  },
  remove_reviewer = {
    lhs = "<localleader>vd",
    desc = "remove reviewer request",
  },
  close_issue = {
    lhs = "<localleader>ic",
    desc = "close PR",
  },
  reopen_issue = {
    lhs = "<localleader>io",
    desc = "reopen PR",
  },
  list_issues = {
    lhs = "<localleader>il",
    desc = "list open issues on same repo",
  },
  reload = {
    lhs = "<C-r>",
    desc = "reload PR",
  },
  approve_pr = {
    lhs = "<leader>qa",
    desc = "approve PR",
  },
  open_in_browser = {
    lhs = "<C-b>",
    desc = "open PR in browser",
  },
  copy_url = {
    lhs = "<C-y>",
    desc = "copy url to system clipboard",
  },
  copy_sha = {
    lhs = "<C-e>",
    desc = "copy commit SHA to system clipboard",
  },
  goto_file = {
    lhs = "gf",
    desc = "go to file",
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
  review_start = {
    lhs = "<localleader>vs",
    desc = "start a review for the current PR",
  },
  review_resume = {
    lhs = "<localleader>vr",
    desc = "resume a pending review for the current PR",
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

return pull_request
