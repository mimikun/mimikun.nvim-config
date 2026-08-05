---@type table
local opts = {
  -- Map of filetype to linters.

  -- nvim-lint has no `["*"]` filetype:
  -- `_resolve_linter_by_ft` only looks up the buffer's own filetype (splitting compound ones like `yaml.ghaction` on dots).
  -- Linters that have to run everywhere live in `extra_linters` below.

  -- The toolchain mirrors `plugins.conform-nvim.opts` wherever both sides ship a tool for the same filetype, so formatting and linting never disagree about style.
  -- Filetypes conform formats but nvim-lint has no linter for (xml, cs, scala, dart, cabal, ocaml, elm, gleam, hcl, nginx, kdl, just, templ) are omitted rather than filled with an unrelated tool.
  linters_by_ft = {
    -- Config / shell
    -- selene is also this repo's own linter, configured by ./selene.toml
    lua = { "selene" },
    fish = { "fish" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "zsh" },
    -- Data / markup
    toml = { "tombi" },
    yaml = { "yamllint" },
    json = { "jsonlint" },
    markdown = { "rumdl" },
    -- Systems / compiled
    rust = { "clippy" },
    go = { "golangcilint" },
    zig = { "zlint" },
    c = { "cppcheck" },
    cpp = { "cppcheck" },
    kotlin = { "ktlint" },
    java = { "checkstyle" },
    swift = { "swiftlint" },
    -- Scripting / dynamic
    python = { "ruff" },
    ruby = { "rubocop" },
    -- The Neovim filetype for ERB is `eruby`
    eruby = { "erb_lint" },
    perl = { "perlcritic" },
    php = { "phpcs" },
    -- Web front-end
    javascript = { "biomejs" },
    typescript = { "biomejs" },
    css = { "biomejs" },
    -- biome has no SCSS support, so this is the one spot where linting and formatting use different tools
    scss = { "stylelint" },
    html = { "htmlhint" },
    vue = { "eslint" },
    svelte = { "eslint" },
    astro = { "eslint" },
    -- Functional / ML-family
    haskell = { "hlint" },
    elixir = { "credo" },
    fennel = { "fennel" },
    -- Infra / config-as-code
    nix = { "statix", "deadnix" },
    sql = { "sqlfluff" },
    terraform = { "tflint" },
    cmake = { "cmakelint" },
    -- Typesetting
    -- The Neovim filetype for LaTeX/.tex is `tex`
    tex = { "chktex" },
    -- Lint-only: nothing in conform covers these
    dockerfile = { "hadolint" },
    make = { "checkmake" },
    vim = { "vint" },
    gitcommit = { "gitlint" },
  },

  -- Linters that run regardless of `linters_by_ft`, decided per buffer.
  ---@param bufnr integer
  ---@return string[]
  extra_linters = function(bufnr)
    -- typos is the reason this plugin exists: it used to run as a conform formatter over `["*"]` with `--write-changes` and corrupted files on save.
    -- As a linter it only reports.
    local names = {
      "typos",
    }

    -- actionlint and zizmor only make sense on GitHub Actions workflows.
    -- Upstream suggests a `yaml.ghaction` filetype pattern, but a compound filetype changes which language servers attach to the buffer;
    -- matching the path keeps the effect contained to linting.
    if vim.api.nvim_buf_get_name(bufnr):match("/%.github/workflows/") then
      vim.list_extend(names, {
        "actionlint",
        "zizmor",
      })
    end

    return names
  end,

  -- Overrides for built-in linter definitions.
  -- `append_args` mirrors the key of the same name in `plugins.conform-nvim.opts`.
  linters = {
    typos = {
      -- The default dictionary rewrites `edn` -> `end`, which is wrong for Clojure EDN.
      -- `--config` merges with a project-local `_typos.toml` rather than replacing it, so per-project settings still apply.
      append_args = {
        "--config",
        require("config.host").paths.config .. "/typos.toml",
      },
    },
  },
}

return opts
