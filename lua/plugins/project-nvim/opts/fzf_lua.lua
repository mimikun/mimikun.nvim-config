local fzf_lua = {
  -- Enables fzf-lua picker integration
  enabled = false,

  -- Sort directories by the newest or oldest
  ---@type string | "newest" | "oldest"
  sort = "newest",

  -- Show project entries either by their path (`"paths"`) or their custom name (`"names"`)
  ---@type string | "paths" | "names"
  show = "paths",
}

return fzf_lua
