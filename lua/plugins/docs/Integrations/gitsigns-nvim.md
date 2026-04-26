# Integrations

## lewis6991/gitsigns.nvim

### tpope/vim-fugitive

When viewing revisions of a file (via `:0Gclog` for example), Gitsigns will attach to the fugitive buffer with the base set to the commit immediately before the commit of that revision.
This means the signs placed in the buffer reflect the changes introduced by that revision of the file.

### folke/trouble.nvim

If installed and enabled (via `config.trouble`; defaults to true if installed), `:Gitsigns setqflist` or `:Gitsigns setloclist` will open Trouble instead of Neovim's built-in quickfix or location list windows.

### Any status-line plugin

- Use `b:gitsigns_status` or `b:gitsigns_status_dict`.
- `b:gitsigns_status` is formatted using `config.status_formatter`.
- `b:gitsigns_status_dict` is a dictionary with the keys `added`, `removed`, `changed` and `head`.

Example:

```viml
set statusline+=%{get(b:,'gitsigns_status','')}
```

#### helpfile

```help
STATUSLINE                                               *gitsigns-statusline*

                                    *b:gitsigns_status* *b:gitsigns_status_dict*
The buffer variables `b:gitsigns_status` and `b:gitsigns_status_dict` are
provided. `b:gitsigns_status` is formatted using `config.status_formatter`
. `b:gitsigns_status_dict` is a dictionary with the keys:

        • `added` - Number of added lines.
        • `changed` - Number of changed lines.
        • `removed` - Number of removed lines.
        • `head` - Name of current HEAD (branch or short commit hash).
        • `root` - Top level directory of the working tree.
        • `gitdir` - .git directory.

Example:
>vim
    set statusline+=%{get(b:,'gitsigns_status','')}
<
                                            *b:gitsigns_head* *g:gitsigns_head*
Use `g:gitsigns_head` and `b:gitsigns_head` to return the name of the current
HEAD (usually branch name). If the current HEAD is detached then this will be
a short commit hash. `g:gitsigns_head` returns the current HEAD for the
current working directory, whereas `b:gitsigns_head` returns the current HEAD
for each buffer.

                            *b:gitsigns_blame_line* *b:gitsigns_blame_line_dict*
Provided if |gitsigns-config-current_line_blame| is enabled.
`b:gitsigns_blame_line` if formatted using
`config.current_line_blame_formatter`. `b:gitsigns_blame_line_dict` is a
dictionary containing of the blame object for the current line. For complete
list of keys, see the {blame_info} argument from
|gitsigns-config-current_line_blame_formatter|.
```

