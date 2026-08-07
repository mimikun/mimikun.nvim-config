---@type LazySpec
local spec = {
  "mfussenegger/nvim-lint",
  --lazy = false,
  cmd = require("plugins.nvim-lint.cmds"),
  keys = require("plugins.nvim-lint.keys"),
  event = require("plugins.nvim-lint.events"),
  --opts = require("plugins.nvim-lint.opts"),
  config = function()
    local opts = require("plugins.nvim-lint.opts")
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft

    -- nvim-lint has no setup().
    -- Built-in linter definitions are plain modules cached by `require`, so extending them in place is what actually sticks.
    -- `append_args` extends the built-in argument list; every other key replaces the field outright.
    for name, override in pairs(opts.linters) do
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

    -- Resolve a linter's command the same way nvim-lint does:
    -- it may be a function so the linter can prefer a project-local binary.
    ---@param linter table
    ---@return boolean
    local function available(linter)
      local cmd = linter.cmd

      if type(cmd) == "function" then
        local ok, resolved = pcall(cmd)

        if not ok then
          return false
        end

        cmd = resolved
      end

      return type(cmd) == "string" and vim.fn.executable(cmd) == 1
    end

    -- `linters_by_ft` names every linter worth running, not just the ones that happen to be installed on this host.
    -- Without this filter try_lint emits a WARN per missing executable on every save.
    -- `:LintInfo` reports what got skipped, since skipping is otherwise silent.
    local function lint_buf()
      local bufnr = vim.api.nvim_get_current_buf()

      if vim.g.disable_lint or vim.b[bufnr].disable_lint then
        return
      end

      lint.try_lint(nil, {
        filter = available,
      })
      lint.try_lint(opts.extra_linters(bufnr), {
        filter = available,
      })
    end

    vim.api.nvim_create_autocmd(require("plugins.nvim-lint.events"), {
      desc = "Run nvim-lint on the current buffer",
      callback = lint_buf,
    })

    -- Define some user_commands
    -- Lint on demand
    vim.api.nvim_create_user_command("Lint", lint_buf, {
      desc = "Lint the current buffer",
    })

    -- Run Enable/Disable
    vim.api.nvim_create_user_command("LintDisable", function(args)
      if args.bang then
        -- LintDisable! will disable linting just for this buffer
        vim.b.disable_lint = true
      else
        vim.g.disable_lint = true
      end
    end, {
      desc = "Disable lint-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("LintEnable", function()
      vim.b.disable_lint = false
      vim.g.disable_lint = false
    end, {
      desc = "Re-enable lint-on-save",
    })

    -- Toggle lint-on-save (mirrors the bang semantics of LintDisable)
    vim.api.nvim_create_user_command("LintToggle", function(args)
      if args.bang then
        -- LintToggle! flips linting just for this buffer
        vim.b.disable_lint = not vim.b.disable_lint
      else
        vim.g.disable_lint = not vim.g.disable_lint
      end
    end, {
      desc = "Toggle lint-on-save",
      bang = true,
    })

    -- Report which linters apply to this buffer and which of them are missing.
    -- This is the counterpart to the `available` filter above.
    vim.api.nvim_create_user_command("LintInfo", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local filetype = vim.bo[bufnr].filetype
      local disabled = vim.g.disable_lint or vim.b[bufnr].disable_lint or false
      local lines = {
        "filetype: " .. (filetype == "" and "(none)" or filetype),
        "lint-on-save: " .. (disabled and "disabled" or "enabled"),
        "legend: + installed / - not on PATH",
      }

      local function report(names)
        if vim.tbl_isempty(names) then
          table.insert(lines, "  (none)")

          return
        end

        for _, name in ipairs(names) do
          local linter = lint.linters[name]

          if type(linter) == "function" then
            linter = linter()
          end

          if linter then
            table.insert(lines, (available(linter) and "  + " or "  - ") .. name)
          else
            table.insert(lines, "  ? " .. name .. " (no definition)")
          end
        end
      end

      table.insert(lines, "")
      table.insert(lines, "by filetype:")
      report(lint.linters_by_ft[filetype] or {})

      table.insert(lines, "")
      table.insert(lines, "always:")
      report(opts.extra_linters(bufnr))

      vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
    end, {
      desc = "Show the linters configured for the current buffer",
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
