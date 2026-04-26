---@module "conform"
---@type conform.setupOpts
local opts = {
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = {
      "stylua",
    },

    -- Conform will run multiple formatters sequentially
    go = {
      "goimports",
      "gofmt",
    },

    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = {
      "rustfmt",
      lsp_format = "fallback",
    },

    -- Conform will run the first available formatter
    javascript = {
      "prettierd",
      "prettier",
      stop_after_first = true,
    },

    -- You can use a function here to determine the formatters dynamically
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return {
          "ruff_format",
        }
      else
        return {
          "isort",
          "black",
        }
      end
    end,

    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = {
      "codespell",
    },

    -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
    ["_"] = {
      "trim_whitespace",
    },
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
