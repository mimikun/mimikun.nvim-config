---@type LazySpec
local spec = {
  "lambdalisue/vim-gin",
  --lazy = false,
  --ft = require("denops-plugins.vim-gin.ft"),
  cmd = require("denops-plugins.vim-gin.cmds"),
  --keys = require("denops-plugins.vim-gin.keys"),
  --event = require("denops-plugins.vim-gin.events"),
  dependencies = require("denops-plugins.vim-gin.dependencies"),
  --init = function()
  --    INIT
  --end,
  --opts = require("denops-plugins.vim-gin.opts"),
  config = function()
    -- Specify default arguments of |:GinBranch|.
    vim.g.gin_branch_default_args = {}

    -- Specify persistent arguments of |:GinBranch|.
    vim.g.gin_branch_persistent_args = {}

    -- Disable default mappings on buffers shown by |:GinBranch|.
    vim.g.gin_branch_disable_default_mappings = 0

    -- Define a REMOTE alias for a specific hosting service on |:GinBrowse| command.
    -- This is useful for example GitHub Enterprise with a custom domain like
    vim.g.gin_browse_aliases = {
      ["github.on.my.custom.domain.com"] = "github.com",
    }

    -- Specify default arguments of |:GinBrowse|.
    vim.g.gin_browse_default_args = {}

    -- Specify persistent arguments of |:GinBrowse|.
    vim.g.gin_browse_persistent_args = {}

    -- Specify default arguments of |:GinChaperon|.
    vim.g.gin_chaperon_default_args = {}

    -- Specify persistent arguments of |:GinChaperon|.
    vim.g.gin_chaperon_persistent_args = {}

    -- Disable default mappings on buffers shown by |:GinChaperon|.
    vim.g.gin_chaperon_disable_default_mappings = 0
  end,
  --cond = false,
  --enabled = false,
}

return spec
