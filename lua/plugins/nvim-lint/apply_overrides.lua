-- Apply `plugins.nvim-lint.opts.linters` on top of nvim-lint's built-in linter
-- definitions.
--
-- nvim-lint has no setup(). Built-in linter definitions are plain modules cached
-- by `require`, so extending them in place is what actually sticks.
--
-- Lives in its own module because two callers need the exact same resolved
-- argv: the plugin's own `config` function, and scripts/check-tool-litter.lua,
-- which audits what each tool writes into the working directory. A copy of this
-- loop in the checker would silently drift from what actually runs.
--
-- `append_args` extends the built-in argument list; every other key replaces the
-- field outright.

---@param lint table The `lint` module.
---@param overrides table<string, table> Keyed by linter name.
---@return nil
return function(lint, overrides)
  for name, override in pairs(overrides) do
    local linter = lint.linters[name]

    if linter then
      for key, value in pairs(override) do
        if key == "append_args" then
          linter.args = vim.list_extend(vim.deepcopy(linter.args or {}), value)
        else
          linter[key] = value
        end
      end
    end
  end
end
