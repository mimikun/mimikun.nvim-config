local telescope = {
  --behavior = "explore",

  -- Whether to disable the built-in Telescope file-picker
  disable_file_picker = false,

  -- Telescope picker mappings.
  -- The operations can be:
  --   - `rename_project`
  --   - `browse_project_files`
  --   - `delete_project`
  --   - `find_project_files`
  --   - `recent_project_files`
  --   - `search_in_project_files`
  --   - `change_cwd`
  mappings = {
    -- Normal mode
    n = {
      R = "rename_project",
      b = "browse_project_files",
      d = "delete_project",
      f = "find_project_files",
      r = "recent_project_files",
      s = "search_in_project_files",
      w = "change_cwd",
    },

    -- Insert mode
    i = {
      ["<C-b>"] = "browse_project_files",
      ["<C-d>"] = "delete_project",
      ["<C-f>"] = "find_project_files",
      ["<C-n>"] = "rename_project",
      ["<C-r>"] = "recent_project_files",
      ["<C-s>"] = "search_in_project_files",
      ["<C-w>"] = "change_cwd",
    },
  },

  -- Whether to use `telescope-file-browser.nvim` instead
  -- (if enabled, will set `disable_file_picker` to `false`)
  prefer_file_browser = false,

  --show = "paths",

  -- Sort directories by the newest or oldest
  ---@type 'oldest'|'newest'
  sort = "newest",

  -- If `true`, project paths like `'/home/foo/...'` will become `'~/...'`
  tilde = false,
}

return telescope
