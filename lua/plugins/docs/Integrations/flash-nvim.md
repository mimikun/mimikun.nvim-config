# Integrations

## folke/flash.nvim

### nvim-treesitter/nvim-treesitter

Treesitter incremental selection

The [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main) **main** rewrite no longer includes incremental selection. 
You can use **flash.nvim** instead.

```lua
vim.keymap.set({"n", "x", "o"}, "<c-space>", function()
  require("flash").treesitter({
    actions = {
      ["<c-space>"] = "next",
      ["<BS>"] = "prev"
    }
  })
end, { desc = "Treesitter incremental selection" })
```

### nvim-telescope/telescope.nvim

This will allow you to use `s` in normal mode and `<c-s>` in insert mode, to jump to a label in Telescope results.

```lua
{
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = { s = flash },
          i = { ["<c-s>"] = flash },
        },
      })
    end,
  }
```

### folke/snacks.nvim

Snacks Picker integration

This will allow you to use `s` in normal mode and `<a-s>` in insert mode, to jump to a label in the picker results.

```lua
{
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-s>"] = { "flash", mode = { "n", "i" } },
              ["s"] = { "flash" },
            },
          },
        },
        actions = {
          flash = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
        },
      },
    },
  }
```

