---@type snacks.scratch.Config
local scratch = {
  name = "Scratch",

  -- the filetype of the scratch buffer
  ---@type string | fun():string
  ft = function()
    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      return vim.bo.filetype
    end
    return "markdown"
  end,

  -- `icon | {icon, icon_hl}`.
  -- defaults to the filetype icon
  ---@type string | string[]
  icon = nil,

  root = vim.fn.stdpath("data") .. "/scratch",

  -- automatically write when the buffer is hidden
  autowrite = true,

  -- unique key for the scratch file is based on:
  -- * name
  -- * ft
  -- * vim.v.count1 (useful for keymaps)
  -- * cwd (optional)
  -- * branch (optional)
  filekey = {
    -- unique id used instead of name for the filename hash
    ---@type string?
    id = nil,

    -- use current working directory
    cwd = true,

    -- use current branch name
    branch = true,

    -- use vim.v.count1
    count = true,
  },

  -- scratch window
  ---@type snacks.win.Config
  win = {
    style = "scratch",
  },

  ---@type table<string, snacks.win.Config>
  win_by_ft = {
    lua = {
      keys = {
        ["source"] = {
          "<cr>",
          function(self)
            local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
            Snacks.debug.run({
              buf = self.buf,
              name = name,
            })
          end,
          desc = "Source buffer",
          mode = {
            "n",
            "x",
          },
        },
      },
    },
  },

  -- template for new buffers
  ---@type string
  --template

  -- scratch file path.
  -- You probably don't need to set this.
  ---@type string
  --file
}

return scratch
