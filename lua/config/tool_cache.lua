-- Point tools that default their cache at the current directory somewhere else.
--
-- Why
--   Neovim runs formatters, linters and language servers with the cwd set to
--   whatever the user happens to be editing in, so a tool that caches into `.`
--   scatters directories through every project it touches. rumdl defaults to
--   ./.rumdl_cache and needed two separate fixes before it was noticed, one per
--   call path (conform, then nvim-lint), with a third path (its language server)
--   still uncovered.
--
--   Per-call-path CLI flags cannot close that off: the number of places to
--   remember is tools x call paths, and a new call path silently reopens the
--   hole. The process environment is one place that covers every path at once,
--   including servers this config does not pass arguments to.
--
--   The trade-off is that a `rumdl` typed into a :terminal inherits this too. It
--   caches under stdpath("cache") instead of the cwd, which is the behaviour
--   wanted there as well.
--
-- Adding a tool
--   Add its cache environment variable below. Run `task check-tool-litter` to
--   find out which tools need it: it runs every configured formatter and linter
--   in an empty directory and reports what each leaves behind.

local host = require("config.host")

-- Tool cache environment variable -> directory under stdpath("cache").
local dirs = {
  -- rumdl: markdown formatter (conform), linter (nvim-lint) and language server.
  RUMDL_CACHE_DIR = "rumdl",
}

for name, dir in pairs(dirs) do
  vim.env[name] = host.paths.cache .. "/" .. dir
end
