---@type KikaoDefaultConfig
local opts = {
  -- Checks for the existence of the project root by checking for these directories
  -- If none are found, the session won't be loaded or saved
  -- List of directory names to identify the project root
  ---@type string[]
  project_dir_matchers = {
    ".git",
    ".svn",
    ".jj",
    ".hg",
  },

  -- The path to the session file
  -- If not provided, the session file will be stored in:
  -- ~/.cache/nvim/kikao.nvim/{{SHA256_PROJECT_DIR}}/session.vim
  --
  -- If you want to store the session file in the project root,
  -- you can set this to "{{PROJECT_DIR}}/.session.vim"
  -- Custom session file path, supports {{PROJECT_DIR}} placeholder
  ---@type string | nil
  session_file_path = nil,

  -- The name of the session file
  -- Name of the session file to save/load
  ---@type string
  session_file_name = "session.vim",

  -- Don't start or restore a session if the file is in the deny_on_path list
  -- and you opened that file directly
  -- checkign via str:match on bufname
  -- List of path patterns to deny session restoration
  ---@type string[]
  deny_on_path = {
    ".git/COMMIT_EDITMSG",
    ".git/rebase-merge/git-rebase-todo",
    "NeovimTree_",
    "fugitive://",
    "git://",
    "term://",
    "toggleterm://",
    "dap-repl://",
    "dapui://",
    "kulala://",
    "NeogitStatus",
  },
}

return opts
