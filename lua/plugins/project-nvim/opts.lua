---@type table
local opts = {
  ---@type nil|fun(target_dir: string, method: string)
  before_attach = nil,
  ---@type nil|fun(target_dir: string, method: string)
  on_attach = nil,
  lsp = {
    enabled = true,
    ignore = {},
    use_pattern_matching = false,
    -- WARNING: ENABLE AT YOUR OWN DISCRETION!!!!
    no_fallback = false,
  },
  manual_mode = false,
  patterns = {
    ".git",
    ".github",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Pipfile",
    "pyproject.toml",
    ".pre-commit-config.yaml",
    ".pre-commit-config.yml",
    ".csproj",
    ".sln",
    ".nvim.lua",
    ".neoconf.json",
    "neoconf.json",
  },
  different_owners = {
    -- Allow adding projects with a different owner to the project session
    allow = false,
    -- Notify the user when a project with a different owner is found
    notify = true,
  },
  enable_autochdir = false,
  show_hidden = false,
  exclude_dirs = {},
  silent_chdir = true,
  ---@type "global" | "tab" | "win"
  scope_chdir = "global",
  history = {
    save_dir = vim.fn.stdpath("data"),
    save_file = "project_history.json",
    size = 100,
  },
  log = {
    enabled = false,
    max_size = 1.1,
    logpath = vim.fn.stdpath("state"),
  },
  snacks = {
    enabled = false,
    opts = {
      hidden = false,
      -- icon = {},
      layout = "select",
      -- path_icons = {},
      ---@type "paths" | "names"
      show = "paths",
      ---@type "newest" | "oldest"
      sort = "newest",
      title = "Select Project",
    },
  },
  fzf_lua = {
    enabled = false,
    ---@type "paths" | "names"
    show = "paths",
    ---@type "newest" | "oldest"
    sort = "newest",
  },
  picker = {
    enabled = false,
    -- Show hidden files
    hidden = false,
    ---@type "paths" | "names"
    show = "paths",
    ---@type "newest" | "oldest"
    sort = "newest",
  },
  disable_on = {
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
    bt = {
      "help",
      "nofile",
      "nowrite",
      "terminal",
    },
  },
  telescope = {
    disable_file_picker = false,
    mappings = {
      n = {
        R = "rename_project",
        b = "browse_project_files",
        d = "delete_project",
        f = "find_project_files",
        r = "recent_project_files",
        s = "search_in_project_files",
        w = "change_working_directory",
      },
      i = {
        ["<C-b>"] = "browse_project_files",
        ["<C-d>"] = "delete_project",
        ["<C-f>"] = "find_project_files",
        ["<C-n>"] = "rename_project",
        ["<C-r>"] = "recent_project_files",
        ["<C-s>"] = "search_in_project_files",
        ["<C-w>"] = "change_working_directory",
      },
    },
    prefer_file_browser = false,
    ---@type "newest" | "oldest"
    sort = "newest",
  },
}

return opts
