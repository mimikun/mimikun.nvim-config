---@type table
local timeline_icons = {
  auto_squash = "  ",
  blocking = "  ",
  commit_push = "  ",
  comment_deleted = "  ",
  duplicate = "  ",
  force_push = "  ",
  draft = "  ",
  ready = " ",
  commit = "  ",
  deployed = "  ",
  issue_type = "  ",
  label = "  ",
  reference = "  ",
  project = "  ",
  connected = "  ",
  subissue = "  ",
  cross_reference = "  ",
  transferred = "  ",
  parent_issue = "  ",
  head_ref = "  ",
  pinned = "  ",
  milestone = "  ",
  renamed = "  ",
  automatic_base_change_succeeded = "  ",
  base_ref_changed = "  ",
  merged = {
    "  ",
    "OctoPurple",
  },
  closed = {
    closed = {
      "  ",
      "OctoRed",
    },
    completed = {
      "  ",
      "OctoPurple",
    },
    not_planned = {
      "  ",
      "OctoWhite",
    },
    duplicate = {
      "  ",
      "OctoWhite",
    },
  },
  reopened = {
    "  ",
    "OctoGreen",
  },
  assigned = "  ",
  locked = "  ",
  merge_queue = "  ",
  review_requested = "  ",
}

return timeline_icons
