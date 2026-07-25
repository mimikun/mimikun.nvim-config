-- Filetypes to remove from a server's default `filetypes` list.

-- Use this for servers that are worth keeping globally but are pure noise on one filetype.
-- The server stays installed and still attaches everywhere else.

-- codebook (spell check) and harper_ls (english grammar) both claim markdown
-- and both report the same project nouns -- `kiro`, `SDLC`, `subagent`, `md` --
-- as misspellings, so a markdown buffer opens with dozens of duplicated
-- INFO/HINT diagnostics and effectively no signal.
-- Prose checking is kept for the other filetypes they cover (gitcommit, comments in source files).

---@type table<string, string[]>
local exclude_filetypes = {
  codebook = {
    "markdown",
  },
  harper_ls = {
    "markdown",
  },
}

return exclude_filetypes
