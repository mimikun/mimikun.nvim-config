## Welcome to the fzf :heart: lua wiki!

<!-- ![](https://raw.githubusercontent.com/wiki/ibhagwan/fzf-lua/demo.gif) -->

[**Click here for ADVANCED CUSTOMIZATION / API DOCS**](Advanced)

## FAQ

- **General**
    + [What is `fzf-lua`?](#what-is-fzf-lua)
    + [What's the difference between `fzf-lua` and `fzf.vim`?](#differences-fzf.vim)
    + [Does fzf-lua require or conflict with `fzf`/`fzf.vim`?](#conflict-fzf.vim)
    + [What's the difference between `fzf-lua` and `telescope.nvim`?](#differences-telescope.nvim)
    + [What's the recommended setup?](#recommended-setup)
    + [How can I quickly test fzf-lua with minimal init?](#minimal-init)
    + [How to cycle among results?](#results-cycle)
- **Customization**
    + [**READ THIS TO UNDERSTAND CUSTOMIZATION**](#customization)
- **Provider Options**
    + [**Click here for all provider options documentation**](Options)
- **Appearance**
    + [How do I change the window size and position?](#window-size-and-pos)
    + [Can I set the window size dynamically?](#dynamic-window-size)
    + [How do I change the layout of fzf and the preview window?](#fzf-layout)
    + [How do I set the preview to start hidden?](#preview-start-hidden)
    + [How do I set the preview syntax highlight theme?](#preview-syntax-theme)
    + [How do I change the colors of the fzf popup window?](#window-colors)
    + [Can I use fzf-lua in a split instead of a window?](#split-layout)
    + [Icon padding for terminals with double width icon support](#icon-padding)
    + [Auto redraw when neovim window is resized](#auto-redraw)
    + [How do I disable current working dir in `files` prompt?](#files-cwd-prompt)
    + [Automatic sizing of height/width of `vim.ui.select`](#ui-select-auto-size)
- **Keybinds**
    + [How do I set custom keybinds?](#custom-keybinds)
    + [How do I set custom actions?](#custom-actions)
    + [How do I setup input history keybinds?](#custom-history)
    + [How do I send all grep results to quickfix list?](#quickfix-grep)
- **Misc**
    + [Set current working directory for providers](#cwd)
    + [How do I exclude paths (e.g. 'node_modules')?](#exclude-paths)
    + [How do I ignore specific file patterns?](#file-ignore-patterns)
    + [What does `multiprocess` do?](#multiprocess)
    + [What's the difference between `grep` and `live_grep`?](#grep-vs-live-grep)
    + [How can I simulate fzf.vim's `Rg` command?](#fzf-vim-rg)
    + [Can I continue from the last search?](#grep-resume)
    + [`live_grep` shows no results before I start typing](#live-grep-empty-query)
    + [Can I use ripgrep's `--iglob` option with `live_grep`?](#live-grep-glob)
    + [How can I send custom flags to ripgrep with `live_grep`?](#live-grep-custom)
    + [How can I restrict grep search to certain files?](#glob-usage-example)
    + [Search results do not appear in the same order](#grep-sort-order)
    + [LSP: prevent window flashing when no results](#lsp-sync)
    + [LSP: jump to location for single result](#lsp-single-result)
    + [LSP references: ignore current line](#lsp-ignore-current-line)
    + [LSP references: ignore declaration](#lsp-ignore-declaration)
    + [Disable or hide filename fuzzy search](#nth)
    + [How do I get maximum performance out of fzf-lua?](#max-perf)
    + [Can fzf-lua preview media files?](#media-preview)
    + [A recommended workflow for big projects](#big-project-workflow)
    + [Prevent window flash during resize](#prevent-flash-resize)
    + [Workspace LSP symbols do not work](#workspace-lsp-symbols-do-not-work)
    + [How can I show harpoon files with the fzf-lua picker?](#harpoon-picker)

## General
### <a id="what-is-fzf-lua">What is fzf-lua?</a>

Fzf-lua is a neovim (>0.5) plugin written in lua integrating
[`fzf`](https://github.com/junegunn/fzf) into the neovim ecosystem.

#### OK, but what does that even mean?

`fzf` is described as a _general-purpose command line fuzzy finder_ meaning
you can search any output using the fuzzy search algorithm. This opaque
description hides an endless wealth of functionality from searching files,
processes, command-line history and much more. fzf-lua aims to bring all this
goodness to neovim.

Wait, but isn't there already a vim/neovim plugin for that,
[`fzf.vim`](https://github.com/junegunn/fzf.vim)?

### <a id="differences-fzf.vim">fzf-lua vs fzf.vim</a>

[`fzf.vim`](https://github.com/junegunn/fzf.vim) is a great plugin, it worked
flawlessly for me for a long time and until recently I wouldn't have
considered replacing it.

So what changed? Neovim 0.5 was released with lua programming language as a
first class citizen and with it the opportunity to extend neovim for anyone
who has been avoiding it due to the vimL scripting language. Don't get me
wrong, there's nothing wrong with vimL but I personally found it not very
intuitive and although I've been using vim for years now I avoided writing
anything but the absolute basics in vimL.

Pros over `fzf.vim`:

- Written in pure lua especially for neovim 0.5
- Customizable but has sane defaults
- Easily extendible in lua
- Builtin providers for LSP and quickfix lists (references, definitions,
  diagnostics, symbols, etc) without requiring additional plugins like
  [`nvim-lspfuzzy`](https://github.com/ojroques/nvim-lspfuzzy) or
  [`coc-fzf`](https://github.com/antoinemadec/coc-fzf)
- Builtin support for file icons and git indicators

Cons vs `fzf.vim`:
- Does not work with vim or any neovim version lower than 0.5

### <a id="conflict-fzf.vim">Does fzf-lua require or conflict with `fzf`/`fzf.vim`?</a>

Fzf-lua only requirements are the `fzf` binary, it does not
require nor conflict with `fzf.vim`.

Fzf-lua utilizes a separate neovim `--headless --clean` instance to do it's
processing which is then piped into fzf in a neovim terminal windows, it does
not require any of the vim functions exposed by the `fzf` or `fzf.vim` plugins.

### <a id="differences-telescope.nvim">fzf-lua vs telescope.nvim</a>

[`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) is a
great fuzzy finding ecosystem written by the core maintainer of neovim,
[@tjdevries](https://github.com/tjdevries/), it has a thriving ecosystem of
extensions and a big community, some of its advantages over `fzf-lua` are:

- Tightly integrated within neovim, does not require an external program or
  process
- Vast amount of extensions and vast support for pretty much anything
- Big community

That said, after using telescope for a while it had a few shortcomings which
pushed me towards developing fzf-lua:

- ~~Inability to cycle through the results, you are only able to see one page of
  the results and narrow them down using fuzzy search, you can't page up/down
  (ctrl-b|f) the results pane~~ **No longer relevant since**
  [Telescope#1232](https://github.com/nvim-telescope/telescope.nvim/pull/1232)
- Performance issue when operating on large files and code bases, that is
  partly due to telescope being mostly synchronous. Recently telescope merged
  [plenary PR #83: async await using
  libuv](https://github.com/nvim-lua/plenary.nvim/pull/83) and [telescope PR
  #709: feat: asyncify
  pickers](https://github.com/nvim-telescope/telescope.nvim/pull/709) in an
  effort to solve these issues.
- A rather large code base and community naturally introduces more complexity
  which has greater potential for bugs and issues down the road.

In addition, I really liked `fzf`, it had worked flawlessly for me for a long
time and I enjoy having uniformity and similar experience/interface throughout
my shell, tmux and neovim.

### <a id="recommended-setup">What's the recommended setup?</a>

To get the best out of fzf-lua I highly recommend installing the below:

- [fd](https://github.com/sharkdp/fd): a better version of the `find` utility
- [ripgrep(rg)](https://github.com/BurntSushi/ripgrep): a better version of
  the `grep` utility

In addition, in neovim, use your favorite plugin manager to install
`kyazdani42/nvim-web-devicons` in order to be able to display file icons in
the interface.

If you're using [`packer.nvim`](https://github.com/wbthomason/packer.nvim) add
the below to `packer.startup({})`:

```lua
use { 'ibhagwan/fzf-lua',
  requires = { 'kyazdani42/nvim-web-devicons' },
}
```

If you're using [`vim-plug`](https://github.com/junegunn/vim-plug):

```vim
Plug 'ibhagwan/fzf-lua'
Plug 'kyazdani42/nvim-web-devicons'
```
### <a id="minimal-init">How can I quickly test fzf-lua with minimal init?</a>

There are two ways of testing fzf-lua with minimal init:

#### Using `scripts/mini.sh` (recommended)

```sh
❯ sh -c "$(curl -s https://raw.githubusercontent.com/ibhagwan/fzf-lua/main/scripts/mini.sh)"
```

> **NOTES:**
> - Creates a sandbox environment for neovim under the OS temp dir (i.e.
>   `/tmp/fzf-lua.tmp/`)
> - Also downloads `nvim-web-devicons` so devicons integration can be tested
> - Default binds:
>   + `<C-k>`: `:FzfLua builtin`
>   + `<C-p>`: `:FzfLua files`
>   + `<F1>` : `:FzfLua help_tags`

If you wish to modify the default `init.lua` and test your own version,
download fzf-lua and run the script locally:
```sh
❯ git clone https://github.com/ibhagwan/fzf-lua.git
❯ cd fzf-lua
# optional: edit 'scripts/init.lua'
# make sure to delete the previous sandbox (OSX will
# be a different folder, use `mktemp -d` to discover)
❯ rm -rf /tmp/fzf-lua.tmp
❯ ./scripts/mini.sh
```

#### Using `scripts/minimal_init.lua` (the "old" method)

Download (+modify setup) and run:
```sh
❯ curl -LO https://raw.githubusercontent.com/ibhagwan/fzf-lua/main/scripts/minimal_init.lua
❯ nvim -u minimal_init.lua
```
Or run directly from github:
```sh
❯ nvim -u <((echo "lua << EOF") && (curl -s https://raw.githubusercontent.com/ibhagwan/fzf-lua/main/scripts/minimal_init.lua) && (echo "EOF"))
```

> **NOTES:**
> - `nvim-web-devicons` is not used here, to test fzf-lua with devicons use
>   `scripts/mini.sh`
> - The script uses `packer.nvim` but does not remove your currently downloaded
>   plugins, it does not load optional plugins or run `setup` for auto-loaded
>   plugins, therefore plugin conflicts (although rare) can still happen
> - Default binds:
>   + `<C-p>`: `:FzfLua files`


### <a id="results-cycle">How to cycle among results?</a>

```lua
require('fzf-lua').setup {
  fzf_opts = { ['--cycle'] = true }
}
```


# <a id="customization">Customization</a>

It's important to understand how customization works in order to understand
the following sections better as all options are specified in the same manner
and adhere to the same order:
- Global options
- Provider options
- Function call options

For example, if we wanted to change the height of the `files` window, we could
do so in 3 different ways:

1. Apply a global `height` setting:
```lua
require("fzf-lua").setup({
  winopts = { height = 0.4 }
})
```

2. Apply `height` under the `files` provider:
```lua
require("fzf-lua").setup({
  files = {
    prompt = 'Files❯ ', -- example, not required
    winopts = { height = 0.4 },
  }
})
```

3. Apply `height` to a single call:
```lua
:lua require("fzf-lua").files({ winopts = { height = 0.4 } })
```

4. For dynamically generated arguments, options can also be defined as a function:
```lua
:lua require("fzf-lua").files(function() return {cwd_header=true, cwd=vim.loop.cwd()} end)
```

> **Most options defaults can be found [on the project's main
page](https://github.com/ibhagwan/fzf-lua), unfortunately, some options are not
yet properly documented, searching the [project's
issues](https://github.com/ibhagwan/fzf-lua/issues) is your best bet of
finding an esoteric option (e.g. `live_grep({exec_empty_query=true})`)**

## Appearance
### <a id="window-size-and-pos">How do I change the window size and position</a>

The window look and feel is controlled by 4 parameters, `winopts.height`,
`winopts.width`, `winopts.row` and `winopts.col`, their values can either contain a range from
`0.0 - 1.0` and correspond as a percentage of available screen space based on nvim width and height
(`vim.o.columns`, `vim.o.lines`) or they can also accept a normal integer value indicating exact size.

### <a id="dynamic-window-size">Can I set the window size dynamically?</a>

If you wish to set some (or all) `winopts` parameters dynamically, you can
define `winopts_fn` as a function that returns the parameters you wish to
override:

```lua
require("fzf-lua").setup({
  winopts_fn = function()
    -- smaller width if neovim win has over 80 columns
    return { width = vim.o.columns>80 and 0.65 or 0.85 }
  end,
})
```

### <a id="fzf-layout">How do I change the layout of fzf and the preview window?</a>

The appearance of fzf (input box location, colors, etc) is controlled by the fzf binary.
Fzf-lua exposes all fzf options through the config, `fzf_opts` can accept any
fzf flag, `fzf_colors` controls the colors and `keymap.fzf` controls all binds
that are native to fzf and the preview when using the native fzf previewer.

To change the location of the fuzzy search input field set `'fzf_opts[--layout']`
option which is equal to the `fzf --layout=` command line flag, valid values are
`default`, `reverse` and `reverse-list`.

Fundamentally fzf-lua has two different preview window options, the first
preview option is controlled by the fzf binary and the second is a neovim
floating window, some providers support both options (mostly files-based
providers) and some support only the native fzf preview window.

The default previewer for files uses neovim's floating win, if you wish to use
`bat` as a previewer set `winopts.preview.default = 'bat'`.

To change the location of the preview window, set the `winopts.preview.layout`
option, valid values are `vertical`, `horizontal` and `flex`, when set to `flex`
the layout will dynamically switch between vertical and horizontal based on
the number of available columns in conjunction with the `flip_columns` option.
E.g. when `flip_columns = 120` the layout will be set to `vertical` (i.e.
preview on the bottom) when screen size is less than 120 columns or `horizontal`
otherwise.

To control location of the preview of the preview window
(`up|down|left|right`) look into `winopts.preview.horizontal` and `winopts.preview.vertical`
respectively.

### <a id="preview-start-hidden">How do I set the preview to start hidden?</a>

Set `winopts.preview.hidden` option to control the preview visibility (works
for both neovim floating preview and native fzf's `--preview-window=`), can be
set to `hidden` or `nohidden`.

> **Note:** The above also applies to the preview `wrap|nowrap` option which
> controls word wrapping in the preview window.


### <a id="preview-syntax-theme">How do I set the preview syntax highlight theme?</a>

When using the default neovim float win previewer the syntax highlight will
match the current neovim colorscheme.

To enable preview syntax highlighting when using fzf native previewer, you need
to install [`bat`](https://github.com/sharkdp/bat) which is the fancy version of
`cat` (used as the fzf previewer).

Fzf-lua will auto-detect you have bat installed and use it automatically, run
`bat --list-themes` in your shell to preview all available theme and set
`previewers.bat.theme` to your preferred theme.

### <a id="window-colors">How do I change the colors of the fzf popup window?</a>

Fzf colors can be set under `fzf_colors`, fzf-lua will then translate the
neovim highlight to a RGB color and pass it to fzf using the `--color=` flag.

The popup colors of fzf (bg/background) as well as the neovim floating window
preview colors are defined under `winopts.hl`.

### <a id="split-layout">Can I use fzf-lua in a split instead of a window?</a>

Yes, this requires setting the `winopts.split` command, the command will then
run right before fzf-lua starts:

> Once `split` option is set all other layout options for the window
> (`col`, `row`, `border`, etc) are ignored.

```lua
require("fzf-lua").setup({
  winopts = {
    -- Use **only one** of the below options
    split = "aboveleft new"   -- open in split above current window
    split = "belowright new"  -- open in split below current window
    split = "aboveleft vnew"  -- open in split left of current window
    split = "belowright vnew" -- open in split right of current window
    split = "topleft new"   -- open in a full-width split on top
    split = "botright new"  -- open in a full-width split on the bottom
    split = "topleft vnew"  -- open in a full-height split on the far left
    split = "botright vnew" -- open in a full-height split on the far right
  }
})
```

### <a id="icon-padding">Icon padding for terminals with double width icon support</a>

Some terminals (such as `kitty`) support rendering double-width icons, this
can cause the edge of wide icons to be cut off, this can be solved with the
`file_icon_padding` option:

```lua
require("fzf-lua").setup({
  file_icon_padding = ' ',
})
```

### <a id="auto-redraw">Auto redraw when neovim window is resized</a>

FzfLua will automatically redraw when the neovim window size changes and the
`VimResized` event is triggered.

If for some reason you still need manually redraw the fzf-lua window you can
call `:FzfLua redraw` or `:lua require'fzf-lua'.redraw()` to manually trigger
the redraw.
> **NOTE:** fzf-lua is a terminal window, you need to first press `<C-\>C-n>` to
> get to `Normal` mode before you can issue the `:FzfLua ...` command.

You can also use an autocmd to trigger an automatic redraw once certain events
happen, below is an equivalent of the buffer local autocmd setup by fzf-lua:

```lua
vim.api.nvim_create_autocmd("VimResized", {
  pattern = '*',   
  command = 'lua require("fzf-lua").redraw()'
})
```

### <a id="files-cwd-prompt">How do I disable current working dir in `files` prompt?</a>

```lua
-- using the default prompt
:lua require("fzf-lua").files({ cwd_prompt = false })
-- using a custom prompt
:lua require("fzf-lua").files({ cwd_prompt = false, prompt = 'Files❯ ' })
```

### <a id="ui-select-auto-size">Automatic sizing of height/width of `vim.ui.select`</a>

> See [#793](https://github.com/ibhagwan/fzf-lua/issues/793) for more info

```lua
require("fzf-lua").register_ui_select(function(_, items)
  local min_h, max_h = 0.15, 0.70
  local h = (#items + 4) / vim.o.lines
  if h < min_h then
    h = min_h
  elseif h > max_h then
    h = max_h
  end
  return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)
```

## Keybinds

### <a id="custom-keybinds">How do I set custom keybinds?</a>

All keybinds for both the neovim floating win previewer and fzf are defined
under the `keymap.builtin` and `keymap.fzf` tables respectively.

When defining `keymap.builtin` binds you must use neovim-style keymaps
(i.e. `<C-c>` for Control-C).

When defining `keymap.fzf` binds you must use fzf-style keymas (i.e. `ctrl-c`
for Control-c), `man fzf` for all available fzf mappings.

If you wish to define custom logic or define fzf binds that are otherwise not
available you can do so inside the `winopts.on_create` callback event.

For example, the Super/Meta key is not available to use with fzf but you can map
`<Super-Backspace>` to `<ctrl-u>` with:

```lua
fzf_lua.setup({
  winopts = {
    on_create = function()
      -- creates a local buffer mapping translating <M-BS> to <C-u>
      vim.keymap.set("t", "<M-BS>",
        "<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-u>', true, false, true), 'n', true)<CR>",
        {nowait = true, buffer = true})

    end
  }
})
```

### <a id="custom-actions">How do I set custom actions?</a>

Actions are essentially fzf keybinds which control what to do with selected
entries.

All file actions inherit from `actions.files` and all buffer actions inherit
from `actions.buffers` which then gets merged with the provider actions table
(if such table exists), for example the actions for `files` are defined as
`actions.files` table merged with `files.actions` table.

It's important to note not all providers inherit from the global `actions`
table:
- `actions.files` is inherited by: `files`, `git_files`, `git_status`, `grep`,
  `lsp`, `oldfiles`, `quickfix`, `loclist`, `tags`, `btags` `args`, `tagstack`
- `actions.buffers` is inherited by: `buffers`, `tabs`, `lines`, `blines`

For example, the default action for file edit is to open a single file or send
multiple selection to the quickfix list, if you wish to change the default
behavior to open multiple selection you need to define:
```lua
local actions = require'fzf-lua.actions'
require 'fzf-lua'.setup({
  actions = {
    files = {
      -- instead of the default action 'actions.file_edit_or_qf'
      -- it's important to define all other actions here as this
      -- table does not get merged with the global defaults
      ["default"]       = actions.file_edit,
      ["ctrl-s"]        = actions.file_split,
      ["ctrl-v"]        = actions.file_vsplit,
      ["ctrl-t"]        = actions.file_tabedit,
      ["alt-q"]         = actions.file_sel_to_qf,
    },
  },
})
```

> Discussions in [#279](https://github.com/ibhagwan/fzf-lua/issues/279) and
  [#331](https://github.com/ibhagwan/fzf-lua/issues/331)

### <a id="custom-history">How do I setup input history keybinds?</a>

Fzf supports saving input history into a history file using `--history` flag.
You can configure a history file globally or per provider. Once the `--history`
flag is supplied fzf will automatically map `ctrl-{n|p}` to
`{next|previous}-history`, you can change the default binds under `keymap.fzf`.

Example #1: saving global input history under
`~/.local/share/nvim/fzf-lua-history`:

```lua
require('fzf-lua').setup{
  fzf_opts = {
    ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-history',
  },
}
```
> **NOTE:** the directory must exist, so if you're using a custom folder make
> sure the directory exists using `mkdir -p`.

Example #2: saving a separate history file for `files|grep` under
`~/.local/share/nvim/`:

```lua
require('fzf-lua').setup{
  files = {
    fzf_opts = {
      ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-files-history',
    },
  },
  grep = {
    fzf_opts = {
      ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-grep-history',
    },
  }
}
```
### <a id="quickfix-grep">How do I send all grep results to quickfix list?</a>
To replicate Telescope's `ctrl-q` behavior:

```lua
require('fzf-lua').setup({
    keymap = {
        fzf = {
            true,
            -- Use <c-q> to select all items and add them to the quickfix list
            ["ctrl-q"] = "select-all+accept",
        },
    },
})
```

> Discussions in [#324](https://github.com/ibhagwan/fzf-lua/issues/324), [#546](https://github.com/ibhagwan/fzf-lua/issues/546), [#1109](https://github.com/ibhagwan/fzf-lua/discussions/1109), [#1196](https://github.com/ibhagwan/fzf-lua/issues/1196), [#1211](https://github.com/ibhagwan/fzf-lua/discussions/1211), [#1676](https://github.com/ibhagwan/fzf-lua/discussions/1676)

> Issues in [#324](https://github.com/ibhagwan/fzf-lua/issues/324), [#546](https://github.com/ibhagwan/fzf-lua/issues/546)

> Note: Requires at least fzf 0.53.

## Misc

### <a id="cwd">Set current working directory for providers</a>

Most providers support setting the working directory using the `cwd` option:

```lua
:lua require("fzf-lua").files({ cwd = "~/dots" })
```

Some providers (`buffers`, `oldfiles`) support showing files from the current
directory only using the `cwd_only` option.

An example by @gegoune, show all file history when in `~`, otherwise show
current directory only:
```lua
:lua require('fzf-lua').oldfiles({
  cwd_only = function()
    return vim.api.nvim_command('pwd') ~= vim.env.HOME
  end
})
```

### <a id="exclude-paths">How do I exclude paths (e.g. 'node_modules')?</a>

Excluding paths can be done by adding flags to the underlying executed command
for the provider.

Setting the `cmd` option will override the underlying command:

`files`: excluding a folder using `fd`:
```lua
:lua require'fzf-lua'.files({ cmd = 'fd --type f --exclude node_modules' })
```

`files`: excluding a folder using `find`:
```lua
:lua require'fzf-lua'.files({ cmd = "find -type f -not -path '*/node_modules/*' -printf '%P\n'" })
```

`grep`: excluding a folder using `rg`:
```lua
:lua require'fzf-lua'.grep({ cmd = "rg --color=always --smart-case -g '!{.git,node_modules}/'" })
```

>Alternatively, you can also modify the default auto-detect options:
>- `files` prioritizes `fd` over `rg --files` over `find`, default options can
>be modified by setting `files.{fd|rg|find}_opts` respectively.
>- `grep` prioritizes `rg` over `grep`, default options can be modified by
>setting `grep.{rg|grep|_opts` respectively.
>```lua
>-- Note the omission of `fd`:
>:lua require'fzf-lua'.files({ fd_opts = '--type f --exclude node_modules' })
>```


We can also exclude some more complex regex patterns by either piping a filter
command to `files.cmd` or using `grep.filter`. The below example excludes `.lua`
files:
```lua
-- use `grep -P` for perl regex syntax
:lua require'fzf-lua'.files({ cmd = "fd --type f | rg -v '\\.lua$'" })
:lua require'fzf-lua'.files({ cmd = "fd --type f | grep -v -P '\\.lua$'" })
```

However, we cannot do this with `grep` because the search string is appended
after the `cmd` argument, we use the `filter` option to achieve the same
result:
> Note the omission of the `$` sign as the regex is performed on the entire
> line including the matching text so the filename is in not at the end of the
> line
```lua
:lua require'fzf-lua'.live_grep({ filter = "rg -v '\\.lua'", debug=true})
```

### <a id="file-ignore-patterns">How do I ignore specific file patterns?</a>

Excluding paths as explained above is the preferred and most performant way as
it reduces the amount of lines fzf-lua needs to process but it won't work on
file based providers where a command is not used (e.g. `oldfiles`, `lsp_xxx`,
etc).

In addition, sometimes a different approach is needed and you might want to
ignore ceratin file patterns globally, for this we have `file_ignore_patterns`,
a simple array of
[lua pattern matching](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
strings which can be set globally, per provider or sent directly in the call
arguments.

> **Note:** `file_ignore_patterns` affects all file based providers: `files`,
> `grep|live_grep`, `git_files`, `git_status`, `diagnostics`, `lsp_XXX`, `args`,
> `oldfiles`, `quickfix`, `loclist`, `dap_breakpoints`

As a global setting:
```lua
require'fzf-lua'.setup {
  -- ignore all '.lua' and '.vim' files
  file_ignore_patterns = { "%.lua$", "%.vim$" }
}
```

As a provider setting:
```lua
require'fzf-lua'.setup {
  files = {
    prompt = "Files> ", 
    file_ignore_patterns = { "%.lua$", "%.vim$" },
  }
}
```

Directly in a call:
```lua
-- ignore all files that start with a '/'
:lua require'fzf-lua'.lsp_live_workspace_symbols({ file_ignore_patterns={ "^/" } })
```

> All of the above can be combined, you can have a global setting, provider
> setting and call argument all at the same time, all 3 settings will be
> merged at runtime into a single `file_ignore_patterns` array.

### <a id="multiprocess">What does `multiprocess` do?</a>

Best explained by [reading the commit message](https://github.com/ibhagwan/fzf-lua/commit/2d8a4e9afc7b32cdd7552f1ccd641c8bd6c2e85c) and the discussion in
[#248](https://github.com/ibhagwan/fzf-lua/issues/248):
```text
Since LUA is single threaded I reached a limit to performance
optimization, both 'git_icons' and 'file_icons' require string
matching and manipulations which eventually hurt performance
when running on large amount of files.
In order to solve that this commit introduces the option to spawn
commands and process the entries in a separate neovim process which
prints to stdio as if it was a regular shell command. This speeds up
things significantly and also makes the UI super responsive as if fzf
was run in the shell. This required a few lua hacks to be able to load
nvim-web-devicons in a '--headless --clean' instance and sharing the
user configuration through the RPC interface from the running instance.
This is enabled by default for 'files' and 'grep' providers and can also
be enabled for 'git.files' if required, control using the 'multiprocess'
option.
```

> Unless you're having issues I highly recommend keeping the default
> `multiprocess = true`. Also see the discussion how to debug multiprocess in
> [What's the difference between `grep` and `live_grep`?](#grep-vs-live-grep)

### <a id="grep-vs-live-grep">What's the difference between `grep` and `live_grep`?</a>

`grep` uses `rg` (or `grep` if `rg` is not installed) to search for a pattern,
the results are then fed into `fzf` for further refinement using fuzzy search.

`live_grep` on the other hand uses `fzf` as a UI selector only, the fuzzy
search functionality is disabled and each keystroke generates a new `rg` query
with the input prompt text.

Both methods have their pros and cons, in large codebases `live_grep` can be
faster at the cost of not having the fuzzy search, it's about using the right
tool for the job.

In order to better understand how this works I recommend experimenting with
both `grep` and `live_grep` with both `multiprocess` and `debug`:
```lua
:lua require'fzf-lua'.grep({ multiprocess=true, debug=true })
:lua require'fzf-lua'.live_grep({ multiprocess=true, debug=true })
```

With `debug=true` the underlying `rg` command will be printed as the first
match so you'll be able to see that with `grep` the command never changes, all
results are already indexed inside `fzf` and every keystroke shows the fuzzy
mathced results, on the other hand with `live_grep` you'll notice that each
keystroke generates a new underlying `rg` command. I find this very helpful to
also understand how `live_grep_glob` query parsing works, for example you can
see that the typed query `now -- *which*` gets translated to searching for the
word `now` limited to files which contain the word `which`:

![Glob](https://raw.githubusercontent.com/wiki/ibhagwan/fzf-lua/live_grep_glob.png)

Let's clarify with an example. Say we have opened the file `dummy.txt` in the buffer:

```txt
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Sed sed diam auctor, feugiat justo id, congue nisi.
    Quisque laoreet nisl vitae leo vehicula auctor.
    Etiam eget augue sed magna congue feugiat.
    In sed arcu tempus, euismod elit eget, vehicula sem.

    Donec mattis arcu eget quam congue imperdiet.
    Suspendisse ultricies justo at urna laoreet pretium.
    Aliquam at augue dapibus, vestibulum risus sit amet, tincidunt quam.

    Nullam quis mauris dictum, pharetra turpis id, fringilla lacus.
    Proin sodales nibh nec finibus iaculis.
    Etiam eget nunc ut elit elementum auctor nec eu ipsum.
    Quisque imperdiet quam interdum, consequat ante dictum, porta tortor.
    Duis ultrices libero at lorem eleifend, id dapibus arcu iaculis.

    In efficitur leo commodo, tincidunt est vitae, efficitur lectus.
    Suspendisse eu odio vitae risus sollicitudin tincidunt vehicula ac enim.
    Morbi convallis purus sed mollis pellentesque.
    Integer mattis elit id turpis tempus rutrum.

    Quisque finibus mauris ut nisi scelerisque, a semper massa rutrum.
```

`fzf-lua` provides 2 ways to search inside the buffer: `grep_curbuf` and `lgrep_curbuf` (live grep). Here we try to search by the term `in`.

- `grep_curbuf`

    ![Screenshot_20250121_204231](https://github.com/user-attachments/assets/351670e1-dd63-429f-bab1-b8e564913f48)

- `lgrep_curbuf`

    ![Screenshot_20250121_204204](https://github.com/user-attachments/assets/9949582d-bc44-4645-8674-7b5a40e2a9ce)

The difference:

- `grep_curbuf` dumps all the bufferlines in `fzf`, allowing you to fuzzy search. It is essentially `cat dummy.txt | fzf --query 'in'`. The search term can be any string by which you want to fuzzy search.
- `lgrep_curbuf` (live grep) uses only `grep` or `rg`. It does not fuzzy search, but searches by regex. It is essentially `grep --ignore-case 'in' dummy.txt` or `rg --ignore-case 'in' dummy.txt`. The search term has to be a valid regex.

You can see this if you look for line 3 of `dummy.txt` in the results. `grep_curbuf` has line 3 because there is an `i` somewhere in the line followed by an `n` somewhere else in the line: not necessarily `in`, but fuzzy e.g. "Et**i**am eget augue sed mag**n**a congue feugiat". This line does not correspond with the regex `in` however and thus is line 3 not a result in `lgrep_curbuf` (live grep). It would be if the regex were the regex `i.*n` instead of `in`.

### <a id="fzf-vim-rg">How can I simulate fzf.vim's `Rg` command?</a>

Unless a search term is specified, `Rg` feeds all lines of the project into fzf,
the equivalent in fzf-lua would be running `grep` with an empty search query:
```lua
:lua require("fzf-lua").grep({ search = "" })
```

`fzf-lua` comes with a convinience shortcut `grep_project` that combines both
the empty string search as well as excluding file names from fuzzy matching:
```lua
-- both commands are equal:
:lua require("fzf-lua").grep_project()
:lua require("fzf-lua").grep({ search = "", fzf_opts = { ['--nth'] = '2..' } })
```


### <a id="grep-resume">Can I continue from the last search?</a>

Yes, both `grep` and `live_grep` can resume the last search:
```lua
-- `live_grep` is also supported
:lua require("fzf-lua").grep({ resume = true })
```

Alternatively you can also use `:FzfLua resume`.

### <a id="live-grep-empty-query">`live_grep` shows no results before I start typing</a>

By default `live_grep` does not run an empty query unless:
```lua
:lua require("fzf-lua").live_grep({ exec_empty_query = true })
```

### <a id="live-grep-glob">Can I use ripgrep's `--glob|iglob` option with `live_grep`?</a>

Both `--glob` and `--iglob` are supported, the default options are under the `grep` provider:
```lua
require("fzf-lua").setup({
  grep = {
    rg_glob         = true        -- enable glob parsing by default to all
                                  -- grep providers? (default:false)
    glob_flag       = "--iglob",  -- for case sensitive globs use '--glob'
    glob_separator  = "%s%-%-"    -- query separator pattern (lua): ' --'
  }
})
```

Setting `rg_glob=true` instructs fzf-lua to parse the search query (regex) and look for the
separator, anything after the separator will be converted to a separate glob flag, few examples:

Search for all lines starting with `foo` within `*.lua` files:
```
*Rg> ^foo -- *.lua
```
> Generates the below underlying command:
> ```sh
> rg ${rg_opts} --iglob *.lua -e "^foo"
> ```

Search for all lines starting with `foo` within `*.lua` files, exclude `*spec*` files:
```
*Rg> ^foo -- *.lua !*spec*
```
> Generates the below underlying command:
> ```sh
> rg ${rg_opts} --iglob *.lua --iglob !*spec* -e "^foo"
> ```

Once `rg_glob=true` we aren't limited to `live_grep`, any search regex is parsed for a separator
and uses the same logic so we can use globs in `grep` directly:
```lua
:lua require("fzf-lua").grep({ no_esc=true, search="foo -- *.lua" })
```

Another example, from
[issue #167](https://github.com/ibhagwan/fzf-lua/issues/167#issuecomment-936682252), shows how
the underlying `rg` command (below the status line) changes with each keystroke and the generated
glob arguments once the separator is detected:

![167](https://user-images.githubusercontent.com/59988195/136248999-cab6e76e-ea63-4432-aa69-3d6c4b70eb32.gif)

### <a id="live-grep-custom">How can I send custom flags to ripgrep with `live_grep`?</a>

Using a custom `rg_glob_fn` we can build our own `live_grep_glob`, one such example would
be sending any argument to `rg` similar to
[telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim):

```lua
require("fzf-lua").setup({
  grep = {
    rg_glob = true,
    -- first returned string is the new search query
    -- second returned string are (optional) additional rg flags
    -- @return string, string?
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      -- If no separator is detected will return the original query
      return (regex or query), flags
    end
  }
})
```

For example, sending the "word boundary" flag:
```
*Rg> ^foo -- --word-regexp --glob="*.lua"
```
> generates the below underlying command
> ```sh
> rg ${rg_opts} --word-regexp --glob="*.lua" -e "^foo"
> ```

Similar to the default glob search, once `rg_glob` is enabled we can use the new parser directly
from `grep`:
```lua
:lua require("fzf-lua").grep({ no_esc=true, search="foo -- --word-regexp" })
```

For other examples of custom `rg_glob_fn` see
[#373](https://github.com/ibhagwan/fzf-lua/issues/373#issuecomment-1079786343).

### <a id="glob-usage-example">How can I restrict grep search to certain files?</a>

> **Note** restricting searches to file globs requires installing `rg`.

Building on the above, either enable `rg_glob` to all providers an or use `live_grep_glob`
and use the default separator ` --` (space dash dash) to separate the search query from the
file glob specification:

1. Open glob enabled live grep by executing `:FzfLua live_grep_glob`
2. Type your search, separated by the glob_separator, e.g:
`Rg> <search_term> -- <glob_spec1> <glob_spec2> ...`

More specific examples:
- Searching for all test files that import the `react-hooks` library assuming test files are
named `<name>.spec.<ext>`: `Rg> @testing-library/react-hooks --*.spec.*`

- Searching for all occurrences of the `Partial` utility in javascript and typescript files:
`Rg> Partial --*.ts* *.js`

### <a id="grep-sort-order">Search results do not appear in the same order</a>

For performance reasons the default `rg` command does not sort the results, to
sort the results add `--sort-files` to the default `grep.rg_opts`:
```lua
require("fzf-lua").setup({
  grep = {
    rg_opts = "--sort-files --hidden --column --line-number --no-heading " ..
              "--color=always --smart-case -g '!{.git,node_modules}/*'",
  }
})
```

### <a id="lsp-sync">LSP: prevent window flashing when no results</a>

By default all LSP calls are asynchronous (better UI responsiveness), when
running async calls fzf-lua can't tell in advance if there will be any
results hence when there are no results the window is flashing.

It's possible to prevent the window from flashing by running in `sync` mode,
to do so either define `lsp.async = false` (globally) or send send `async = false`
with your LSP call, e.g.:

```lua
:lua require("fzf-lua").lsp_code_actions({ async = false })
```


### <a id="lsp-single-result">LSP: jump to location for single result</a>

When running `references|definitions` the LSP can sometimes return a single
result, if you wish to jump there immediately instead of opening the window
run:

```lua
:lua require("fzf-lua").lsp_definitions({ jump1 = true })
```

It's also possible to control how the single result action will behave:

```lua
:lua require('fzf-lua').lsp_definitions({
  sync = true,
  jump_to_single_result = true,
  jump_to_single_result_action = require('fzf-lua.actions').file_vsplit,
})
```

### <a id="lsp-ignore-current-line">LSP references: ignore current line</a>

When using `lsp_references` some users prefer to see "other references" only
and ignore the current line, this is possible via:

```lua
:lua require("fzf-lua").lsp_references({ ignore_current_line = true })
```

### <a id="lsp-ignore-declaration">LSP references: ignore declaration</a>

`lsp_references` can be configured to exclude declaration of current symbol from results:
```lua
:lua require("fzf-lua").lsp_references({ includeDeclaration = false })
```
Combined with `ignore_current_line = true`, it achieves "show other usages" behavior.

### <a id="nth">Disable or hide filename fuzzy search</a>

By default, fuzzy searching will match the entire line which includes
filenames, it is possible to hide certain fields or leave them visible but
exclude them from the fuzzy search using fzf's `--nth` and `--with-nth`
options:

For example when using `lsp_document_symbols` matching the filename doesn't
add much value, to disable filename matching:
```lua
:lua require'fzf-lua'.lsp_document_symbols({ fzf_cli_args = '--nth 2..' })
```

To hide the filename altogether use `--with-nth`:
```lua
:lua require'fzf-lua'.lsp_document_symbols({ fzf_cli_args = '--with-nth 2..' })
```

> `man fzf` and search for `FIELD INDEX EXPRESSION` for more info

### <a id="max-perf">How do I get maximum performance out of fzf-lua?</a>

Having to extract extensions from filenames, `git status` indicators and
drawing icons all have a performance impact as well as having to deal with
ANSI coloring (fzf's `--ansi` option).

If you do not care about any of these and just want maximum speed you need to
disable both `file_icons` and `git_icons` and disable fzf's `--ansi`:

The below does this for `files` but it can obviously be done for `grep`,
`lsp`, etc and all file-based providers:
```lua
require("fzf-lua").setup({
  winopts = {
    preview = { default = 'bat_native' }
  },
  fzf_opts = { ['--ansi'] = false },
  files = {
    git_icons = false,
    file_icons = false,
  }
})

-- Alternatively, can be called be called directly or mapped to a bind
:lua require("fzf-lua").files({fzf_opts = {['--ansi']=false}, file_icons=false, git_icons=false})
```

In addition it is worth noting that the default previewer (neovim's floating
win aka "builtin") is slower than `bat` (or `cat`) previewers, to switch to
`bat` previewer set `winopts.default.preview = 'bat'` or
`winopts.default.preview = 'bat_native'`, the difference between the two is
that the former will use neovim as a proxy to the `bat` command and
`bat_native` will defer the execution of `bat` to `fzf` (hence "native").

Due to the same reasoning as above `live_grep_native` may be a bit faster than
`live_grep` as the latter needs to call neovim for each keystroke in order to
save the search term for the `resume` option. `live_grep_native`
is the closest as possible to a pure shell/terminal version.

### <a id="media-preview">Can fzf-lua preview media files?</a>

Yes! it's possible to preview media files with the `builtin` previewer. To do
so you will need to configure `previewer.builtin.extensions` with a shell
command per extension, the shell command will then run in a neovim terminal
buffer inside the preview window.

For example, the below configures `png` files to open with
[`viu`](https://github.com/atanunq/viu) and `jpg` files to open with
[`ueberzug`](https://github.com/seebye/ueberzug):

```lua
require("fzf-lua").setup({
  previewers = {
    builtin = {
      extensions = {
        -- neovim terminal only supports `viu` block output
        ["png"] = { "viu", "-b" },
        ["jpg"] = { "ueberzug" },
      }      
      -- When using 'ueberzug' we can also control the way images
      -- fill the preview area with ueberzug's image scaler, set to:
      --   false (no scaling), "crop", "distort", "fit_contain",
      --   "contain", "forced_cover", "cover"
      -- For more details see:
      -- https://github.com/seebye/ueberzug
      ueberzug_scaler = "cover",
    }
  },
})
```

Below is an example of using `ueberzug` with `cover` scaling:

![MediaDemo](https://raw.githubusercontent.com/wiki/ibhagwan/fzf-lua/demo-media.gif)


#### List of command line utilities for terminal image previews

| Type | Name | Linux | Mac | Comments |
| ---- | -----| ----- | --- | -------- |
|Images|[`viu`](https://github.com/atanunq/viu)|:heavy_check_mark:|:heavy_check_mark:||
|Images|[`ueberzugpp`](https://github.com/jstkdng/ueberzugpp)|:heavy_check_mark:|:x:|Requires X11|
|Images|[`termpix`](https://github.com/hopey-dishwasher/termpix)|:heavy_check_mark:|:heavy_check_mark:||
|Images|[`kitty imgcat`](https://github.com/kovidgoyal/kitty)|:x:|:x:|Does not work inside neovim terminal, see https://github.com/kovidgoyal/kitty/issues/413|
|Images|[`iTerm2 imgcat`](https://iterm2.com/3.2/documentation-utilities.html)|:x:|:x:|Does not work inside neovim terminal, see https://github.com/neovim/neovim/issues/4349|

#### List of command line utilities for image generation

>For more information see [`vifmimg`](https://github.com/cirala/vifmimg),
>[`ranger` Wiki](https://github.com/ranger/ranger/wiki/Image-Previews)

| Type | Name | Linux | Mac |
| ---- | -----| ----- | --- |
|Videos|[`ffmpegthumbnailer`](https://github.com/dirkvdb/ffmpegthumbnailer)|:heavy_check_mark:|:heavy_check_mark:|
|ePub|[`epub-thumbnailer`](https://github.com/marianosimone/epub-thumbnailer)|:heavy_check_mark:|:heavy_check_mark:|
|PDF|[`pdftoppm`](https://github.com/davidben/poppler/blob/master/utils/pdftoppm.1)|:heavy_check_mark:|:heavy_check_mark:|
|Font|[`fontpreview`](https://github.com/sdushantha/fontpreview)|:heavy_check_mark:|:heavy_check_mark:|
|djvu|[`ddjvu`](http://djvu.sourceforge.net/doc/man/ddjvu.html)|:heavy_check_mark:|:heavy_check_mark:|

### <a id="big-project-workflow">A recommended workflow for big projects</a>

![CtrlGWorkflow](https://raw.githubusercontent.com/wiki/ibhagwan/fzf-lua/demo-ctrlg.gif)


### <a id="prevent-flash-resize">Prevent window flashing during size change</a>

With https://github.com/ibhagwan/fzf-lua/commit/addb648ffe152c353232e8a88ff1364cbcf1ed1b it's now possible to have a single-frame, correct render of the window with set size.

An example, for `:F files`

```lua
return {
    "https://github.com/ibhagwan/fzf-lua",
    lazy = false,
    config = function()
        _G.rendered = false
        local fzf = require("fzf-lua")
        fzf.setup({
            files = {
                git_icons = true,
                cwd_header = false,
                cwd_prompt = true,
                winopts = {
                    width = 0.5,
                    height = 0.1,
                    hide = true,
                    on_close = function()
                        _G.rendered = false
                    end,
                },
                actions = {
                    result = {
                        fn = function(idx)
                            if not _G.rendered then
                                local fzf_match_cnt = tonumber(unpack(idx))
                                local w = require('fzf-lua.utils').fzf_winobj()
                                w._o.winopts.width = 0.5
                                w._o.winopts.height = math.min(50, fzf_match_cnt + 1)
                                w._o.winopts.hide = false
                                w:redraw()
                                _G.rendered = true
                            end
                        end,
                        exec_silent = true,
                        field_index = '$FZF_MATCH_COUNT',
                    },
                },
            },
    })
    end
}
```


### <a id="lsp-workspace-wtf">Workspace LSP symbols do not work</a>

You may encounter the error "`[Fzf-lua] No workspace symbols found`" and experience reset syntax highlighting in the current buffer, even with a connected and correctly configured LSP.

This occurs because some language servers (e.g. `basedpyright`) require an initial query before returning results. In these cases, using `fzf.lsp_live_workspace_symbols()` should resolve the problem.

Reference: [#1886](https://github.com/ibhagwan/fzf-lua/issues/1886)

### <a id="harpoon-picker">How can I show harpoon files with the fzf-lua picker?</a>

![image](https://github.com/user-attachments/assets/8b96828e-01d6-4d4d-8a8b-bb85d0ab8797)

To integrate Harpoon with fzf-lua, add the following function to your Harpoon configuration:

```
            {
        "<leader>fe",
        function()
          local harpoon = require("harpoon")
          local fzf = require("fzf-lua")
          local list = harpoon:list()
          local items = {}
          for i = 1, list:length() do
            local item = list:get(i)
            if item and item.value and item.value ~= "" then
              table.insert(items, string.format("%d: %s", i, item.value)) -- skip empty lines if deletion didn't functional properly
            end
          end
          fzf.fzf_exec(items, {
            prompt = "Harpoon Files> ",
            winopts = {
              width = 0.4,
              height = 0.4,
            },

            fzf_opts = {
              ["--preview"] = "bat --style=numbers --color=always $(echo {} | sed 's/^\\([0-9]\\+\\): //')",
            },
            actions = {
              ["default"] = function(selected)
                local idx = tonumber(selected[1]:match("^(%d+):"))
                if idx then
                  list:select(idx)
                end
              end,
              ["ctrl-d"] = function(selected)
                local idx = tonumber(selected[1]:match("^(%d+):"))
                if idx then
                  local item = list:get(idx)
                  list:remove(item)
                end
              end,
            },
          })
        end,
        desc = "Harpoon FZF Menu",
      },

```

This will provide a more beautiful picker, while keeping its original functionality: you can remove Harpoon'd files with ctrl-d. 


