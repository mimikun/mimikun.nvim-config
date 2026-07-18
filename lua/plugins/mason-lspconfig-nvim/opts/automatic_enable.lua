-- Servers to automatically enable (attach).
--
-- Allowlist form: as long as this table has NO `exclude` key, only the servers
-- listed here are enabled. Everything in `ensure_installed` stays installed but
-- never attaches. Adding an `exclude` key flips this to a denylist and makes the
-- array entries below silently inert.
-- See mason-lspconfig.nvim/lua/mason-lspconfig/features/automatic_enable.lua
--
-- Commented-out entries are installed alternatives, kept here so switching is a
-- one-line edit. Uncommenting one usually means commenting out its sibling,
-- otherwise both attach to the same filetype and diagnostics are duplicated.
---@type string[]
local automatic_enable = {
  -- NOTE: cross-language, attaches to many filetypes at once
  -- spell check
  "codebook",
  -- english grammar
  "harper_ls",
  -- formatter, inert without a dprint config file in the project
  "dprint",
  -- vulnerability scan, needs `snyk auth` or it errors on every attach
  --"snyk_ls",
  -- structural search/lint, inert without rules
  --"ast_grep",

  -- lua
  "lua_ls",
  --"emmylua_ls",
  "stylua",
  -- luau
  "luau_lsp",

  -- rust
  "rust_analyzer",
  --"bacon_ls",

  -- python
  "basedpyright",
  "ruff",
  --"pyright",
  --"ty",
  --"zuban",
  --"pyrefly",
  --"pylyzer",
  --"pylsp",
  --"jedi_language_server",
  --"pyre",

  -- javascript, javascriptreact, typescript, typescriptreact
  "vtsls",
  "eslint",
  --"ts_ls",
  --"tsgo",
  --"quick_lint_js",
  --"biome",
  --"oxlint",
  --"oxfmt",
  -- deno projects only, conflicts with vtsls
  --"denols",

  -- css, less, scss
  "cssls",
  "tailwindcss",
  --"css_variables",
  --"cssmodules_ls",
  --"somesass_ls",
  --"stylelint_lsp",
  --"unocss",

  -- html
  "html",
  "superhtml",
  -- filetype list is very broad, also attaches to markdown, php, vue, elixir
  --"htmx",
  "emmet_language_server",
  --"emmet_ls",

  -- markdown
  "marksman",
  "markdown_oxide",
  --"remark_ls",
  --"rumdl",
  --"mpls",
  --"prosemd_lsp",
  --"zk",
  -- needs an account
  --"grammarly",
  -- prose linting, overlaps harper_ls above
  --"ltex_plus",
  --"ltex",
  --"vale_ls",
  --"textlsp",
  -- markdown.mdx
  "mdx_analyzer",

  -- go, gomod, gotmpl, gowork
  "gopls",
  "golangci_lint_ls",
  -- templ
  "templ",

  -- ruby
  "ruby_lsp",
  "rubocop",
  --"solargraph",
  --"sorbet",
  --"steep",
  --"standardrb",
  -- eruby
  --"herb_ls",
  --"stimulus_ls",

  -- eelixir, elixir, heex, surface
  "elixirls",
  --"expert",
  --"lexical",
  --"nextls",
  -- erlang
  "elp",

  -- java
  "jdtls",
  --"java_language_server",

  -- c, cpp, cuda, objc, objcpp
  "clangd",
  -- cmake
  "neocmake",
  --"cmake",
  -- meson
  "mesonlsp",
  -- automake, config, make
  "autotools_ls",

  -- dockerfile, yaml.docker-compose
  "docker_language_server",
  --"dockerls",
  --"docker_compose_language_service",

  -- yaml
  "yamlls",
  "gh_actions_ls",
  "gitlab_ci_ls",
  "home_assistant",
  "hydra_lsp",
  -- json, yaml, yml linting
  --"spectral",

  -- json, jsonc
  "jsonls",
  -- toml
  "taplo",
  --"tombi",
  -- jsonnet, libsonnet
  "jsonnet_ls",
  -- jq
  "jqls",
  -- svg, xml, xsd, xsl, xslt
  "lemminx",

  -- nix
  "nil_ls",
  --"rnix",

  -- bash, sh
  "bashls",
  -- fish
  "fish_lsp",
  -- ps1
  "powershell_es",
  -- vim
  "vimls",

  -- jinja
  "jinja_lsp",
  -- html, htmldjango, python
  -- attaches to every python buffer, not just django projects
  --"djls",
  --"djlsp",

  -- astro
  "astro",
  -- svelte
  "svelte",
  -- vue
  "vue_ls",
  -- graphql
  "graphql",

  -- handlebars, glimmer
  "ember",
  "glint",
  "lwc_ls",

  -- haskell, lhaskell
  "hls",
  -- elm
  "elmls",
  -- zig, zir
  "zls",
  -- typst
  "tinymist",
  -- coq
  -- NOTE: needs opam in PATH to build
  --"coq_lsp",
  -- awk
  "awk_ls",
  -- dot
  "dotls",
  -- nginx
  "nginx_language_server",
  -- systemd
  "systemd_lsp",
  -- just
  "just",
  -- rst
  "esbonio",
}

return automatic_enable
