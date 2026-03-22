---@type LazyKeysSpec[]
local keys = {
  -- Find / Search
  {
    "<leader>zf",
    function()
      require("telekasten").find_notes()
    end,
    mode = "n",
    desc = "Telekasten: Find notes",
    { silent = true },
  },
  {
    "<leader>zd",
    function()
      require("telekasten").find_daily_notes()
    end,
    mode = "n",
    desc = "Telekasten: Find daily notes",
    { silent = true },
  },
  {
    "<leader>zg",
    function()
      require("telekasten").search_notes()
    end,
    mode = "n",
    desc = "Telekasten: Search notes",
    { silent = true },
  },
  {
    "<leader>zw",
    function()
      require("telekasten").find_weekly_notes()
    end,
    mode = "n",
    desc = "Telekasten: Find weekly notes",
    { silent = true },
  },
  {
    "<leader>zF",
    function()
      require("telekasten").find_friends()
    end,
    mode = "n",
    desc = "Telekasten: Find friends",
    { silent = true },
  },

  -- Navigation
  {
    "<leader>zz",
    function()
      require("telekasten").follow_link()
    end,
    mode = "n",
    desc = "Telekasten: Follow link",
    { silent = true },
  },
  {
    "<leader>zT",
    function()
      require("telekasten").goto_today()
    end,
    mode = "n",
    desc = "Telekasten: Go to today",
    { silent = true },
  },
  {
    "<leader>zW",
    function()
      require("telekasten").goto_thisweek()
    end,
    mode = "n",
    desc = "Telekasten: Go to this week",
    { silent = true },
  },

  -- Create
  {
    "<leader>zn",
    function()
      require("telekasten").new_note()
    end,
    mode = "n",
    desc = "Telekasten: New note",
    { silent = true },
  },
  {
    "<leader>zN",
    function()
      require("telekasten").new_templated_note()
    end,
    mode = "n",
    desc = "Telekasten: New templated note",
    { silent = true },
  },

  -- Yank / Clipboard
  {
    "<leader>zy",
    function()
      require("telekasten").yank_notelink()
    end,
    mode = "n",
    desc = "Telekasten: Yank note link",
    { silent = true },
  },

  -- Calendar
  {
    "<leader>zc",
    function()
      require("telekasten").show_calendar()
    end,
    mode = "n",
    desc = "Telekasten: Show calendar",
    { silent = true },
  },
  {
    "<leader>zC",
    "<cmd>CalendarT<CR>",
    mode = "n",
    desc = "Telekasten: Open CalendarT",
    { silent = true },
  },

  -- Media / Images
  {
    "<leader>zi",
    function()
      require("telekasten").paste_img_and_link()
    end,
    mode = "n",
    desc = "Telekasten: Paste image and link",
    { silent = true },
  },
  {
    "<leader>zI",
    function()
      require("telekasten").insert_img_link({ i = true })
    end,
    mode = "n",
    desc = "Telekasten: Insert image link",
    { silent = true },
  },
  {
    "<leader>zp",
    function()
      require("telekasten").preview_img()
    end,
    mode = "n",
    desc = "Telekasten: Preview image",
    { silent = true },
  },
  {
    "<leader>zm",
    function()
      require("telekasten").browse_media()
    end,
    mode = "n",
    desc = "Telekasten: Browse media",
    { silent = true },
  },

  -- Todo
  {
    "<leader>zt",
    function()
      require("telekasten").toggle_todo()
    end,
    mode = "n",
    desc = "Telekasten: Toggle todo",
    { silent = true },
  },
  {
    "<leader>zt",
    function()
      require("telekasten").toggle_todo({ v = true })
    end,
    mode = "v",
    desc = "Telekasten: Toggle todo (visual)",
    { silent = true },
  },

  -- Backlinks / Tags
  {
    "<leader>zb",
    function()
      require("telekasten").show_backlinks()
    end,
    mode = "n",
    desc = "Telekasten: Show backlinks",
    { silent = true },
  },
  {
    "<leader>#",
    function()
      require("telekasten").show_tags()
    end,
    mode = "n",
    desc = "Telekasten: Show tags",
    { silent = true },
  },

  -- Insert mode
  {
    "<leader>[",
    function()
      require("telekasten").insert_link({ i = true })
    end,
    mode = "i",
    desc = "Telekasten: Insert link",
    { silent = true },
  },
  {
    "<leader>zt",
    function()
      require("telekasten").toggle_todo({ i = true })
    end,
    mode = "i",
    desc = "Telekasten: Toggle todo (insert)",
    { silent = true },
  },
  {
    "<leader>#",
    function()
      require("telekasten").show_tags({ i = true })
    end,
    mode = "i",
    desc = "Telekasten: Show tags (insert)",
    { silent = true },
  },
}

return keys
