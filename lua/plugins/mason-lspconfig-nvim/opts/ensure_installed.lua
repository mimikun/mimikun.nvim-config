-- A list of servers to automatically install if they're not already installed.
---@type string[]
local ensure_installed = {
  -- r
  --"air",
  -- html, htmlangular, typescript, typescriptreact
  --"angularls",
  -- antlers, html
  --"antlersls",
  -- asm, vmasm
  --"asm_lsp",
  -- bash, c, cpp, cs, css, elixir, go, haskell, html, java, javascript, javascriptreact, json, kotlin, lua, nix, php, python, ruby, rust, scala, solidity, swift, typescript, typescriptreact, yaml
  "ast_grep",
  -- astro
  "astro",
  -- automake, config, make
  "autotools_ls",
  -- awk
  "awk_ls",
  -- bazelrc
  --"bazelrc_lsp",
  -- bean, beancount
  --"beancount",
  -- bicep, bicep-params
  --"bicep",
  -- astro, css, graphql, javascript, javascriptreact, json, jsonc, svelte, typescript, typescriptreact, vue
  "biome",
  -- brs
  --"bright_script",
  -- bsl, os
  --"bsl_ls",
  -- cairo
  --"cairo_ls",
  -- cds
  --"cds_lsp",
  -- c, cpp, cuda, objc, objcpp
  "clangd",
  -- clojure, edn
  --"clojure_lsp",
  -- c, css, gitcommit, go, haskell, html, java, javascript, javascriptreact, lua, markdown, php, python, ruby, rust, swift, text, toml, typescript, typescriptreact, zig
  "codebook",
  -- coq
  -- NOTE: needs opam in PATH to build
  --"coq_lsp",
  -- cucumber
  --"cucumber_language_server",
  -- cue
  --"cue",
  --"dagger",
  -- cypher
  --"cypher_ls",
  -- dhall
  --"dhall_lsp_server",
  -- html, htmldjango, python
  "djls",
  -- html, htmldjango
  "djlsp",
  -- dockerfile
  "dockerls",
  -- dot
  "dotls",
  -- graphql, javascript, javascriptreact, json, jsonc, markdown, python, roslyn, rust, toml, typescript, typescriptreact, vue
  "dprint",
  -- earthfile
  --"earthlyls",
  -- eelixir, elixir, heex, surface
  "elixirls",
  -- erlang
  "elp",
  -- elm
  "elmls",
  -- handlebars, javascript, javascript.glimmer, typescript, typescript.glimmer
  "ember",
  -- astro, css, eruby, html, htmlangular, htmldjango, javascriptreact, less, sass, scss, svelte, typescriptreact, vue
  "emmet_language_server",
  -- astro, css, eruby, html, htmlangular, htmldjango, javascriptreact, less, pug, sass, scss, svelte, templ, typescriptreact, vue
  "emmet_ls",
  -- rst
  "esbonio",
  -- astro, htmlangular, javascript, javascriptreact, svelte, typescript, typescriptreact, vue
  "eslint",
  -- eelixir, elixir, heex, surface
  "expert",
  -- fsd
  --"facility_language_server",
  -- fennel
  --"fennel_language_server",
  --"fennel_ls",
  -- flux
  --"flux_lsp",
  -- OpenFOAM, foam
  --"foam_ls",
  -- fortran
  --"fortitude",
  --"fortls",
  -- fsharp
  --"fsautocomplete",
  -- dts
  --"ginko_ls",
  -- handlebars, html.handlebars, javascript, javascript.glimmer, typescript, typescript.glimmer
  "glint",
  -- comp, frag, geom, glsl, tesc, tese, vert
  --"glsl_analyzer",
  --"glslls",
  -- gn
  --"gn_language_server",
  -- go, gomod
  "golangci_lint_ls",
  -- go, gomod, gotmpl, gowork
  "gopls",
  -- groovy
  --"gradle_ls",
  --"groovyls",
  -- graphql, javascriptreact, typescriptreact
  "graphql",
  -- asciidoc, c, cmake, clojure, cpp, cs, dart, gitcommit, go, haskell, html, java, javascript, lua, markdown, nix, php, ruby, rust, sh, swift, toml, typescript, typescriptreact, typst
  "harper_ls",
  -- systemverilog, verilog, vhdl
  --"hdl_checker",
  -- json, yaml, yml
  -- NOTE: upstream build script is broken
  --"spectral",
  -- json.openapi, yaml.openapi
  --"vacuum",
  -- dockerfile, yaml.docker-compose
  "docker_language_server",
  -- helm, yaml.helm-values
  --"helm_ls",
  -- haskell, lhaskell
  -- NOTE: needs ghcup in PATH to build
  --"hls",
  -- hoon
  --"hoon_ls",
  -- html
  "html",
  -- aspnetcorerazor, astro, astro-markdown, blade, clojure, django-html, edge, eelixir, ejs, elixir, erb, eruby, gohtml, gohtmltmpl, haml, handlebars, hbs, heex, html, html-eex, htmlangular, htmldjango, jade, javascript, javascriptreact, leaf, liquid, markdown, mdx, mustache, njk, nunjucks, php, razor, reason, rescript, slim, svelte, templ, twig, typescript, typescriptreact, vue
  "htmx",
  -- hylo
  --"hylo_ls",
  -- hyprlang
  --"hyprls",
  -- java
  -- NOTE: needs jlink from a full JDK to build
  --"java_language_server",
  "jdtls",
  -- jinja
  "jinja_lsp",
  -- jq
  "jqls",
  -- json, jsonc
  "jsonls",
  -- jsonnet, libsonnet
  "jsonnet_ls",
  -- julia
  --"julials",
  -- just
  "just",
  -- kcl
  --"kcl",
  -- kotlin
  --"kotlin_language_server",
  --"kotlin_lsp",
  -- blade, php
  --"laravel_ls",
  -- llw
  --"lelwel_ls",
  -- svg, xml, xsd, xsl, xslt
  "lemminx",
  -- eelixir, elixir, heex, surface
  "lexical",
  -- bib, context, gitcommit, html, mail, markdown, org, pandoc, plaintex, quarto, rmd, rnoweb, rst, tex, text, xhtml
  "ltex",
  -- asciidoc, bib, context, gitcommit, html, mail, markdown, mdx, org, pandoc, plaintex, quarto, rmd, rnoweb, rst, tex, text, typst, xhtml
  "ltex_plus",
  -- luau
  "luau_lsp",
  -- html, javascript
  "lwc_ls",
  -- markdown, markdown.mdx
  "marksman",
  -- matlab
  --"matlab_ls",
  -- mdx
  "mdx_analyzer",
  -- meson
  "mesonlsp",
  -- sml
  --"millet",
  -- metamath-zero
  --"mm0_ls",
  -- motoko
  --"motoko_lsp",
  -- move
  --"move_analyzer",
  -- muttrc, neomuttrc
  --"mutt_ls",
  -- nextflow
  --"nextflow_ls",
  -- eelixir, elixir, heex, surface
  "nextls",
  -- nginx
  "nginx_language_server",
  -- ncl, nickel
  --"nickel_ls",
  -- nix
  "nil_ls",
  -- nim
  --"nim_langserver",
  --"nimls",
  -- dune, menhir, ocaml, ocamlinterface, ocamllex, reason
  --"ocamllsp",
  -- odin
  --"ols",
  -- cs, vb
  --"omnisharp",
  -- opencl
  --"opencl_ls",
  -- openscad
  --"openscad_lsp",
  -- css, graphql, handlebars, html, javascript, javascriptreact, json, json5, jsonc, less, markdown, scss, typescript, typescriptreact, vue
  "oxfmt",
  -- astro, javascript, javascriptreact, svelte, typescript, typescriptreact, vue
  "oxlint",
  -- perl
  --"perlnavigator",
  -- pest
  --"pest_ls",
  -- p8
  --"pico8_ls",
  -- prisma
  --"prismals",
  -- puppet
  --"puppet",
  -- purescript
  --"purescriptls",
  -- qml, qmljs
  --"qmlls",
  -- javascript, typescript
  "quick_lint_js",
  -- quarto, r, rmd
  --"r_language_server",
  -- raku
  --"raku_navigator",
  -- reason
  --"reason_ls",
  -- rego
  --"regal",
  --"regols",
  -- rescript
  --"rescriptls",
  -- nix
  "rnix",
  -- resource, robot
  --"robotcode",
  -- robot
  --"robotframework_ls",
  -- roc
  --"roc_ls",
  -- spec
  --"rpmspec",
  -- eruby, html
  "herb_ls",
  -- eruby, ruby
  "steep",
  "ruby_lsp",
  -- sls
  --"salt_ls",
  -- d
  --"serve_d",
  -- liquid
  --"shopify_theme_ls",
  -- hlsl, shaderslang
  --"slangd",
  -- slint
  --"slint_lsp",
  -- smithy
  --"smithy_ls",
  -- ss
  --"snakeskin_ls",
  -- apex, apexcode, c, cpp, cs, dart, dockerfile, eelixir, elixir, go, gomod, groovy, helm, java, javascript, kotlin, objc, objcpp, php, python, requirements, ruby, rust, scala, swift, terraform, terraform-vars, typescript
  "snyk_ls",
  -- solidity
  --"solang",
  --"solc",
  --"solidity",
  --"solidity_ls",
  --"solidity_ls_nomicfoundation",
  -- mcfunction
  --"spyglassmc_language_server",
  -- stan
  --"stan_ls",
  -- BUILD.bazel, bzl, star
  --"starlark_rust",
  -- blade, eruby, html, php
  "stimulus_ls",
  -- astro, css, html, less, scss, vue
  "stylelint_lsp",
  -- html, superhtml
  "superhtml",
  -- svelte
  "svelte",
  -- systemd
  "systemd_lsp",
  -- aspnetcorerazor, astro, astro-markdown, blade, clojure, css, django-html, edge, eelixir, ejs, elixir, erb, eruby, gohtml, gohtmltmpl, haml, handlebars, hbs, heex, html, html-eex, htmlangular, htmldjango, jade, javascriptreact, leaf, less, liquid, markdown, mdx, mustache, njk, nunjucks, php, postcss, razor, reason, rescript, sass, scss, slim, stylus, sugarss, svelte, templ, twig, typescript, typescriptreact, vue
  "tailwindcss",
  -- sdc, tcl, upf, xdc
  --"tclsp",
  -- teal
  --"teal_ls",
  -- templ
  "templ",
  -- terraform, terraform-vars
  --"terraformls",
  -- bib, plaintex, tex
  --"texlab",
  -- org, tex, text
  "textlsp",
  -- terraform
  --"tflint",
  -- thrift
  --"thriftls",
  -- typst
  "tinymist",
  -- opentofu, opentofu-vars, terraform
  --"tofu_ls",
  -- query
  --"ts_query_ls",
  -- typespec
  --"tsp_server",
  -- twig
  --"twiggy_language_server",
  -- astro, css, ejs, erb, haml, hbs, html, javascript, javascriptreact, less, markdown, mdx, php, postcss, rescript, rust, sass, scss, stylus, svelte, typescript, typescriptreact, vue, vue-html
  "unocss",
  -- sass, scss
  "somesass_ls",
  -- v, vsh, vv
  --"v_analyzer",
  -- asciidoc, html, markdown, rst, text, xml
  "vale_ls",
  -- genie, vala
  --"vala_ls",
  -- veryl
  --"veryl_ls",
  -- vhd, vhdl
  --"vhdl_ls",
  -- visualforce
  --"visualforce_ls",
  -- v, vlang
  --"vls",
  -- vue
  "vue_ls",
  -- wat
  --"wasm_language_tools",
  -- wgsl
  --"wgsl_analyzer",
  -- zig, zir
  "zls",
  -- NOTE: php
  --"intelephense",
  --"phpactor",
  --"psalm",
  -- NOTE: javascript, javascriptreact, typescript, typescriptreact
  "vtsls",
  "cssmodules_ls",
  "denols",
  "ts_ls",
  "tsgo",
  -- NOTE: ruby
  "rubocop",
  "solargraph",
  "sorbet",
  "standardrb",
  -- NOTE: python
  "ruff",
  "ty",
  "zuban",
  "basedpyright",
  "jedi_language_server",
  "pylsp",
  "pylyzer",
  "pyre",
  "pyrefly",
  "pyright",
  -- NOTE: toml
  "taplo",
  "tombi",
  -- NOTE: markdown
  "remark_ls",
  "rumdl",
  -- NOTE: unmaintained upstream, peer dependency conflict
  --"grammarly",
  "markdown_oxide",
  "mpls",
  "prosemd_lsp",
  "zk",
  -- NOTE: lua
  "emmylua_ls",
  "lua_ls",
  "stylua",
  -- NOTE: rust
  "bacon_ls",
  "rust_analyzer",
  -- NOTE: cmake
  "neocmake",
  "cmake",
  -- NOTE: proto
  --"pbls",
  --"protols",
  --"buf_ls",
  -- NOTE: bzl
  --"starpls",
  --"bzl",
  -- NOTE: mysql, sql
  --"sqlls",
  --"sqls",
  -- NOTE: sql
  --"sqruff",
  --"bqls",
  --"postgres_lsp",
  -- NOTE: vim
  "vimls",
  -- NOTE: autohotkey
  --"autohotkey_lsp",
  -- NOTE: arduino
  --"arduino_language_server",
  -- NOTE: css, less, scss
  "css_variables",
  "cssls",
  -- NOTE: systemverilog, verilog
  --"svlangserver",
  --"svls",
  --"verible",
  -- NOTE: crystal
  --"crystalline",
  -- NOTE: cobol
  --"cobol_ls",
  -- NOTE: yaml
  "hydra_lsp",
  "gh_actions_ls",
  "home_assistant",
  --"azure_pipelines_ls",
  -- NOTE: yaml.gitlab
  "gitlab_ci_ls",
  -- NOTE: yaml, yaml.docker-compose, yaml.gitlab, yaml.helm-values
  "yamlls",
  -- NOTE: yaml.docker-compose
  "docker_compose_language_service",
  -- NOTE: yaml.ansible
  --"ansiblels",
  -- NOTE: bash, sh
  "bashls",
  -- NOTE: fish
  "fish_lsp",
  -- NOTE: ps1
  "powershell_es",
}

return ensure_installed
