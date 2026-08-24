---@type ProjectConfigDefaults
local opts = {
  -- Runs before right before changing the project directory
  ---@type nil | fun(target_dir: string, method: string, bufnr?: integer)
  before_attach = function(_target_dir, _method, _bufnr)
    return nil
  end,

  ---@param dir string
  ---@param method string
  ---@param bufnr? integer
  ---@param map
  --- | fun(mode_or_maps: "n" | "i" | "v" | "V" | "t" | "o" | "x", lhs: string, rhs: string | function, opts: vim.keymap.set.Opts)
  --- | fun(mode_or_maps: table<"n" | "i" | "v" | "V" | "t" | "o" | "x", { [1]: string, [2]: string | function, [3]: vim.keymap.set.Opts }[]>)
  on_attach = function(_dir, _method, _bufnr, map)
    -- You can map a single key (ALWAYS BUFFER LOCAL AUTOMATICALLY):
    map("n", "<leader>pS", function()
      vim.cmd.Project("session")
    end, {
      desc = "Project Session",
    })

    -- Or multiple keys, in multiple modes (ALWAYS BUFFER LOCAL AUTOMATICALLY):
    map({
      -- Normal mode
      n = {
        ["<leader>pR"] = {
          function()
            vim.cmd.Project("recents")
          end,
          {
            desc = "Recent Projects",
          },
        },
        ["<leader>pS"] = {
          function()
            vim.cmd.Project("session")
          end,
          {
            desc = "Project Session",
          },
        },
      },

      -- Insert mode
      i = {
        ["<A-p>"] = {
          ":Project<CR>",
          {
            desc = "Project UI",
          },
        },
      },
    })
  end,

  lsp = require("plugins.project-nvim.opts.lsp"),

  -- Read the `Custom Projects` section below
  custom_projects = require("plugins.project-nvim.opts.custom_projects"),

  -- If enabled, projects will ONLY change manually
  manual_mode = false,

  -- Files and directories to look for to detect a root directory.
  -- These patterns will not affect LSP-based detection unless `lsp.use_pattern_matching` is set to `true`
  -- This list is permanent, and any new entries are appended. You can leave this empty
  patterns = require("plugins.project-nvim.opts.patterns"),

  different_owners = require("plugins.project-nvim.opts.different_owners"),

  -- Set this to `true` if you prefer having `vim.o.autochdir` set to `true`
  enable_autochdir = false,

  -- Show projects by their name instead of their full path
  show_by_name = false,

  -- Show hidden files (global)
  show_hidden = false,

  -- Add any directory to exclude (absolute path). Keep in mind that this is recursive
  exclude_dirs = require("plugins.project-nvim.opts.exclude_dirs"),

  -- If disabled, you"ll be notified each time the project root directory is changed
  silent_chdir = true,

  -- Whether the CWD is changed globally (`"global"`), per-tab (`"tab"`) or per-window (`"win"`)
  ---@type string | "global" | "tab" | "win"
  scope_chdir = "global",

  --remove_missing_dirs = true,

  history = require("plugins.project-nvim.opts.history"),

  log = require("plugins.project-nvim.opts.log"),

  snacks = require("plugins.project-nvim.opts.snacks"),

  fzf_lua = require("plugins.project-nvim.opts.fzf_lua"),

  picker = require("plugins.project-nvim.opts.picker"),

  disable_on = require("plugins.project-nvim.opts.disable_on"),

  telescope = require("plugins.project-nvim.opts.telescope"),
}

return opts
