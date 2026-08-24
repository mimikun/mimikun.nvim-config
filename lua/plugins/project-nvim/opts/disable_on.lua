local disable_on = {
  -- The buftypes that this plugin should ignore.
  -- This list is permanent, and any new entries are appended.
  -- You can leave this empty
  bt = {
    "help",
    "nofile",
    "nowrite",
    "terminal",
  },

  -- The filetypes that this plugin should ignore.
  -- This list is permanent, and any new entries are appended.
  -- You can leave this empty
  ft = {
    "",
    "NvimTree",
    "TelescopePrompt",
    "TelescopeResults",
    "alpha",
    "checkhealth",
    "lazy",
    "log",
    "ministarter",
    "neo-tree",
    "notify",
    "nvim-pack",
    "packer",
    "qf",
  },
}

return disable_on
