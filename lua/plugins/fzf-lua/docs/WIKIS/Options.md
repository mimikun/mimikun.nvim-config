- [Files Provider Options](#file-options)
- [Grep Providers Options](#grep-options)
- [Buffer Providers Options](#buffer-options)

## Provider Options

Most of these options are also described in the help files. So please check them out as well.

These options can be set in the setup of the plugin, but can only be set on direct calls to the providers.
```lua
require'fzf-lua'.setup {
    ...           -- default settings for all function calls
}
-- or specific setting for a single function call
require'fzf-lua'.files { prompt = "Search files > " }
```


### <a id="file-options">Files Provider Options</a>

The below are additional options relevant to the `files` type provider.

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
`previewer` | `string` | `"builtin"`| name from 'previewers' table    
`prompt` | `string` | `"Files❯ "` | Prompt in Fzf window
`multiprocess` | `string` | `true` | run command in a separate process
`git_icons` | `string` | `true` | show git icons?
`file_icons` | `string` | `true` | show file icons?
`color_icons` | `string` | `true` | colorize file|git icons
`path_shorten` | `string` \| `number` | `nil` | 'true' or number, shorten path?
`cmd` | `string` | `nil` | executed command priority is 'cmd' (if exists) otherwise auto-detect prioritizes `fd`:`rg`:`find` default options are controlled by 'fd|rg|find|_opts' NOTE: 'find -printf' requires GNU find
`find_opts` | `string` | `"-type f -not -path '*/\.git/*' -printf '%P\n'"` | options when using find
`rg_opts` | `string` | `"--color=never --files --hidden --follow -g '!.git'"`| options when using ripgrep
`fd_opts` | `string` | `"--color=never --type f --hidden --follow --exclude .git"`| options when using fd
`cwd_header` | `string` | `nil` | by default, cwd appears in the header only if {opts} contain a cwd parameter to a different folder than the current working directory uncomment if you wish to force display of the cwd as part of the query prompt string (fzf.vim style), header line or both
`cwd_prompt` | `string` | `true` | 
`cwd_prompt_shorten_len` | `string` | 32 | shorten prompt beyond this length
`cwd_prompt_shorten_val` | `string` | 1 | shortened path parts length



### <a id="grep-options">Grep Providers Options</a>

The below are additional options relevant to grep type providers, `live_grep`, `grep`, etc.

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
`prompt` | `string` | `"Rg❯ "`| Prompt in Fzf window
`input_prompt` | `string` | `"Grep For❯ "`| Prompt when using 'grep'
`search` | `string` |`nil`| Default search string (skips prompt with grep).
`multiprocess` | `bool` | `true` | run command in a separate process
`git_icons` | `bool` | `true` | show git icons?
`file_icons` | `bool` | `true` | show file icons?
`color_icons` | `bool` | `true` | colorize file|git icons
`grep_opts` | `string` | `"--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e"`| options for vimgrep
`rg_opts` | `string` | `"--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e"`| options for ripgrep
`rg_glob` | `bool` | `false` | default to glob parsing?
`glob_flag` | `string` | `"--iglob"`| for case sensitive globs use "--glob"
`glob_separator` | `string` | `"%s%-%-"`| query separator pattern (lua): " --"


### <a id="buffer-options">Buffer Providers Options</a>

The below applies to buffer type providers, `tabs`, `buffers`, `lines` and `blines`
| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
`color_icons`|`bool`|`true`|Use color for icons.
`cwd_only`|`bool`|`false`|Only include buffers from the current working directory.
`cwd`|`string` \| `nil`|`nil`|Only include buffers from the specified working directory.
`current_tab_only`|`bool`|`false`|Only include buffers from the current tab.
`file_icons`|`bool`|`true`|Show file icons.
`file_name_only`|`bool`|`false`|Only show the filename without the path.
`fzf_opts`|`table`|`{ ["--tiebreak"] = "index" }`| Options to pass to fzf
`ignore_current_buffer`|`bool`|`false`|Exclude the currently active buffer.
`no_term_buffers`|`bool`|`false`|Exclude terminal buffers.
`path_shorten`|`bool` \| `number`|`false`|Shorten the directory names in the file path
`show_quickfix`|`bool`|`false`|Include the quickfix buffer.
`show_unlisted`|`bool`|`false`|Include unlisted buffers (e.g. 'help' buffers).
`show_unloaded`|`bool`|`true`|Include unloaded buffers.
`sort_lastused`|`bool`|`true`|Sort the buffers by their last use.


Below is an example usage of some of the above:

```lua
require'fzf-lua'.setup {
    files = {
        cwd = '~/.config',    -- Show files from this directory
        ...
    },
    buffers = {
        ignore_current_buffer    = true,         -- Don't show the active buffer
        show_unloaded            = true,         -- show unloaded buffers
        cwd_only                 = false,        -- buffers for the cwd only
        cwd                      = nil,          -- buffers list for a given dir
        ...
    },
    blines = {
        no_term_buffers   = false,    -- include 'term' buffers
        ...
    },
    tabs = {
        show_unlisted     = true,     -- Show unlisted buffers
        current_tab_only  = true,     -- Only show buffers from current tab
        ...
    },
}
```
