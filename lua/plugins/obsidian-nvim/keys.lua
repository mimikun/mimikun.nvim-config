---@type LazyKeysSpec[]
local keys = {
  -- Find / Search
  {
    "<leader>of",
    function()
      require("obsidian.picker").find_notes()
    end,
    mode = "n",
    desc = "Obsidian: Find notes",
    { silent = true },
  },
  --{
  --  "<leader>oD",
  --  function()
  --    require("telekasten").find_daily_notes()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Find daily notes",
  --  { silent = true },
  --},
  {
    "<leader>og",
    function()
      require("obsidian.picker").grep_notes()
    end,
    mode = "n",
    desc = "Obsidian: Search notes",
    { silent = true },
  },
  --{
  --  "<leader>oW",
  --  function()
  --    require("telekasten").find_weekly_notes()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Find weekly notes",
  --  { silent = true },
  --},
  --{
  --  "<leader>oF",
  --  function()
  --    require("telekasten").find_friends()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Find friends",
  --  { silent = true },
  --},

  -- Navigation
  --{
  --  "<leader>oz",
  --  function()
  --    require("telekasten").follow_link()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Follow link",
  --  { silent = true },
  --},
  --{
  --  "<leader>od",
  --  function()
  --    require("obsidian.daily").today()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Go to today",
  --  { silent = true },
  --},
  --{
  --  "<leader>ow",
  --  function()
  --    require("telekasten").goto_thisweek()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Go to this week",
  --  { silent = true },
  --},

  -- Create
  {
    "<leader>on",
    function()
      require("obsidian.actions").new()
    end,
    mode = "n",
    desc = "Obsidian: New note",
    { silent = true },
  },
  {
    "<leader>oN",
    function()
      require("obsidian.actions").new_from_template()
    end,
    mode = "n",
    desc = "Obsidian: New note from Template",
    { silent = true },
  },

  -- Yank / Clipboard
  --{
  --  "<leader>oy",
  --  function()
  --    require("telekasten").yank_notelink()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Yank note link",
  --  { silent = true },
  --},

  -- Calendar
  --{
  --  "<leader>oc",
  --  function()
  --    require("telekasten").show_calendar()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Show calendar",
  --  { silent = true },
  --},
  --{
  --  "<leader>oC",
  --  "<cmd>CalendarT<CR>",
  --  mode = "n",
  --  desc = "Obsidian: Open CalendarT",
  --  { silent = true },
  --},

  -- Media / Images
  --{
  --  "<leader>oi",
  --  function()
  --    require("telekasten").paste_img_and_link()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Paste image and link",
  --  { silent = true },
  --},
  --{
  --  "<leader>oI",
  --  function()
  --    require("telekasten").insert_img_link({ i = true })
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Insert image link",
  --  { silent = true },
  --},
  --{
  --  "<leader>op",
  --  function()
  --    require("telekasten").preview_img()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Preview image",
  --  { silent = true },
  --},
  --{
  --  "<leader>om",
  --  function()
  --    require("telekasten").browse_media()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Browse media",
  --  { silent = true },
  --},

  -- Todo
  --{
  --  "<leader>ot",
  --  function()
  --    require("telekasten").toggle_todo()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Toggle todo",
  --  { silent = true },
  --},
  --{
  --  "<leader>ot",
  --  function()
  --    require("telekasten").toggle_todo({ v = true })
  --  end,
  --  mode = "v",
  --  desc = "Obsidian: Toggle todo (visual)",
  --  { silent = true },
  --},

  -- Backlinks / Tags
  --{
  --  "<leader>ob",
  --  function()
  --    require("telekasten").show_backlinks()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Show backlinks",
  --  { silent = true },
  --},
  --{
  --  "<leader>#",
  --  function()
  --    require("telekasten").show_tags()
  --  end,
  --  mode = "n",
  --  desc = "Obsidian: Show tags",
  --  { silent = true },
  --},

  -- Insert mode
  --{
  --  "<leader>[",
  --  function()
  --    require("telekasten").insert_link({ i = true })
  --  end,
  --  mode = "i",
  --  desc = "Obsidian: Insert link",
  --  { silent = true },
  --},
  --{
  --  "<leader>ot",
  --  function()
  --    require("telekasten").toggle_todo({ i = true })
  --  end,
  --  mode = "i",
  --  desc = "Obsidian: Toggle todo (insert)",
  --  { silent = true },
  --},
  --{
  --  "<leader>#",
  --  function()
  --    require("telekasten").show_tags({ i = true })
  --  end,
  --  mode = "i",
  --  desc = "Obsidian: Show tags (insert)",
  --  { silent = true },
  --},

  --{
  --  -- TODO: it
  --  "<lhs>",
  --  function()
  --    -- TODO: it
  --  end,
  --  mode = "n",
  --  desc = "",
  --  { silent = true },
  --},
}

return keys
