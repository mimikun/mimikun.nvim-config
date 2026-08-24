-- Files and directories to look for to detect a root directory.
-- These patterns will not affect LSP-based detection unless `lsp.use_pattern_matching` is set to `true`
-- This list is permanent, and any new entries are appended. You can leave this empty
local patterns = {
  ".git",
  ".github",
  "_darcs",
  ".hg",
  ".bzr",
  ".svn",
  "Pipfile",
  "pyproject.toml",
  ".pre-commit-config.yaml",
  ".pre-commit-config.yml",
  ".csproj",
  ".sln",
  ".nvim.lua",
  ".neoconf.json",
  "neoconf.json",
  -- To specify the root is a certain directory, prefix it with `=:`
  --"=src",
  -- To specify the root has a certain directory or file (which may be a glob), just add it to the pattern list:
  --"build/env.sh",
  --To specify the root has a certain directory as an ancestor (useful for excluding directories), prefix it with `^:`
  --"^fixtures",
  -- To specify the root has a certain directory as its direct ancestor/parent (useful when you put working projects in a common directory), prefix it with `>:`
  --">Latex"
  --To exclude a pattern, prefix it with `!:`
  --"!.git/worktrees",
  --"!=extras",
  --"!^fixtures",
  --"!build/env.sh",
}

return patterns
