local snacks = {
  -- Enable snacks.nvim picker integration
  enabled = false,

  -- Snacks project picker options
  opts = {
    -- Show hidden files
    hidden = false,

    --icon = {},

    layout = "select",

    --path_icons = {},

    --prompt = "Select Project: ",

    -- Show project entries either by their path (`'paths'`) or their custom name (`'names'`)
    ---@type 'paths'|'names'
    show = "paths",

    -- Sort directories by the newest or oldest
    ---@type 'newest'|'oldest'
    sort = "newest",

    -- Snacks picker title prompt
    title = "Select Project",
  },
  --tilde = false,
}

return snacks
