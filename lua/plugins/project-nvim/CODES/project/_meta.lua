---@meta
---@diagnostic disable:unused-local

---@enum (key) Project.Telescope.ActionNames
local action_names = {
  browse_project_files = 1,
  change_working_directory = 1,
  delete_project = 1,
  find_project_files = 1,
  help_mappings = 1,
  recent_project_files = 1,
  rename_project = 1,
  search_in_project_files = 1,
}

---@enum (key) ProjectOpts.Show
local show = {
  names = 1,
  paths = 1,
}

---@enum (key) ProjectOpts.ScopeChdir
local scope_chdir = {
  global = 1,
  win = 1,
  tab = 1,
}

---@enum (key) ProjectOpts.Sort
local sort = {
  newest = 1,
  oldest = 1,
}

---@enum (key) CompleteTypes
local complete_types = {
  arglist = 1,
  breakpoint = 1,
  buffer = 1,
  color = 1,
  command = 1,
  compiler = 1,
  diff_buffer = 1,
  dir = 1,
  dir_in_path = 1,
  environment = 1,
  event = 1,
  expression = 1,
  file = 1,
  file_in_path = 1,
  filetype = 1,
  ["function"] = 1,
  help = 1,
  highlight = 1,
  history = 1,
  keymap = 1,
  locale = 1,
  lua = 1,
  mapclear = 1,
  mapping = 1,
  menu = 1,
  messages = 1,
  option = 1,
  packadd = 1,
  retab = 1,
  runtime = 1,
  scriptnames = 1,
  shellcmd = 1,
  shellcmdline = 1,
  sign = 1,
  syntax = 1,
  syntime = 1,
  tag = 1,
  tag_listfiles = 1,
  user = 1,
  var = 1,
}

---@enum (key) ProjectPaths
local project_paths = { ---@diagnostic disable-line:unused-local
  datapath = 1,
  historyfile = 1,
  projectpath = 1,
}

---@class ProjectHistoryEntry
---@field name string
---@field path string

---@class Project.HistoryWin
---@field bufnr integer
---@field tab integer
---@field win integer

---@class HistoryPath
---@field datapath string
---@field historyfile string
---@field projectpath string

---@alias CompletorFunc fun(lead: string, line: string, pos: integer): completions: string[]
---@alias Project.CMD
---|{ desc: string, name: string, bang: boolean, complete?: (CompletorFunc)|CompleteTypes, nargs?: string|integer }
---|fun(ctx?: vim.api.keyset.create_user_command.command_args)

---@class Project.Commands.Spec
---@field bang boolean|nil
---@field callback fun(ctx?: vim.api.keyset.create_user_command.command_args)
---@field complete nil|CompleteTypes|CompletorFunc
---@field desc string
---@field name string
---@field nargs string|integer|nil

---@class ProjectOpts.DisableOn
---@field ft? string[]
---@field bt? string[]

---@class ProjectDefaults.DisableOn: ProjectOpts.DisableOn
---@field ft string[]
---@field bt string[]

---@class Project.Telescope.Mappings
---Insert mode mappings.
---
---@field i? table<string, Project.Telescope.ActionNames>
---Normal mode mappings.
---
---@field n? table<string, Project.Telescope.ActionNames>

---@class Project.Telescope.DefaultMappings: Project.Telescope.Mappings
---@field i table<string, Project.Telescope.ActionNames>
---@field n table<string, Project.Telescope.ActionNames>

---Table of options used for control for detecting projects not owned by the current user.
--- ---
---@class ProjectOpts.DifferentOwners
---Determines whether a project will be added
---if its project root is owned by a different user.
---
---If `true`, it will add a project to the history even if its root
---is not owned by the current nvim `UID` **(UNIX only)**.
--- ---
---Default: `false`
--- ---
---@field allow? boolean
---If `true`, notify the user when a new project has a different UID **(UNIX only)**.
---
--- ---
---Default: `true`
--- ---
---@field notify? boolean

---@class ProjectDefaults.DifferentOwners: ProjectOpts.DifferentOwners
---@field allow boolean
---@field notify boolean

---Table of options used for history management.
--- ---
---@class ProjectOpts.History
---The directory in which `project.nvim` will store the project history.
---
---For more info, run `:lua vim.print(require('project').get_history_paths())`
--- ---
---Default: `vim.fn.stdpath('data')`
--- ---
---@field save_dir? string
---The history file name for `project.nvim`..
---
---If it doesn't end with `.json`, the file extension will be appended.
---
---If the string containes invalid chars (e.g. `/`, `\\`, `!`, `?`, etc.) an error will be raised,
--- ---
---Default: `'project_history.json'`
--- ---
---@field save_file? string
---The history file size. (by `@acristoffers`)
---
---This will indicate how many entries will be written to the history file.
---
---Set to `0` for no limit.
--- ---
---Default: `100`
--- ---
---@field size? integer

---@class ProjectDefaults.History: ProjectOpts.History
---@field save_dir string
---@field save_file string
---@field size integer

---Table of options used for the snacks picker.
--- ---
---@class ProjectOpts.Snacks
---Determines whether the `snacks.nvim` integration is enabled.
---
---If `snacks.nvim` is not installed, this won't make a difference.
--- ---
---Default: `false`
--- ---
---@field enabled? boolean
---@field opts? ProjectSnacksConfig
---@field show? ProjectOpts.Show

---@class ProjectDefaults.Snacks: ProjectOpts.Snacks
---@field enabled boolean
---@field opts ProjectSnacksConfig
---@field show ProjectOpts.Show

---Table of options used for the telescope picker.
--- ---
---@class ProjectOpts.Telescope
---Set this to `true` if you don't want the file picker to appear
---after you've selected a project.
---
---CREDITS: [UNKNOWN](https://github.com/ahmedkhalf/project.nvim/issues/157#issuecomment-2226419783)
--- ---
---Default: `false`
--- ---
---@field disable_file_picker? boolean
---Table of mappings for the Telescope picker.
---
---Only supports Normal and Insert modes.
--- ---
---Default: check the README
--- ---
---@field mappings? Project.Telescope.Mappings
---If you have `telescope-file-browser.nvim` installed, you can enable this
---so that the Telescope picker uses it instead of the `find_files` builtin.
---
---If `true`, use `telescope-file-browser.nvim` instead of builtins.
---In case it is not available, it'll fall back to `find_files`.
--- ---
---Default: `false`
--- ---
---@field prefer_file_browser? boolean
---Determines whether the newest projects come first in the
---telescope picker (`'newest'`), or the oldest (`'oldest'`).
--- ---
---Default: `'newest'`
--- ---
---@field sort? ProjectOpts.Sort

---@class ProjectDefaults.Telescope: ProjectOpts.Telescope
---@field disable_file_picker boolean
---@field mappings Project.Telescope.DefaultMappings
---@field prefer_file_browser boolean
---@field sort ProjectOpts.Sort

---Options for logging utility.
--- ---
---@class ProjectOpts.Logging
---If `true`, it enables logging in the same directory in which your
---history file is stored.
--- ---
---Default: `false`
--- ---
---@field enabled? boolean
---Path in which the log file will be saved.
--- ---
---Default: `vim.fn.stdpath('state')`
--- ---
---@field logpath? string
---The maximum logfile size in [Gibibytes](https://simple.wikipedia.org/wiki/Gibibyte) (GiB).
--- ---
---Default: `1.1`
--- ---
---@field max_size? number

---@class ProjectDefaults.Logging: ProjectOpts.Logging
---@field enabled boolean
---@field logpath string
---@field max_size number

---Table of options used for `picker.nvim` integration
--- ---
---@class ProjectOpts.Picker
---Determines whether the `picker.nvim` integration is enabled.
---
---If `picker.nvim` is not installed, this won't make a difference.
--- ---
---Default: `false`
--- ---
---@field enabled? boolean
---Determines whether the picker called after selecting a project
---should list hidden files aswell or not.
---
--- ---
---Default: `false`
--- ---
---@field hidden? boolean
---@field show? ProjectOpts.Show
---Determines whether the newest projects come first (`'newest'`),
---or the oldest (`'oldest'`).
--- ---
---Default: `'newest'`
--- ---
---@field sort? ProjectOpts.Sort

---@class ProjectDefaults.Picker: ProjectOpts.Picker
---@field enabled boolean
---@field hidden boolean
---@field show ProjectOpts.Show
---@field sort ProjectOpts.Sort

---Table of options used for `fzf-lua` integration
--- ---
---@class ProjectOpts.FzfLua
---Determines whether the `fzf-lua` integration is enabled.
---
---If `fzf-lua` is not installed, this won't make a difference.
--- ---
---Default: `false`
--- ---
---@field enabled? boolean
---@field show? ProjectOpts.Show
---Determines whether the newest projects come first (`'newest'`),
---or the oldest (`'oldest'`).
--- ---
---Default: `'newest'`
--- ---
---@field sort? ProjectOpts.Sort

---@class ProjectDefaults.FzfLua: ProjectOpts.FzfLua
---@field enabled boolean
---@field show ProjectOpts.Show
---@field sort ProjectOpts.Sort

---Table containing all the LSP-adjacent options.
--- ---
---@class ProjectOpts.LSP
---If `true` then LSP-based method detection
---will take precedence over traditional pattern matching.
---
---See |project-nvim.pattern-matching| for more info.
--- ---
---Default: `true`
--- ---
---@field enabled? boolean
---Table of lsp clients to ignore by name,
---e.g. `{ 'efm', ... }`.
---
---If you have `nvim-lspconfig` installed **see** `:h lspconfig-all`
---for a list of servers.
--- ---
---Default: `{}`
--- ---
---@field ignore? string[]
---If `true` then LSP-based method detection
---will not be compared with pattern-matching-based detection.
---
---**WARNING: USE AT YOUR OWN DISCRETION!**
--- ---
---Default: `false`
--- ---
---@field no_fallback? boolean
---Sets whether to use Pattern Matching rules to the LSP client.
---
---If `false` the Pattern Matching will only apply
---to normal pattern matching.
---
---If `true` the `patterns` setting will also filter
---your LSP's `root_dir`, assuming there is one
---and `lsp.enabled` is set to `true`.
--- ---
---Default: `false`
--- ---
---@field use_pattern_matching? boolean

---@class ProjectDefaults.LSP: ProjectOpts.LSP
---@field enabled boolean
---@field ignore string[]
---@field no_fallback boolean
---@field use_pattern_matching boolean

---The options available for in `require('project').setup()`.
--- ---
---@class ProjectOpts
---Hook to run before attaching to a new project.
---
---It recieves `target_dir` and, optionally,
---the `method` used to change directory.
---
---Set to `nil` to disable.
---
---CREDITS: @danilevy1212
--- ---
---Default: `nil`
--- ---
---@field before_attach? nil|fun(target_dir: string, method: string)
---Table of options used for control for detecting projects not owned by the current user.
--- ---
---@field different_owners? ProjectOpts.DifferentOwners
---Determines in what filetypes/buftypes the plugin won't execute.
---It's a table with two fields:
---
--- - `ft`: A string array of filetypes to exclude
--- - `bt`: A string array of buftypes to exclude
---
---CREDITS TO [@Zeioth](https://github.com/Zeioth)!:
---[`Zeioth/project.nvim`](https://github.com/Zeioth/project.nvim/commit/95f56b8454f3285b819340d7d769e67242d59b53)
--- ---
---The default value for this one can be found in the project's `README.md`.
--- ---
---@field disable_on? ProjectOpts.DisableOn
---Don't calculate root dir on specific directories,
---e.g. `{ '~/.cargo/*', ... }`.
---
---For more info see `:h project-nvim.pattern-matching`.
--- ---
---Default: `{}`
--- ---
---@field exclude_dirs? string[]
---If enabled, set `vim.o.autochdir` to `true`.
---
---This is disabled by default because the plugin implicitly disables `autochdir`.
--- ---
---Default: `false`
--- ---
---@field enable_autochdir? boolean
---Table of options used for the `fzf-lua` integration
--- ---
---@field fzf_lua? ProjectOpts.FzfLua
---@field history? ProjectOpts.History
---Options for logging utility.
--- ---
---@field log? ProjectOpts.Logging
---Table containing all the LSP-adjacent options.
--- ---
---@field lsp? ProjectOpts.LSP
---If `true` your root directory won't be changed automatically,
---so you have the option to manually do so
---using the `:ProjectRoot` command.
--- ---
---Default: `false`
--- ---
---@field manual_mode? boolean
---All the patterns used to detect the project's root directory.
---
---See `:h project.nvim-pattern-matching`.
--- ---
---Default: `{ '.git', '.github', '_darcs', '.hg', '.bzr', '.svn', 'Pipfile', ... }`
--- ---
---@field patterns? string[]
---Hook to run after attaching to a new project.
---**_This only runs if the directory changes successfully._**
---
---It recieves `dir` and, optionally,
---the `method` used to change directory.
---
---Set to `nil` to disable.
---
---CREDITS: @danilevy1212
--- ---
---Default: `nil`
--- ---
---@field on_attach? nil|fun(dir: string, method: string)
---Table of options used for the `picker.nvim` integration
--- ---
---@field picker? ProjectOpts.Picker
---Determines the scope for changing the directory.
---
---Valid options are:
--- - `'global'`: All your nvim `cwd` will sync to your current buffer's project
--- - `'tab'`: _Per-tab_ `cwd` sync to the current buffer's project
--- - `'win'`: _Per-window_ `cwd` sync to the current buffer's project
--- ---
---Default: `'global'`
--- ---
---@field scope_chdir? ProjectOpts.ScopeChdir
---Make hidden files visible when using any picker.
--- ---
---Default: `false`
--- ---
---@field show_hidden? boolean
---If `false`, you'll get a _notification_ every time
---`project.nvim` changes directory.
---
---This is useful for debugging, or for players that
---enjoy verbose operations.
--- ---
---Default: `true`
--- ---
---@field silent_chdir? boolean
---Table of options used for the `snacks.nvim` picker.
--- ---
---@field snacks? ProjectOpts.Snacks
---Table of options used for the telescope picker.
--- ---
---@field telescope? ProjectOpts.Telescope

---@class ProjectDefaults: ProjectOpts
---@field before_attach nil|fun(target_dir: string, method: string)
---@field different_owners ProjectDefaults.DifferentOwners
---@field disable_on ProjectDefaults.DisableOn
---@field enable_autochdir boolean
---@field exclude_dirs string[]
---@field expand_excluded fun(self: ProjectDefaults)
---@field fzf_lua ProjectDefaults.FzfLua
---@field gen_methods fun(self: ProjectDefaults): methods: { [1]: 'pattern' }|{ [1]: 'lsp', [2]: 'pattern' }
---@field history ProjectDefaults.History
---@field log ProjectDefaults.Logging
---@field lsp ProjectDefaults.LSP
---@field manual_mode boolean
---@field new fun(opts?: ProjectOpts): defaults: ProjectDefaults
---@field on_attach nil|fun(dir: string, method: string)
---@field patterns string[]
---@field picker ProjectDefaults.Picker
---@field scope_chdir ProjectOpts.ScopeChdir
---@field show_hidden boolean
---@field silent_chdir boolean
---@field snacks ProjectDefaults.Snacks
---@field telescope ProjectDefaults.Telescope
---@field verify fun(self: ProjectDefaults)
---@field verify_datapath fun(self: ProjectDefaults)
---@field verify_fzf_lua fun(self: ProjectDefaults)
---@field verify_history fun(self: ProjectDefaults)
---@field verify_lists fun(self: ProjectDefaults)
---@field verify_logging fun(self: ProjectDefaults)
---@field verify_lsp fun(self: ProjectDefaults)
---@field verify_owners fun(self: ProjectDefaults)
---@field verify_scope_chdir fun(self: ProjectDefaults)

---@class Project.ConfigLoc
---@field bufnr integer
---@field win integer

---@class Project.HistoryPath
---@field name string
---@field path string
---@field type string

---@class Project.Popup.SelectChoices
---@field choices fun(): choices_dict: table<string, fun(...?: any)>
---@field choices_list fun(exit?: boolean): choices: string[]

---@class Project.Popup.SelectSpec: Project.Popup.SelectChoices
---@field callback fun(ctx?: vim.api.keyset.create_user_command.command_args)

---Non-legacy validation spec (>=v0.11).
--- ---
---@class ValidateSpec
---@field [1] any
---@field [2] vim.validate.Validator
---@field [3]? boolean
---@field [4]? string

---@class Project.LogWin
---@field bufnr integer
---@field tab integer
---@field win integer

---@class ProjectSnacksConfig
---@field hidden? boolean
---@field icon? { icon: string, highlight: string }
---@field layout? 'default'|'select'|'vscode'
---@field path_icons? { match: string, icon: string, highlight: string }[]
---@field show? ProjectOpts.Show
---@field sort? ProjectOpts.Sort
---@field title? string

-- vim: set ts=2 sts=2 sw=2 et ai si sta:
