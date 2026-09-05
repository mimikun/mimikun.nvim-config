---@type table
local opts = {
  -- Formatters conform points at that mason has no package for are skipped
  -- silently, so nothing needs listing here yet. Anything conform cannot
  -- express goes here, using mason package names.
  ---@type string[]
  ensure_installed = {},

  -- Install every formatter in conform's formatters_by_ft that mason carries.
  -- 31 of the 51 configured formatters resolve; the rest ship with their own
  -- toolchain (rustfmt, gofmt, zigfmt, mix, fish_indent, ...) or are absent
  -- from the registry. Run :checkhealth mason-conform to see the split.
  -- ocamlformat is excluded because its mason installer shells out to `opam`,
  -- which is not on PATH here, so every startup retried and failed it. The same
  -- reason already keeps coq_lsp and ocamllsp commented out of
  -- mason-lspconfig's ensure_installed.
  ---@type boolean | string[] | { exclude: string[] }
  automatic_installation = {
    exclude = {
      -- ocaml: needs opam in PATH to build
      "ocamlformat",
    },
  },

  -- Resolution is derived from the mason registry, not a table in the plugin.
  -- This is the escape hatch for a bad derivation.
  ---@type table<string, string|false>
  overrides = {},
}

return opts
