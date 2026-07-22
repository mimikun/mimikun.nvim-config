---@type LazySpec
local spec = {
  "y3owk1n/undo-glow.nvim",
  --version = "*",
  --lazy = false,
  keys = require("plugins.undo-glow-nvim.keys"),
  event = require("plugins.undo-glow-nvim.events"),
  init = function()
    --local ug = require("undo-glow")

    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Highlight when yanking (copying) text",
      callback = function()
        require("undo-glow").yank()
      end,
    })

    -- This only handles neovim instance and do not highlight when switching panes in tmux
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "Highlight when cursor moved significantly",
      callback = function()
        require("undo-glow").cursor_moved({
          animation = {
            animation_type = "slide",
          },
        }, {
          -- Jump threshold
          steps_to_trigger = 10,

          -- Skip these filetypes
          ignored_ft = {
            "mason",
            "lazy",
          },
        })
      end,
    })

    -- This will handle highlights when focus gained, including switching panes in tmux
    vim.api.nvim_create_autocmd("FocusGained", {
      desc = "Highlight when focus gained",
      callback = function()
        ---@type UndoGlow.CommandOpts
        local opts = {
          animation = {
            animation_type = "slide",
          },
        }

        opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
        local pos = require("undo-glow.utils").get_current_cursor_row()

        require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
          s_row = pos.s_row,
          s_col = pos.s_col,
          e_row = pos.e_row,
          e_col = pos.e_col,
          force_edge = opts.force_edge == nil and true or opts.force_edge,
        }))
      end,
    })

    vim.api.nvim_create_autocmd("CmdlineLeave", {
      desc = "Highlight when search cmdline leave",
      callback = function()
        require("undo-glow").search_cmd({
          animation = {
            animation_type = "fade",
          },
        })
      end,
    })
  end,
  --opts = require("plugins.undo-glow-nvim.opts"),
  config = function()
    local opts = require("plugins.undo-glow-nvim.opts")
    require("undo-glow").setup(opts)
  end,
  -- TODO: it
  cond = false,
  enabled = false,
}

return spec
