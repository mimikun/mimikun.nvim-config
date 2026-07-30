# termfile.nvim

## How it continues a session

A `.term` file is not a script or a log — it's the **raw byte stream** the
terminal produced (escape sequences, colors, and all). Reopening the file feeds
that stream back into a terminal, which re-renders it natively. Two facts are
worth being clear about:

- The shell **process** is genuinely killed when Neovim quits — Unix can't
  snapshot and thaw a running process. So reopening starts a *new* shell.
- The replayed output is the previous session's *picture*. To make that picture
  honest, the new shell is launched in the previous working directory, which
  travels inside the recording itself as an invisible
  [OSC 7](https://gitlab.freedesktop.org/terminal-wg/specifications/-/issues/20)
  escape (the standard "here's my directory" sequence). No side-channel metadata.

## Features

- **Open a `.term` file → get a terminal.** The raw recording is never shown as
  text; the buffer becomes a live terminal instead.
- **Colored history.** Because we record and replay the raw stream, restored
  history keeps its original colors — the terminal recolors it for free.
- **Keeps its filename.** The buffer stays named `watcher.term`, so Telescope /
  fzf-lua / `:find` / grep all treat it normally.
- **A real terminal buffer.** It's a genuine built-in terminal, so it behaves
  like one: no line numbers, non-editable output, automatic resize — and it
  fires `TermOpen`, so terminal plugins attach to it (see below).
- **Working directory continuity.** The last cwd is embedded in the recording
  and restored on reopen.
- **No external dependencies.** Uses Neovim's built-in terminal with an
  `on_stdout` tap to record the raw stream — no `script`, no daemon.
- **Zero config, zero commands.** Nothing to call, nothing to remember.

## Requirements

- Neovim 0.10+ (uses `jobstart({ term = true })`)
- Working-directory restore uses `/proc` (Linux). On other platforms cwd is
  restored only if your shell itself emits OSC 7; otherwise the new shell starts
  in the `.term` file's directory. Everything else works everywhere.

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "TheLazyCat00/termfile-nvim" }
```

With [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use "TheLazyCat00/termfile-nvim"
```

That's it — no `config`/`setup` call is required.

## Usage

```vim
:e watcher.term
```

or, from your shell:

```sh
nvim watcher.term
```

A terminal opens. Use it like any terminal. Quit Neovim whenever you like — the
next time you open `watcher.term`, its output is replayed (in color) and you're
back in a shell in the same working directory.

Create as many as you want (`build.term`, `logs.term`, `server.term`, …). Each
is an independent, revivable session that your file picker can jump to.

## Configuration

Configuration is entirely optional. To override a default, call `setup`:

```lua
require("termfile").setup({
  -- Shell to launch. nil = Neovim's 'shell'. String or list.
  shell = nil,

  -- Replay the recorded output when reopening a .term file.
  restore = true,

  -- Inserted between restored output and the new shell prompt.
  -- Use "" to append the prompt directly, as in earlier versions.
  delimiter = "\n",

  -- Max bytes of recorded output kept per file (older output trimmed).
  max_bytes = 256 * 1024,

  -- Enter terminal insert-mode automatically when a .term buffer is focused.
  start_insert = false,

  -- Restore number/relativenumber from Neovim's global option defaults after
  -- a .term buffer leaves a window. This follows values set with vim.opt.
  default_win_opts = "global",

  -- Alternatively, apply explicit window-local values:
  -- default_win_opts = { number = true, relativenumber = true },

  -- Persist output on unload / write / exit.
  auto_save = true,

  -- Glob identifying terminal-session files.
  pattern = "*.term",
})
```

## A note on full-screen programs

Because replay reproduces the raw stream literally, a session that ended inside
a full-screen TUI (`vim`, `htop`, …) or right after `clear` will replay those
control sequences too — so its restored "history" may look sparse or blank. For
ordinary shell work (builds, logs, git) it round-trips faithfully, colors and
all.

## Terminal plugin compatibility

Because a `.term` buffer is a real built-in terminal, plugins that hook
`TermOpen` and drive the shell through `vim.bo.channel` work with it
unchanged. For example, [editable-term.nvim](https://github.com/xb-bx/editable-term.nvim)
(Neovim motions inside terminals) attaches automatically — no extra
configuration on either side.

### Snacks picker window priority

[Snacks picker](https://github.com/folke/snacks.nvim) normally excludes buffers
whose `buftype` is `terminal` when it chooses the main window for an opened
file. Consequently, invoking a picker while focused in a terminal can make the
file open in another eligible window or in a new split instead of replacing the
terminal.

termfile.nvim marks every managed buffer with `b:snacks_main = true`. Snacks
checks this explicit preference before its terminal-buffer filter, so a file
selected while a `.term` window is focused can replace that terminal normally.
The marker is harmless when Snacks is not installed and requires no user
configuration.
