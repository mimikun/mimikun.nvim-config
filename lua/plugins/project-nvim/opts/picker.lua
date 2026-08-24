local picker = {
  -- Enables picker.nvim picker integration
  enabled = false,

  -- Show hidden files
  hidden = false,

  -- Show project entries either by their path (`"paths"`) or their custom name (`"names"`)
  ---@type string | "paths" | "names"
  show = "paths",

  -- Sort directories by the newest or oldest
  ---@type string | "newest" | "oldest"
  sort = "newest",
}

return picker
