-- check-tool-litter.lua - Find formatters and linters that write into the
-- working directory.
--
-- Run via the wrapper (recommended, cds to repo root first):
--   scripts/check-tool-litter.sh
-- or directly:
--   nvim --headless -l scripts/check-tool-litter.lua [tool]...
--
-- Why
--   Tools are supposed to put caches and scratch files under XDG_CACHE_HOME or
--   a temp directory. Plenty of them default to the current directory instead:
--   rumdl drops ./.rumdl_cache on every run, and it took two separate fixes to
--   notice, because Neovim runs these tools with the cwd set to whatever the
--   user happens to be editing in. The offenders are only discoverable by
--   running each tool and looking, so this does exactly that.
--
-- How
--   Every formatter in `plugins.conform-nvim.opts.formatters_by_ft` and every
--   linter in `plugins.nvim-lint.opts` is resolved to the exact argv this
--   config would run (overrides included, via conform's own `build_cmd` and
--   `plugins.nvim-lint.apply_overrides`), then executed inside a fresh empty
--   directory with a small sample file on stdin. Anything left behind in that
--   directory afterwards is reported.
--
-- What it reports
--   LITTER  - tool created the listed entries in the working directory.
--   skipped - tool is not installed on this host, or its argv could not be
--             resolved. Skips are not failures; the toolchain intentionally
--             names more tools than any one machine installs.
--
--   A clean result is only evidence for the sample input used here. A tool that
--   writes its cache only on a cache miss for a real project may still be
--   quiet against a one-line sample.
--
-- Exit code: 0 when nothing littered, 1 when any tool did.

local TIMEOUT_MS = 15000

-- Extensions for filetypes whose name is not already the extension. Anything
-- absent falls through to the filetype name, which is correct for lua, sh,
-- json, toml, and most others.
local EXTENSIONS = {
  bash = "sh",
  bib = "bib",
  cmake = "cmake",
  dockerfile = "Dockerfile",
  eruby = "erb",
  gitcommit = "COMMIT_EDITMSG",
  javascript = "js",
  javascriptreact = "jsx",
  make = "Makefile",
  markdown = "md",
  python = "py",
  ruby = "rb",
  rust = "rs",
  systemverilog = "sv",
  typescript = "ts",
  typescriptreact = "tsx",
  verilog = "v",
  vim = "vim",
  yaml = "yaml",
  zsh = "zsh",
}

-- Filetypes whose sample must parse for the tool to get far enough to write
-- anything. A blank line is enough everywhere else.
local SAMPLES = {
  json = "{}\n",
  lua = "local x = 1\n",
  markdown = "# a\n\nfoo\n",
  python = "x = 1\n",
  sh = "x=1\n",
  toml = "x = 1\n",
  yaml = "x: 1\n",
}

local repo_root = vim.fn.getcwd()
vim.opt.runtimepath:prepend(repo_root)

local lazy_root = vim.fn.stdpath("data") .. "/lazy"
vim.opt.runtimepath:append(lazy_root .. "/conform.nvim")
vim.opt.runtimepath:append(lazy_root .. "/nvim-lint")

local ok_conform, conform = pcall(require, "conform")
local ok_runner, runner = pcall(require, "conform.runner")
local ok_lint, lint = pcall(require, "lint")

if not (ok_conform and ok_runner and ok_lint) then
  io.stderr:write("conform.nvim and nvim-lint must be installed; run :Lazy install first\n")
  os.exit(2)
end

local conform_opts = require("plugins.conform-nvim.opts")
local lint_opts = require("plugins.nvim-lint.opts")

conform.setup(conform_opts)
lint.linters_by_ft = lint_opts.linters_by_ft
require("plugins.nvim-lint.apply_overrides")(lint, lint_opts.linters)

--- Every tool this config can run, each paired with one filetype it applies to.
--- The filetype only decides the sample file's name and contents.
---@return { name: string, kind: string, filetype: string }[]
local function collect_tools()
  local seen = {}
  local tools = {}

  local function add(name, kind, filetype)
    if type(name) ~= "string" or seen[name] then
      return
    end

    seen[name] = true
    table.insert(tools, { name = name, kind = kind, filetype = filetype })
  end

  for filetype, names in pairs(conform_opts.formatters_by_ft or {}) do
    -- Entries may be a plain list, or carry `stop_after_first` alongside it.
    for _, name in ipairs(names) do
      add(name, "formatter", filetype)
    end
  end

  for filetype, names in pairs(lint_opts.linters_by_ft or {}) do
    for _, name in ipairs(names) do
      add(name, "linter", filetype)
    end
  end

  -- extra_linters is a function of the buffer; the GitHub Actions branch keys
  -- off the buffer name, so ask it with a path that takes that branch too.
  local probe = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(probe, "/tmp/.github/workflows/probe.yaml")

  for _, name in ipairs(lint_opts.extra_linters(probe)) do
    add(name, "linter", "yaml")
  end

  vim.api.nvim_buf_delete(probe, { force = true })

  table.sort(tools, function(a, b)
    return a.name < b.name
  end)

  return tools
end

---@param filetype string
---@return string filename, string content
local function sample_for(filetype)
  local ext = EXTENSIONS[filetype] or filetype
  local filename = ext:match("^%u") and ext or ("sample." .. ext)

  return filename, SAMPLES[filetype] or "\n"
end

--- Resolve the argv this config would actually run for `tool`.
---@param tool table
---@param filepath string
---@param bufnr integer
---@return string[]|nil argv, string|nil err
local function resolve_argv(tool, filepath, bufnr)
  if tool.kind == "formatter" then
    local config = conform.get_formatter_config(tool.name, bufnr)

    if not config then
      return nil, "no formatter config"
    end

    if config.format then
      return nil, "lua formatter, runs in-process"
    end

    local ctx = {
      buf = bufnr,
      filename = filepath,
      dirname = vim.fs.dirname(filepath),
    }

    local ok, argv = pcall(runner.build_cmd, tool.name, ctx, config)

    return ok and argv or nil, ok and nil or tostring(argv)
  end

  local linter = lint.linters[tool.name]

  -- A few built-in definitions are functions that build the linter per call;
  -- there is no static argv to inspect for those.
  if type(linter) ~= "table" then
    return nil, "no static linter definition"
  end

  local cmd = linter.cmd

  if type(cmd) == "function" then
    local ok, resolved = pcall(cmd)

    if not ok then
      return nil, "cmd() failed"
    end

    cmd = resolved
  end

  local argv = { cmd }

  for _, arg in ipairs(linter.args or {}) do
    if type(arg) == "function" then
      local ok, resolved = pcall(arg)

      if not ok then
        return nil, "arg() failed"
      end

      arg = resolved
    end

    -- An arg function may return a list, or nil to drop itself.
    if type(arg) == "table" then
      vim.list_extend(argv, arg)
    elseif arg ~= nil then
      table.insert(argv, tostring(arg))
    end
  end

  return argv
end

---@param dir string
---@return string[]
local function entries_in(dir)
  local names = {}

  for name in vim.fs.dir(dir) do
    table.insert(names, name)
  end

  table.sort(names)

  return names
end

-- Optional positional arguments narrow the run to the named tools. `nvim -l`
-- leaves them in v:argv after the script path rather than in argv().
local only = {}

do
  local argv = vim.v.argv
  local script_index

  for i, value in ipairs(argv) do
    if value:match("check%-tool%-litter%.lua$") then
      script_index = i
      break
    end
  end

  for i = (script_index or #argv) + 1, #argv do
    only[argv[i]] = true
  end
end

local tools = collect_tools()
local littered = {}
local skipped = {}
local checked = 0

for _, tool in ipairs(tools) do
  if next(only) == nil or only[tool.name] then
    local dir = vim.fn.tempname()
    vim.fn.mkdir(dir, "p")

    local filename, content = sample_for(tool.filetype)
    local filepath = dir .. "/" .. filename
    local before = { [filename] = true }

    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(bufnr, filepath)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(content, "\n"))
    vim.api.nvim_set_current_buf(bufnr)
    vim.fn.writefile(vim.split(content, "\n", { trimempty = true }), filepath)

    local argv, err = resolve_argv(tool, filepath, bufnr)

    if argv and vim.fn.executable(argv[1]) == 1 then
      checked = checked + 1

      pcall(function()
        vim
          .system(argv, {
            cwd = dir,
            stdin = content,
            text = true,
            timeout = TIMEOUT_MS,
          })
          :wait()
      end)

      local leftovers = vim.tbl_filter(function(name)
        return not before[name]
      end, entries_in(dir))

      if #leftovers > 0 then
        table.insert(littered, {
          name = tool.name,
          kind = tool.kind,
          entries = leftovers,
        })
      end
    else
      table.insert(skipped, {
        name = tool.name,
        reason = err or "not installed",
      })
    end

    vim.api.nvim_buf_delete(bufnr, { force = true })
    vim.fn.delete(dir, "rf")
  end
end

if #littered > 0 then
  print("LITTER - these tools wrote into the working directory:")
  print("")

  for _, entry in ipairs(littered) do
    print(("  %-24s (%s)  %s"):format(entry.name, entry.kind, table.concat(entry.entries, ", ")))
  end

  print("")
  print("Point each one at a cache directory outside the cwd, or disable its cache.")
  print("Both are per-tool: a CLI flag via `append_args`, or an env var in lua/config/.")
end

print("")
print(("checked %d tool(s), skipped %d (not installed or no resolvable argv)"):format(checked, #skipped))

if os.getenv("CHECK_TOOL_LITTER_VERBOSE") then
  for _, entry in ipairs(skipped) do
    print(("  skipped %-24s %s"):format(entry.name, entry.reason))
  end
end

os.exit(#littered > 0 and 1 or 0)
