---@type snacks.gh.Config
local gh = {
  --- Keymaps for GitHub buffers
  ---@type table<string, snacks.gh.Keymap|false>?
  keys = {
    select = { "<cr>", "gh_actions", desc = "Select Action" },
    edit = { "i", "gh_edit", desc = "Edit" },
    comment = { "a", "gh_comment", desc = "Add Comment" },
    close = { "c", "gh_close", desc = "Close" },
    reopen = { "o", "gh_reopen", desc = "Reopen" },
  },
  ---@type vim.wo|{}
  wo = {
    breakindent = true,
    wrap = true,
    showbreak = "",
    linebreak = true,
    number = false,
    relativenumber = false,
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    foldmethod = "expr",
    concealcursor = "n",
    conceallevel = 2,
    list = false,
    --winhighlight = Snacks.util.winhl({
    --  Normal = "SnacksGhNormal",
    --  NormalFloat = "SnacksGhNormalFloat",
    --  FloatBorder = "SnacksGhBorder",
    --  FloatTitle = "SnacksGhTitle",
    --  FloatFooter = "SnacksGhFooter",
    --}),
  },
  ---@type vim.bo|{}
  bo = {},
  diff = {
    -- minimum number of lines changed to show diff
    min = 4,
    -- wrap diff lines at this length
    wrap = 80,
  },
  scratch = {
    -- height of scratch window
    height = 15,
  },
  icons = {
    logo = " ",
    user = " ",
    checkmark = " ",
    crossmark = " ",
    block = "■",
    file = " ",
    checks = {
      pending = " ",
      success = " ",
      failure = "",
      skipped = " ",
    },
    issue = {
      open = " ",
      completed = " ",
      other = " ",
    },
    pr = {
      open = " ",
      closed = " ",
      merged = " ",
      draft = " ",
      other = " ",
    },
    review = {
      approved = " ",
      changes_requested = " ",
      commented = " ",
      dismissed = " ",
      pending = " ",
    },
    merge_status = {
      clean = " ",
      dirty = " ",
      blocked = " ",
      unstable = " ",
    },
    reactions = {
      thumbs_up = "👍",
      thumbs_down = "👎",
      eyes = "👀",
      confused = "😕",
      heart = "❤️",
      hooray = "🎉",
      laugh = "😄",
      rocket = "🚀",
    },
  },
}

return gh
