---@type table
local opts = {
  -- automatic_installation only sees linters_by_ft. The ones nvim-lint's
  -- `extra_linters` passes straight to try_lint() are invisible to it, so they
  -- are named here with their mason package names.
  -- See lua/plugins/nvim-lint/opts.lua.
  ---@type string[]
  ensure_installed = {
    "typos",
    "actionlint",
    "zizmor",
  },

  -- Install every linter in nvim-lint's linters_by_ft that mason carries.
  -- 26 of the 37 configured linters resolve; the rest run through their own
  -- toolchain (clippy via cargo, credo via mix, fish and zsh are the shells)
  -- or are absent from the registry. Run :checkhealth mason-nvim-lint.
  ---@type boolean | string[] | { exclude: string[] }
  automatic_installation = true,

  -- Resolution is derived from the mason registry, not a table in the plugin.
  -- This is the escape hatch for a bad derivation.
  ---@type table<string, string|false>
  overrides = {},
}

return opts
