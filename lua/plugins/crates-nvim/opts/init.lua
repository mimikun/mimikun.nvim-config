---@type crates.UserConfig
local opts = {
  ---@type boolean
  smart_insert = true,

  ---@type boolean
  remove_enabled_default_features = true,

  ---@type boolean
  remove_empty_features = true,

  ---@type boolean
  insert_closing_quote = true,

  ---@type boolean
  autoload = true,

  ---@type boolean
  autoupdate = true,

  ---@type integer
  autoupdate_throttle = 250,

  ---@type boolean
  loading_indicator = true,

  ---@type boolean
  search_indicator = true,

  ---@type string
  date_format = "%Y-%m-%d",

  ---@type string
  thousands_separator = ".",

  ---@type string
  notification_title = "crates.nvim",

  ---@type string[]
  curl_args = {
    "-sL",
    "--retry",
    "1",
  },

  ---@type integer
  max_parallel_requests = 80,

  ---@type boolean
  expand_crate_moves_cursor = true,

  ---@type boolean
  enable_update_available_warning = true,

  ---@type fun(bufnr: integer)
  on_attach = function(bufnr)
    -- TODO: its
  end,

  ---@type crates.UserTextConfig
  text = require("plugins.crates-nvim.opts.text"),

  ---@type crates.UserHighlightConfig
  highlight = require("plugins.crates-nvim.opts.highlight"),

  ---@type crates.UserPopupConfig
  popup = require("plugins.crates-nvim.opts.popup"),

  ---@type crates.UserCompletionConfig
  completion = require("plugins.crates-nvim.opts.completion"),

  ---@type crates.UserNullLsConfig
  null_ls = {
    ---@type boolean
    enabled = false,

    ---@type string
    name = "crates.nvim",
  },

  ---@type crates.UserNeoconfConfig
  neoconf = {
    ---@type boolean
    enabled = false,

    ---@type string
    namespace = "crates",
  },

  ---@type crates.UserLspConfig
  lsp = {
    ---@type boolean
    enabled = true,

    ---@type string
    name = "crates.nvim",

    ---@type fun(client: vim.lsp.Client, bufnr: integer)
    on_attach = function(client, bufnr)
      -- TODO: it

      -- the same on_attach function as for your other language servers can be ommited if you're using the `LspAttach` autocmd
    end,

    ---@type boolean
    actions = true,

    ---@type boolean
    completion = true,

    ---@type boolean
    hover = true,
  },
}

return opts
