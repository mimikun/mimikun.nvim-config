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
    silent = true,
  },
  {
    "<leader>od",
    function()
      require("obsidian.daily").pick(-5, 0, function(note)
        note:open()
      end)
    end,
    mode = "n",
    desc = "Obsidian: Find daily notes",
    silent = true,
  },
  {
    "<leader>og",
    function()
      require("obsidian.picker").grep_notes()
    end,
    mode = "n",
    desc = "Obsidian: Search notes",
    silent = true,
  },
  {
    "<leader>ow",
    function()
      require("obsidian.picker").find_notes({
        query = "-W",
        prompt_title = "Weekly Notes",
      })
    end,
    mode = "n",
    desc = "Obsidian: Find weekly notes",
    silent = true,
  },
  {
    "<leader>oF",
    function()
      require("obsidian.commands.backlinks")()
    end,
    mode = "n",
    desc = "Obsidian: Find backlinks (friends)",
    silent = true,
  },

  -- Navigation
  {
    "<leader>oz",
    function()
      require("obsidian.actions").follow_link()
    end,
    mode = "n",
    desc = "Obsidian: Follow link",
    silent = true,
  },
  {
    "<leader>oT",
    function()
      local note = require("obsidian.daily").today()
      note:open()
    end,
    mode = "n",
    desc = "Obsidian: Go to today",
    silent = true,
  },
  {
    "<leader>oW",
    function()
      require("obsidian.actions").new(os.date("%Y-W%V"))
    end,
    mode = "n",
    desc = "Obsidian: Go to this week",
    silent = true,
  },

  -- Create
  {
    "<leader>on",
    function()
      require("obsidian.actions").new()
    end,
    mode = "n",
    desc = "Obsidian: New note",
    silent = true,
  },
  {
    "<leader>oN",
    function()
      require("obsidian.actions").new_from_template()
    end,
    mode = "n",
    desc = "Obsidian: New note from Template",
    silent = true,
  },

  -- Yank / Clipboard
  {
    "<leader>oy",
    function()
      local note = require("obsidian.api").current_note(0)
      if note then
        local link = note:format_link()
        vim.fn.setreg("+", link)
        vim.notify("Copied: " .. link, vim.log.levels.INFO)
      end
    end,
    mode = "n",
    desc = "Obsidian: Yank note link",
    silent = true,
  },

  -- Media / Images
  {
    "<leader>oi",
    function()
      require("obsidian.commands.paste_img")({ args = "", fargs = {} })
    end,
    mode = "n",
    desc = "Obsidian: Paste image",
    silent = true,
  },
  -- No obsidian.nvim equivalent: insert_img_link, preview_img, browse_media

  -- Todo / Checkbox
  {
    "<leader>ot",
    function()
      require("obsidian.actions").toggle_checkbox()
    end,
    mode = "n",
    desc = "Obsidian: Toggle checkbox",
    silent = true,
  },
  {
    "<leader>ot",
    function()
      require("obsidian.actions").toggle_checkbox()
    end,
    mode = "v",
    desc = "Obsidian: Toggle checkbox (visual)",
    silent = true,
  },

  -- Backlinks / Tags
  {
    "<leader>ob",
    function()
      require("obsidian.commands.backlinks")()
    end,
    mode = "n",
    desc = "Obsidian: Show backlinks",
    silent = true,
  },
  {
    "<leader>#",
    function()
      require("obsidian.commands.tags")({ fargs = {}, args = "" })
    end,
    mode = "n",
    desc = "Obsidian: Show tags",
    silent = true,
  },

  -- Link (visual mode: wrap selection in link)
  {
    "<leader>ol",
    function()
      require("obsidian.actions").link()
    end,
    mode = "v",
    desc = "Obsidian: Insert link",
    silent = true,
  },
}

return keys
