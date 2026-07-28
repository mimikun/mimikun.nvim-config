---@type LazySpec
local spec = {
  "mfussenegger/nvim-lint",
  --lazy = false,
  event = require("plugins.nvim-lint.events"),
  config = function()
    local lint = require("lint")

    ---@type table<string, string[]>
    lint.linters_by_ft = {
      --text = { "vale" },
      json = { "jsonlint" },
      --markdown = { "vale" },
      rst = { "vale" },
      ruby = { "ruby" },
      janet = { "janet" },
      inko = { "inko" },
      clojure = { "clj-kondo" },
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
      ["yaml.ghaction"] = { "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
  --cond = false,
  --enabled = false,
}

return spec
