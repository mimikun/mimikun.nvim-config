# Security Model

camouflage.nvim hides sensitive values visually by drawing over buffer text with Neovim extmarks. It does not modify, encrypt, delete, or sandbox the real file contents.

## What It Protects Against

camouflage is designed for casual on-screen exposure:

- screen sharing
- pair programming
- demos and recordings
- shoulder-surfing
- screenshots of the editor window

The original text remains in the buffer and on disk.

## What It Does Not Protect Against

Anything that reads the buffer or file contents directly can still see the real values:

- Telescope `live_grep` result rows and other grep/search tools
- LSP servers, completion sources, formatters, linters, and AI assistants
- `:%print`, command output, substitute previews, and custom scripts
- normal yanks such as `yy`, `"+y`, or `:%y`
- saved files, backups, swap files, undo files, shell history, and git history

Use `:CamouflageYank` when you intentionally need to copy a real value. It can prompt for confirmation and auto-clear the configured register.

## Mask Styles

`stars`, `dotted`, and `text` are safer choices for screen sharing because they do not reveal the original characters.

`scramble` is cosmetic, not protective. It shuffles the original characters, so it leaks the value length and character set.

## Project Config

`.camouflage.yaml` is data-only. camouflage validates and sanitizes it; it cannot register Lua functions or execute project code.

If you work with untrusted repositories, enable Neovim's trust gate:

```lua
require('camouflage').setup({
  project_config = {
    secure = true,
  },
})
```

With `secure = true`, a project config is not applied until Neovim trusts the file through `vim.secure` / `:trust`.

## Checks

Built-in local checks such as [[Weak Secret Check]] and [[JWT Expiry Hints]] run without network access.

[[Have I Been Pwned]] sends only the first five characters of a SHA-1 hash prefix to the HIBP range API and compares suffixes locally. The plaintext value is not sent.

[[Custom Check API]] functions are trusted Lua code. They receive plaintext values through `ctx.var.value`, so do not register checks from untrusted project files or third-party snippets you have not reviewed.

## Audit

[[Workspace Audit]] output is redacted. Findings include key names, locations, parser names, value lengths, and policy metadata, but not plaintext values. Audit does not run hooks or network checks.

## See Also

- [[Workspace Audit]] — redacted workspace scanning
- [[Rule Based Policy]] — data-only masking policy
- [[Custom Check API]] — trust boundaries for executable checks
