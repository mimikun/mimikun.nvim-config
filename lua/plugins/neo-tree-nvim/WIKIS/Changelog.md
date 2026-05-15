This page will summarize the changes between versions, starting with 2.0.

# 3.0

This is the latest major version. It contains the following **Breaking Changes** since 2.x:

- Default icons now point to Nerd Fonts v3 symbols
- The original user commands have been removed:
  - `NeoTreeClose`
  - `NeoTreeFloat`
  - `NeoTreeFocus`
  - `NeoTreeShow`
  - `NeoTreeReveal`
  - `NeoTreeRevealInSplit`
  - `NeoTreeShowInSplit`
  - `NeoTreeFloatToggle`
  - `NeoTreeFocusToggle`
  - `NeoTreeShowToggle`
  - `NeoTreeRevealToggle`
  - `NeoTreeRevealInSplitToggle`
  - `NeoTreeShowInSplitToggle`
  - `NeoTreePasteConfig`
  - `NeoTreeSetLogLevel`
  - `NeoTreeLogs`
  - Please use the newer `Neotree` command instead
- Removed `close_floats_on_escape_key` option, replaced with `window.mappings` mapped to the `"cancel"` command


# 2.x

**NOTE: Starting with version [2.44](https://github.com/nvim-neo-tree/neo-tree.nvim/releases/tag/2.44), I will be using automatically generated release notes and will no longer be maintaining this page separately. Please go to the [Releases](https://github.com/nvim-neo-tree/neo-tree.nvim/releases) page to see the changelog going forward.**
## 2.43

### New Features

- Hide diagnostics and git_status when a directory is expanded (#573)
- Fix nvim-window-picker buftype rules in readme (#570)


### Bug Fixes

- Choose correct split direction when Neo-tree is only window, fixes #576 (#577)
- Use pcall correctly to fix 325 error, fixes #567
- Handle 325 error when using window picker, fixes #567
- Clickable filesystem source winbar component closes neo-tree immediately #565
- Plain match "%" in command line completion


## 2.42

### New Features

- Add `Preview.is_active()` function for use in custom events and commands

### Bug Fixes

- Fix path issue on Windows when browsing drive roots


## 2.41

### New Features

- Allow git commands to be used from all sources
- Add `never_show_by_pattern` option
- Ignore null-ls temp files in file watcher events


## 2.40

### Bug Fixes

- Fail gracefully when preview toggle attempted when position=current
- Fix for "preview window freezes when opening new folder"
- Fix regression on git status staged markers

### Other Changes

- Improve documentation for mappings


## 2.39

### New Features

- Set default mapping for preview mode
- Add `use_float` option for preview mode
- Do not notify log level when it is set
- Add diagnostic component config options to override symbols and highlights
- Add `"drop"` and `"tab_drop"` commands

### Bug Fixes

- Do not show staged icon when git status is unknown
- Fix pluralization in "hidden items" hints
- Set a better default for NC popup titlebar style


## 2.38

### New Features

- Soft release of "preview" mode commands, not yet complete or mapped by default.

### Bug Fixes

- Use `pcall` when closing window that might have been closed already, fixes `float toggle` commands
- Fire `"neo-tree-buffer-leave"` when switching to a different neo-tree window


## 2.37

### New Features

- Add path support to `hide_by_pattern`
- Add `right_padding` option to name component
- Consider signcol and linenr when right aligning symbols
- Add documentation for source selector

### Bug Fixes

- Specify git commands as lists instead of strings, fixes windows quoting problems


## 2.36

### New Features

- Add Neo-tree window before/after open/close events
- Restore focus to the last visited window when a focused Neo-tree window is closed

### Bug Fixes

- Only allow `delete` on files and directories


## 2.35

### New Features

- Allow setting `right_padding` on container in global config
- Make floating windows resize on VimResize event
- Add `always_show` option in `filesystem.filtered_items` config

### Bug Fixes

- Fix multiple memory leaks
- Do not check git ignored if not filtering them and git status is not enabled


## 2.34

### New Features

- add `prev_source` / `next_source` commands mapped to `<` / `>`
- new option `add_blank_line_at_top`

### Bug Fixes

- execute all git commands without shell
- handle directories with only hidden items
- remove a memory leak from fs_scan, there are still more leaks to find


## 2.33

### New Features

- Optional source selector tabs for winbar or statusline
- Support indent markers for messages (hidden items)

### Bug Fixes

- Do not hide root node of lazy loaded folder
- Ensure dialogs are within editor on gui clients


## 2.32

### New Features

- Enable opening at top and bottom positions
- Add `retain_hidden_root_indent` option


## 2.31

### Bug Fixes

- Remove extra space on right related to #408
- Remove indent from root node if it is hidden

### Other

- Support default configs from external sources


## 2.30

### New Features

- Add support for external sources

### Bug Fixes

- Fix for setting `use_got_status_colors = false` in global config
- Fix incorrect window_picker tag in README


## 2.29

### New Features

- Add `hide_root_node` option
- **Auto refresh on git status / branch changes!** Requires `use_libuv_file_watcher = true` 
- Make `*_with_window_picker` commands also invoke event handlers 
- Disable `signcolumn` in Neo-tree window by default 

### Bug Fixes

- Use `++nested` in WinEnter autocmd so that `close_if_last_window` raises `VimLeave` event
- Display git ignored items properly
- Fix double wide symbol clipping in some terminals 


## 2.28

### New Features

- Add options to change what cwd is bound to, see `:h neo-tree-cwd`
- Add `expand_all_nodes` command, not mapped by default
- Add `fuzzy_finder_directory` command, mapped to `D`
- Add `hide_root_node` option


## 2.27

### New Features

- Use terminal title as name in buffers list
- Support multiple filetypes per ext in nesting

### Bug Fixes

- Force disable colorcolumn in neo-tree windows
- Handle `reveal` flag in buffer and git status sources


## 2.26

### Bug Fixes

- Fix version check for WinSeparator highlight


## 2.25

### New Features:

- Show hidden count by default

### Bug Fixes:

- Don't use `WinSeparator` highlight group on Neovim version < 7.0
- Normalize user mappings at global level 


## 2.24

### New Features

- Support absolute and relative paths in `copy` and `move` commands
- Add config option for custom sorting

### Bug Fixes

- Support <c-w> mapping in input prompts
- Don't try to close the last window when *toggle commands are issued

### Other Changes

- Refactor event queue backing array into linked list


## 2.23

### Bug Fixes

- Remove extra messge on rename
- Make `focus_node` open folders to show node if needed, which fixes the `next_get_modified` command
- `use_default_mappings = false` now only affects mappings instead of all window options

## 2.22

### New Features

- Optimize git status processing for large repos
- Respect git's `status:showUntrackedFiles = no` option
- Use `vim.notify` for log messages
- Add `[g` `]g` mappings to jump to next/previous git modified file
- Add `NeoTreeGitStaged` and `NeoTreeGitUnstaged` highlight groups
- Force showing hidden file if it is the target of a "reveal" action

### Bug Fixes

- Ensure `buflisted` is set when opening files
- Prevent `Neotree current` windows from hijacking a Neotree sidebar
- Allow backticks in git status commit messages


## 2.21

### New Features

- add `enable_refresh_on_write` option to disable auto refresh

### Bug Fixes

- Fix "invalid buffer id" error introduced in the prior release

### Other Changes

- Refactored git status async code, it's possible the execution time can be altered by the change


## 2.20

### New Features

- Respond to Fugitive's "FugitiveChanged" autocmd to refresh git status as you issue Fugitive commands
- Open with window picker commands will now toggle directories like the normal open command
- Add "NeoTreeWinSeparator" highlight
- Show terminals in "buffers" source
- Add `group_empty_dirs` option, default to true for "buffers" and false for "filesystem"
- Improve efficiency of modified file markers [+]
- Cancel long running git status update when vim closes

### Bug Fixes

- Respect `bind_to_cwd = false` during refreshes
- Reduce unnecessary background refreshes with more precise event handling


## 2.19

### New Features

- Added options to display the number of hidden items in folders
- If the root folder has nothing but hidden items, that message will be displayed regardless of what that setting is

### Bug Fixes

- Adding a node ending with `/` once again creates a directory as it should (recent regression)
- Correctly handle `hijack_netrw_behavior = "disabled"`


## 2.18

### New Features

- Added help menu, shown with `?` by default
- Added ability to pass config to commands in mappings
- Added `config.show_path` option to `add` and `add_directory` commands, which can be one of:
  - "none", the default value
  - "absolute", shows full path of the folder you are adding a node to
  - "relative", shows the path relative to Neo-tree's current root 


## 2.17

### New Features

- Update file names of open buffers when a file or directory is renamed in the tree
- Auto focus newly created nodes
- Support visual selection for `delete`, `cut_to_clipboard`, and `copy_to_clipboard` commands

### Bug Fixes
- Support splitting a neo-tree window opened in "current" position, this now creates a new tree instead of letting the buffer be shown in two places.


## 2.16

### New Features

- Add commands to open splits with window picker

### Bug Fixes

- Prevent duplicate [No Name] buffers on netrw hijack


## 2.15

### New Features

- Add `enable_character_fade` option to `container` component
- Add support for hidden files on Windows
- Make `nowait` the default setting for the all mappings except for `<space>`
- Allow clearing default mappings with `use_default_mappings = false`

### Bug Fixes

- Skip git warnings when parsing status
- Reset faded highlights on color scheme change


## 2.14

### Bug Fixes

- Fix many path related issues on Windows, including:
  - git ignored
  - navigate up command
  - nested file issues
  - diagnostic icons for folders
- Fix refresh after adding file with open nested files


## 2.13

### New Features

- Add `NeoTreeSignColumn` highlight group
- Add `hide_by_pattern` option to `filesystem.filtered_items`

### Bug Fixes

- fix performance issues with check git ignored code
- fix error with delete directory action on Windows

### Other

- Fix possessive "its" on the README


## 2.12

### New Features

- Use native recursive delete for directories (`rm -Rf`)
- Optimize resize timer to lower cpu usage


## 2.11

### New Features

- Add `mapping_options` config to set `map-arguments` like `nowait`
- Add built-in "open_with_window_picker" command
- Make `async_directory_scan` option take three way choice: "always", "never", or "auto"

### Bug Fixes

- Fix git status logic to show conflicts correctly


## 2.10

### New Features

- Various tweaks and optimizations to improve speed
- Including reworked async filesystem scan
- and opening sync from user commands to get the fastest response time
- and reserving async loading for background refreshes


## 2.9

### New Features

- Refactor async directory scan to make it parallel
- Add an option to scan synchronously (which is usually faster): `filesystem = { async_directory_scan = false }`
- Support changing the git base for git status using `Neotree <gitref>` or `Neotree git_base=<gitref>`
- Add `NeoTreeEndOfBuffer` highlight group

### Bug Fixes

- Handle git ignored logic correctly for files that are both ignored and dotfiles


## 2.8

### New Features

- Add `resize_timer_interval` config option


## 2.7

### New Features

- Add highlight groups:
  - **NeoTreeStatusLine**:  StatusLine override in Neo-tree window.
  - **NeoTreeStatusLineNC**:  StatusLineNC override in Neo-tree window.
  - **NeoTreeVertSplit**: VertSplit override in Neo-tree window.

### Bug Fixes

- Update README Quickstart to move `filesystem` only mappings out of the global mapping config
- Fix the `navigate_up` and `set_root` commands on the `buffers` source


## 2.6

### New Features

- Add container component, which allows right aligning components and character fading for overflow
- Add "open_tab" command
- Add "modified" component to show which files have unsaved changes

### Bug Fixes

- Handle git-ignore properly for dot (hidden) files


## 2.5

### New Features

- Added `sort_case_insensitive` option
- Support variable `last_indent_marker` width
- Add new events for setting local options:
  - `"neo_tree_buffer_enter"`
  - `"neo_tree_buffer_leave"`
  - `"neo_tree_popup_buffer_enter"`
  - `"neo_tree_popup_buffer_leave"`

### Bug Fixes

- Suppress non-critical errors when opening file (e.g. E325)
- Add ++nested to DirChanged event
- Ignore git errors when checking ignored outside of a repo

## 2.4

### Bug Fixes

- Fix reveal_force_cwd when there is no change needed
- Fix global mapped commands missing from buffers, remove mappings that don't apply to git_status
- Fix "toggle_node" command to lazy load directories if needed
- Stop swallowing global mappings starting with default mapped keys with "nowait" option


## 2.3

### Bug Fixes

- Respect `enable_git_status` option
- Handle `dir` argument correctly in user command


## 2.2

### Bug Fixes

- Handle changing cwd correctly during reveal

### Other

- Fix typos in README
- Fix errors in help file related to copy/paste commands


## 2.1

### New Features

- Add `"toggle_node"` command, mapped to space. This toggles both nested files and directories
- The `"open"` command no longer expands nested files, it just opens them.
- Never hide nested files, since they are already hidden by being nested
- Add `"add_directory"` command, mapped to `A` by default


## 2.0

### Breaking Changes

* Changed Diagnostic sign lookup and highlights from old style "~~Lsp~~Diagnostic~~s~~Warn~~ing~~" to the new style "DiagnosticWarn"
* Changed default `copy_to_clipboard_copy` mapping from `c` to `y`


### Deprecations

* All `NeoTree*` commands have been deprecated, switch to the new `Neotree` command
* The `filesystem.filters` option has been deprecated, please use `filesystem.filtered_items` instead.
  * The `show_hidden` option has been deprecated, please use `hide_dotfiles` instead.
  * The `respect_gitignore` option has been deprecated, please use `hide_gitignored` instead.
* The position previously known as `"split"` has been renamed to `"current"`
  * The `filesystem.hijack_netrw_behavior="open_split"` option has been renamed to `"open_current"`.
  * The `window.position="split"` options has been changed to `window.position="current"`
  * `:NeoTreeShowInSplit` becomes `:Neotree show current`
* All lua methods in the `neo-tree` module for opening the tree have been deprecated, use the `:Neotree` command or `neo-tree.command.execute()` instead.
* `neo-tree.utils.table_copy` has been deprecated, use `vim.deepcopy` instead
* `neo-tree.utils.table_merge` has been deprecated, use `vim.tbl_deep_extend("force", base_table, override_table)` instead
* Other methods may have been deprecated, please check the source for the method(s) you are using.


### New Features

* Added file nesting feature, allows to group related files such as a `.ts` with it's compiled `.js`
* Added new `:Neotree` command which supersedes all of the prior commands with a single flexible cli style interface
* Added new git_status icons
* Allow `window` options, including mappings, to be defined at globally at the root level of the config
* Allow `renderers` to be defined globally at the root level of the config.
* `filesystem.find_args` can now be defined as a mapping of cmd = { args, to, pass }, to ensure the right format is used for the command available on your current system. The old style of a simple array is also acceptable.
* Improved `filesystem.filtered_items` config to clarify the options.
  * Added `hide_by_name` and `never_show` options to `filtered_items`
  * Added ability to toggle visibility of "filtered" items but show them in a different highlight group (grey by default)
* `NeoTreeDirectoryName` and `NeoTreeDirectoryIcon` highlight groups now link to `Directory` by default
* `"fuzzy_finder"` search will now auto select the first file in the search results.
