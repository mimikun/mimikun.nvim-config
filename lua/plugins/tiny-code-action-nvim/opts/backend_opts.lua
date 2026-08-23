local backend_opts = {
  delta = {
    -- Header from delta can be quite large.
    -- You can remove them by setting this to the number of lines to remove
    header_lines_to_remove = 4,

    -- The arguments to pass to delta
    args = {
      "--line-numbers",
      -- If you have a custom configuration file, you can set the path to it like so:
      --"--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
    },
  },

  difftastic = {
    header_lines_to_remove = 1,

    -- The arguments to pass to difftastic
    args = {
      "--color=always",
      "--display=inline",
      "--syntax-highlight=on",
    },
  },

  diffsofancy = {
    header_lines_to_remove = 4,
  },
}

return backend_opts
