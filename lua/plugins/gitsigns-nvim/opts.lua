-- TODO: it

--[[
worktrees                                          *gitsigns-config-worktrees*
    Type: `table`, Default: `{}`

    Detached working trees.

    Array of tables with the keys `gitdir` and `toplevel`.

    If normal attaching fails, then each entry in the table is attempted
    with the work tree details set.

    Example: >lua
      worktrees = {
        {
          toplevel = vim.env.HOME,
          gitdir = vim.env.HOME .. '/projects/dotfiles/.git'
        }
      }

]]
--[[
trouble                                              *gitsigns-config-trouble*
    Type: `boolean`, Default: true if installed

    When using setqflist() or setloclist(), open Trouble instead of the
    quickfix/location list window.

]]
--[[
gh                                                        *gitsigns-config-gh*
    Type: `boolean`, Default: `false`

    Enable GitHub integration. This allows the following features:
    • `:Gitsigns blame_line` will show PR numbers (with a hyperlink)
]]
--[[
culhl                                                  *gitsigns-config-culhl*
    Type: `boolean`, Default: `false`

    Enable/disable highlights for the sign column when the cursor is on
    the same line.

    When enabled the highlights defined in `signs.*.culhl` are used. If
    the highlight group does not exist, then it is automatically defined
    and linked to the corresponding highlight group in `signs.*.hl`.

]]
--[[
diffthis                                            *gitsigns-config-diffthis*
    Type: `table`
    Default: >
    `{
      split = "aboveleft"
    }`
<
    Options for the `:Gitsigns diffthis` command.

]]
--[[
count_chars                                      *gitsigns-config-count_chars*
    Type: `table`
    Default: >
    `{ "1", "2", "3", "4", "5", "6", "7", "8", "9",
      ["+"] = ">"
    }`
<
    The count characters used when `signs.*.show_count` is enabled. The
    `+` entry is used as a fallback. With the default, any count outside
    of 1-9 uses the `>` character in the sign.

    Possible use cases for this field:
      • to specify unicode characters for the counts instead of 1-9.
      • to define characters to be used for counts greater than 9.

]]
--[[
base                                                    *gitsigns-config-base*
    Type: `string`, Default: index

    The object/revision to diff against.
    See |gitsigns-revision|.

]]
--[[
current_line_blame_formatter_nc
                             *gitsigns-config-current_line_blame_formatter_nc*
    Type: `string|function`, Default: `" <author>"`

    String or function used to format the virtual text of
    |gitsigns-config-current_line_blame| for lines that aren't committed.

    See |gitsigns-config-current_line_blame_formatter| for more information.

]]

---@alias Gitsigns.SignType
---| 'add'
---| 'change'
---| 'delete'
---| 'topdelete'
---| 'changedelete'
---| 'untracked'

local _gitsigns = require("gitsigns")

---@type Gitsigns.Config
local opts = {
  ---@type table<Gitsigns.SignType,Gitsigns.SignConfig>
  signs = {
    add = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "┃",
    },
    change = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "┃",
    },
    delete = {
      ---@type boolean
      --show_count = true,

      ---@type string
      --text = "_",
      text = "▁",
    },
    topdelete = {
      ---@type boolean
      --show_count = true,

      ---@type string
      --text = "‾",
      text = "▔",
    },
    changedelete = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "~",
    },
    untracked = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "┆",
    },
  },

  -- Configuration for signs of staged hunks.
  ---@type table<Gitsigns.SignType,Gitsigns.SignConfig>
  signs_staged = {
    add = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "┃",
    },
    change = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "┃",
    },
    delete = {
      ---@type boolean
      --show_count = true,

      ---@type string
      --text = "_",
      text = "▁",
    },
    topdelete = {
      ---@type boolean
      --show_count = true,

      ---@type string
      --text = "‾",
      text = "▔",
    },
    changedelete = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "~",
    },
    untracked = {
      ---@type boolean
      --show_count = true,

      ---@type string
      text = "┆",
    },
  },

  -- Show signs for staged hunks.
  ---@type boolean
  signs_staged_enable = true,

  -- Enable/disable symbols in the sign column.
  -- Toggle with `:Gitsigns toggle_signs`
  ---@type boolean
  signcolumn = true,

  -- Enable/disable line number highlights.
  -- Toggle with `:Gitsigns toggle_numhl`
  ---@type boolean
  numhl = false,

  -- Enable/disable line highlights.
  -- Toggle with `:Gitsigns toggle_linehl`
  ---@type boolean
  linehl = false,

  -- Highlight intra-line word differences in the buffer.
  -- Toggle with `:Gitsigns toggle_word_diff`
  ---@type boolean
  word_diff = false,

  -- When opening a file, a libuv watcher is placed on the respective `.git` directory to detect when changes happen to use as a trigger to update signs.
  ---@type table
  watch_gitdir = {
    ---@type boolean
    --enable = true,

    ---@type boolean
    follow_files = true,
  },

  -- Automatically attach to files.
  ---@type boolean
  auto_attach = true,

  -- Attach to untracked files.
  ---@type boolean
  attach_to_untracked = false,

  -- Adds an unobtrusive and customisable blame annotation at the end of the current line.
  -- Toggle with `:Gitsigns toggle_current_line_blame`
  ---@type boolean
  current_line_blame = false,

  -- Options for the current line blame annotation.
  ---@type Gitsigns.CurrentLineBlameOpts
  current_line_blame_opts = {
    -- Whether to show a virtual text blame annotation.
    ---@type boolean
    virt_text = true,

    -- Blame annotation position.
    -- eol:         Right after eol character.
    -- overlay:     Display over the specified column, without shifting the underlying text.
    -- right_align: Display right aligned in the window.
    ---@type string | "eol" | "overlay" | "right_align"
    virt_text_pos = "eol",

    -- Sets the delay (in milliseconds) before blame virtual text is displayed.
    ---@type integer
    delay = 1000,

    -- Ignore whitespace when running blame.
    ---@type boolean
    ignore_whitespace = false,

    -- Priority of virtual text.
    ---@type integer
    virt_text_priority = 100,

    -- Enable only when buffer is in focus
    ---@type boolean
    use_focus = true,

    -- Extra options passed to `git-blame`.
    ---@type string[]
    --extra_opts = nil,
  },

  -- String or function used to format the virtual text of |gitsigns-config-current_line_blame|.
  ---@type string | Gitsigns.CurrentLineBlameFmtFun | fun(user: string, info: table<string,any>): [string,string][]
  current_line_blame_formatter = function(_name, _info)
    local current_line_blame_formatter = "<author>, <author_time:%R> - <summary>"
    return current_line_blame_formatter
  end,

  -- Priority to use for signs.
  ---@type integer
  sign_priority = 6,

  -- Debounce time for updates (in milliseconds).
  ---@type integer
  update_debounce = 100,

  -- Use default
  ---@type fun(_: table<string,any>): string
  status_formatter = function(status)
    local added, changed, removed = status.added, status.changed, status.removed
    local status_txt = {}
    if added and added > 0 then
      table.insert(status_txt, "+" .. added)
    end
    if changed and changed > 0 then
      table.insert(status_txt, "~" .. changed)
    end
    if removed and removed > 0 then
      table.insert(status_txt, "-" .. removed)
    end
    return table.concat(status_txt, " ")
  end,

  -- Max file length (in lines) to attach to.
  -- Disable if file is longer than this (in lines)
  ---@type integer
  max_file_length = 40000,

  -- Option overrides for the Gitsigns preview window.
  -- Table is passed directly to `nvim_open_win`.
  ---@type vim.api.keyset.win_config
  preview_config = {
    -- Options passed to nvim_open_win
    col = 1,
    relative = "cursor",
    row = 0,
    style = "minimal",
  },

  -- Callback called when attaching to a buffer.
  -- Mainly used to setup keymaps.
  -- The buffer number is passed as the first argument.
  -- This callback can return `false` to prevent attaching to the buffer.
  ---@type fun(bufnr: integer): boolean? | nil
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk)
    map("n", "<leader>hr", gitsigns.reset_hunk)

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hp", gitsigns.preview_hunk)
    map("n", "<leader>hi", gitsigns.preview_hunk_inline)

    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end)

    map("n", "<leader>hd", gitsigns.diffthis)

    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end)

    map("n", "<leader>hQ", function()
      gitsigns.setqflist("all")
    end)
    map("n", "<leader>hq", gitsigns.setqflist)

    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>tw", gitsigns.toggle_word_diff)

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
}

return opts
