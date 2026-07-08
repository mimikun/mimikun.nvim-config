---@type table
local tasks = {
  include_skipped_in_total = false,
  statuses = {
    todo = {
      " ",
    },
    done = {
      "x",
      "X",
    },
    wip = {
      "/",
      "~",
      ">",
    },
    skipped = {
      "-",
    },
  },
}

return tasks
