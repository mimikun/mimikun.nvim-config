---@module "conform"
---@type conform.setupOpts
local opts = {
  -- Map of filetype to formatters
  formatters_by_ft = {
    -- Config / shell
    lua = { "stylua" },
    fish = { "fish_indent" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "beautysh" },
    -- Data / markup
    toml = { "tombi" },
    yaml = { "yamlfmt" },
    json = { "jq" },
    xml = { "xmlformat" },
    markdown = { "rumdl" },
    -- Systems / compiled
    rust = { "rustfmt" },
    -- Conform will run multiple formatters sequentially (imports first, then gofmt)
    go = { "goimports", "gofmt" },
    zig = { "zigfmt" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    -- The Neovim filetype for C# is `cs`, not `c_sharp`
    cs = { "clang_format" },
    kotlin = { "ktlint" },
    scala = { "scalafmt" },
    java = { "google-java-format" },
    dart = { "dart_format" },
    swift = { "swift_format" },
    -- Scripting / dynamic
    python = { "ruff_format" },
    ruby = { "rubocop" },
    -- The Neovim filetype for ERB is `eruby`
    eruby = { "erb_format" },
    perl = { "perltidy" },
    php = { "php_cs_fixer" },
    -- Web front-end
    javascript = { "biome" },
    typescript = { "biome" },
    css = { "biome" },
    scss = { "biome" },
    html = { "superhtml" },
    vue = { "prettier" },
    svelte = { "prettier" },
    astro = { "prettier" },
    templ = { "templ" },
    -- Functional / ML-family
    haskell = { "fourmolu" },
    cabal = { "cabal_fmt" },
    ocaml = { "ocamlformat" },
    elixir = { "mix" },
    elm = { "elm_format" },
    gleam = { "gleam" },
    fennel = { "fnlfmt" },
    -- Infra / config-as-code
    nix = { "nixfmt" },
    sql = { "sqlfluff" },
    terraform = { "terraform_fmt" },
    hcl = { "hcl" },
    cmake = { "gersemi" },
    nginx = { "nginxfmt" },
    kdl = { "kdlfmt" },
    just = { "just" },
    -- Typesetting
    -- The Neovim filetype for LaTeX/.tex is `tex`
    tex = { "tex-fmt" },

    -- Use the "*" filetype to run formatters on all filetypes.
    -- Disabled: as a conform formatter, typos runs with `--write-changes` and
    -- auto-"fixes" default-dictionary false positives (e.g. Clojure `edn` ->
    -- `end`), corrupting files on save. Typo checking is a linter's job, not a
    -- formatter's; it will move to nvim-lint (planned), which only reports
    -- diagnostics without rewriting the buffer. Kept here for reference.
    -- ["*"] = { "typos" },

    -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- Set this to change the default values when calling conform.format()
  -- This will also affect the default values for format_on_save/format_after_save
  default_format_opts = {
    lsp_format = "fallback",
  },

  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_on_save = function(bufnr)
    -- Disable autoformat on certain filetypes
    local ignore_filetypes = {
      "sql",
      "java",
    }

    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if bufname:match("/node_modules/") then
      return
    end

    return {
      lsp_format = "fallback",
      timeout_ms = 500,
    }
  end,

  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = function(bufnr)
    -- There is a similar affordance for format_after_save, which uses BufWritePost.
    -- This is good for formatters that are too slow to run synchronously.
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return {
      lsp_format = "fallback",
    }
  end,

  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,

  -- Conform will notify you when a formatter errors
  notify_on_error = true,

  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,

  -- Custom formatters and overrides for built-in formatters
  formatters = {
    shfmt = {
      append_args = {
        "-i",
        "2",
      },
    },
  },
}

return opts
