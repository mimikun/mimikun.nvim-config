<div align="center">

# yankdown.nvim

**Smart paste for Markdown in Neovim**

[![CI](https://img.shields.io/github/actions/workflow/status/ntk148v/yankdown.nvim/ci.yml?branch=main&style=flat-square&label=CI&labelColor=0f172a&color=3dbbff)](https://github.com/ntk148v/yankdown.nvim/actions) [![Lua](https://img.shields.io/badge/lua-5.1-3dbbff?style=flat-square&logo=lua&logoColor=white&labelColor=0f172a)](https://lua.org) [![Neovim](https://img.shields.io/badge/neovim-0.10%2B-79f2e6?style=flat-square&logo=neovim&logoColor=white&labelColor=0f172a)](https://neovim.io) [![License](https://img.shields.io/badge/license-MIT-b253f5?style=flat-square&labelColor=0f172a)](LICENSE) [![Stars](https://img.shields.io/github/stars/ntk148v/yankdown.nvim?style=flat-square&labelColor=0f172a&color=ff79f2)](https://github.com/ntk148v/yankdown.nvim/stargazers)

</div>

- [Overview](#overview)
- [Demo](#demo)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Setup](#setup)
- [Usage](#usage)
  - [Commands](#commands)
  - [Lua](#lua)
  - [Keymaps](#keymaps)
  - [Plug mappings](#plug-mappings)
  - [Optional paste interception](#optional-paste-interception)
- [Fallback behavior](#fallback-behavior)
- [How it works](#how-it-works)
- [Architecture](#architecture)
- [Development](#development)

## Overview

We're past peak prose. Every LLM outputs Markdown. Every answer, every code review, every draft — it's all `## headings`, `- lists`, and ``` backticks. You copy from a browser, a doc, an AI chat — and Neovim gets raw HTML or rich text. Which you then clean by hand. In 2026. While your AI writes in GFM natively.

`yankdown.nvim` fixes that. It pastes rich content from browsers, Google Docs, or Word into Neovim as clean GitHub Flavored Markdown — no intermediate file, no manual conversion.

It reads HTML from the system clipboard, pipes it through `pandoc`, and inserts the result at the cursor. When HTML is unavailable or a required tool is missing, it falls back to native paste transparently.

## Demo

Copy the content from <https://pandoc.org/> and simply paste using yankdown.nvim.

![demo](assets/demo.gif)

_Recording generated with [VHS](https://github.com/charmbracelet/vhs) — see [`assets/demo.tape`](assets/demo.tape)._

## Features

- **Clipboard HTML → GFM** — paste rich content as clean Markdown, not raw HTML.
- **Auto-fallback** — native paste when HTML is absent, pandoc is missing, or the platform is unsupported.
- **One-time warnings** — `vim.notify` fires once per missing tool, then stays quiet.
- **Multiple paste targets** — normal (after/before cursor), visual (replace selection), insert (at cursor).
- **Optional paste interception** — `p`/`P` auto-override in Markdown buffers only (buffer-local, filetype-scoped).
- **Plug mappings** — `<Plug>(yankdown-paste-after)` and `<Plug>(yankdown-paste-before)` for custom keybindings.
- **Dependency check** — cached diagnostics plus `:YankdownCheck` for missing tools (`pandoc`, `xclip`, `wl-paste`, …) without noisy startup warnings.

## Requirements

| Dependency                    | Version | Purpose                                 |
| ----------------------------- | ------- | --------------------------------------- |
| Neovim                        | 0.10+   | Uses `vim.system` for async shell calls |
| [pandoc](https://pandoc.org/) | any     | HTML to GFM conversion engine           |

Clipboard providers

| Platform | Tool             | Notes                                          |
| -------- | ---------------- | ---------------------------------------------- |
| macOS    | `osascript`      | Built-in                                       |
| Wayland  | `wl-paste`       | From `wl-clipboard` package                    |
| X11      | `xclip`          |                                                |
| Windows  | `powershell.exe` | Built-in PowerShell clipboard access (CF_HTML) |

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "ntk148v/yankdown.nvim",
  opts = {},  -- calls setup() automatically
}
```

With [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'ntk148v/yankdown.nvim'
```

With [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use 'ntk148v/yankdown.nvim'
```

## Setup

```lua
require("yankdown").setup({
  auto_intercept = false,  -- override p/P in Markdown buffers
  notify = true,           -- warn once on paste fallback/conversion failure
  check = "lazy",          -- cache dependency check on first Markdown paste
})
```

Options

| Key              | Default  | Description                                                                                                                         |
| ---------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `auto_intercept` | `false`  | Buffer-local `p`/`P` override for Markdown filetype only.                                                                           |
| `notify`         | `true`   | One-time `vim.notify` on paste fallback/conversion failures.                                                                        |
| `check`          | `"lazy"` | Cache dependency status on first Markdown paste. Use `"startup"` to cache during `setup()`, or `false` to disable proactive checks. |

## Usage

### Commands

```vim
:YankdownPaste       " paste after cursor
:YankdownPaste!      " paste before cursor
:YankdownCheck       " display dependency status
```

### Lua

```lua
require("yankdown").paste({ direction = "after" })
require("yankdown").paste({ direction = "before" })
```

### Keymaps

```lua
vim.keymap.set({ "n", "x", "i" }, "<leader>p", function()
  require("yankdown").paste({ direction = "after" })
end)
```

### Plug mappings

```vim
:map <leader>p <Plug>(yankdown-paste-after)
:map <leader>P <Plug>(yankdown-paste-before)
```

### Optional paste interception

Enable automatic interception of `p` and `P` in Markdown buffers:

```lua
require("yankdown").setup({
  auto_intercept = true,
})
```

This creates buffer-local mappings only for `filetype=markdown`. No global keys are touched.

## Fallback behavior

Native paste (as if yankdown.nvim were not installed) is used when:

| Condition                            | Notification                 |
| ------------------------------------ | ---------------------------- |
| Buffer is not Markdown               | Silent                       |
| Clipboard has no HTML                | Silent                       |
| Platform/provider unsupported        | Warn once if `notify = true` |
| Clipboard tool missing               | Warn once if `notify = true` |
| `pandoc` missing or conversion fails | Warn once if `notify = true` |

## How it works

```
Paste invoked
  ├─ Markdown buffer? ─── no ──→ Native paste
  └─ yes
      ├─ Clipboard has HTML? ─── no ──→ Native paste
      └─ yes
          ├─ Platform supported? ─── no ──→ Warn once → Native paste
          └─ yes
              ├─ Read HTML from clipboard
              ├─ Pipe through pandoc
              ├─ pandoc succeeds? ─── no ──→ Warn once → Native paste
              └─ yes
                  └─ Insert GFM at cursor
```

## Architecture

```
┌─ User ─────────────────────────────────┐
│  Keymap / Command                       │
└──────────┬──────────────────────────────┘
           │
┌──────────▼──────────────────────────────┐
│  yankdown.nvim                          │
│  ┌────────────────────────────────────┐ │
│  │ init.lua    setup, command, plugs  │ │
│  │ paste.lua   orchestrator           │ │
│  │ clipboard.lua  provider detection  │ │
│  │               HTML read            │ │
│  │ convert.lua   pandoc wrapper       │ │
│  │ native.lua    fallback passthrough │ │
│  └────────────────────────────────────┘ │
└──────────┬──────────────────────────────┘
           │
┌──────────▼──────────────────────────────┐
│  System                                 │
│  osascript / wl-paste / xclip / pwsh    │
│  pandoc                                 │
└─────────────────────────────────────────┘
```

## Development

```sh
# Run tests
nvim --headless -c "luafile tests/run.lua" -c "q"
```

Project layout:

- `lua/yankdown/init.lua` — entry point, setup, command registration.
- `lua/yankdown/paste.lua` — orchestration, mode detection, insert logic.
- `lua/yankdown/clipboard.lua` — platform detection, HTML clipboard read.
- `lua/yankdown/convert.lua` — `pandoc` invocation.
- `lua/yankdown/native.lua` — fallback native paste.
- `lua/yankdown/check.lua` — pre-flight dependency check.
- `tests/` — minitest-based test suite.
