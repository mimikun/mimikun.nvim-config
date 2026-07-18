local _mac_home = vim.fn.expand("$HOME/Documents/Zettelkasten")
local linux_home = vim.fn.expand("$HOME/Documents/Zettelkasten")
local _win_home = vim.fn.expand("E:/Documents/Zettelkasten")
local home = linux_home

---@type table
local opts = {
  home = home,

  -- If set to `true`, telekasten.nvim will take over your home.
  -- Any notes from the configured `home` directory will receive a `set` `filetype=telekasten`, no matter if opened by telekasten or another way.
  take_over_my_home = true,

  -- If `false`, the telekasten filetype will not be set.
  -- Markdown files will get the markdown filetype.
  auto_set_filetype = true,

  -- If `false`, the telekasten syntax will not be set.
  auto_set_syntax = true,

  -- dir names for special notes (absolute path or subdir name)
  dailies = home,
  weeklies = home,
  monthlies = home,
  quarterlies = home,
  yearlies = home,
  templates = home,

  -- Image subdir for pasting
  image_subdir = "img",

  -- File extension for note files
  extension = ".md",

  -- Generate note filenames.
  ---@type string "title" | "uuid" | "uuid-title" | "title-uuid"
  new_note_filename = "title",

  -- file uuid type ("rand" or input for os.date such as "%Y%m%d%H%M")
  uuid_type = "%Y%m%d%H%M",

  -- UUID separator
  uuid_sep = "-",

  -- When the note title is used within the filename, i.e. |new_note_filename| contains 'title', spaces in the title will be substituted for |filename_space_subst|.
  -- e.g. if set to '_', '20230103-my new note title.md' would instead become '20230103-my_new_note_title.md'
  -- If set to `nil`, no substitution will occur.
  filename_space_subst = nil,

  -- When the note title is used within the filename, i.e. |new_note_filename| contains 'title', the tile will be made lowercase.
  -- e.g. if set to true, '20230103-My New Note Title.md' would instead become '20230103-my new note title.md'
  -- If set to `false`, no substitution will occur.
  filename_small_case = false,

  -- Flags for creating non-existing notes
  -- create non-existing on follow
  follow_creates_nonexisting = true,
  -- create non-existing dailies
  dailies_create_nonexisting = true,
  -- create non-existing weeklies
  weeklies_create_nonexisting = true,
  -- create non-existing monthlies
  monthlies_create_nonexisting = true,
  -- create non-existing quarterlies
  quarterlies_create_nonexisting = true,
  -- create non-existing yearlies
  yearlies_create_nonexisting = true,

  -- allow following links to files outside the current vault (absolute paths)
  external_link_follow = true,

  -- skip telescope prompt for goto_today and goto_thisweek
  journal_auto_open = false,

  -- Specific note templates
  -- template for new notes
  template_new_note = home .. "/" .. "templates/new_note.md",
  -- vim.fn.expand("~/zettelkasten/templates/basenote.md")

  -- template for new daily notes
  template_new_daily = home .. "/" .. "templates/daily_tk.md",
  -- vim.fn.expand("~/zettelkasten/templates/daily.md")

  -- template for new weekly notes
  template_new_weekly = home .. "/" .. "templates/weekly_tk.md",
  -- vim.fn.expand("~/zettelkasten/templates/weekly.md")

  -- template for new monthly notes
  template_new_monthly = home .. "/" .. "templates/monthly_tk.md",
  -- vim.fn.expand("~/zettelkasten/templates/monthly.md")

  -- template for new quarterly notes
  template_new_quarterly = home .. "/" .. "templates/quarterly_tk.md",
  --vim.fn.expand("~/zettelkasten/templates/quarterly.md")

  -- template for new yearly notes
  template_new_yearly = home .. "/" .. "templates/yearly_tk.md",
  --vim.fn.expand("~/zettelkasten/templates/yearly.md")

  -- image link style
  ---@type string "wiki" | "markdown"
  image_link_style = "markdown",

  -- default sort option
  ---@type string "filename" | "modified"
  sort = "filename",

  -- when linking to a note in subdir/, create a [[subdir/title]] link instead of a [[title only]] link
  subdirs_in_links = true,

  -- integrate with calendar-vim
  plug_into_calendar = true,
  calendar_opts = {
    -- 1: 'WK01'
    -- 2: 'WK 1'
    -- 3: 'KW01'
    -- 4: 'KW 1'
    -- 5: '1'
    -- calendar week display mode:
    ---@type number 1 | 2 | 3 | 4 | 5
    weeknm = 4,

    -- use monday as first day of week:
    -- 1: true
    -- 0: false
    ---@type number 1 | 0
    calendar_monday = 1,

    -- calendar mark placement
    ---@type string "left" | "right" | "left-fit"
    calendar_mark = "left-fit",
  },

  close_after_yanking = false,
  insert_after_inserting = true,

  -- Tag notation:
  ---@type string "#tag" | "@tag" | ":tag:" | "yaml-bare"
  tag_notation = "#tag",

  ---@type string "dropdown" | "ivy"
  command_palette_theme = "ivy",

  ---@type string "get_cursor" | "dropdown" | "ivy"
  show_tags_theme = "ivy",

  ---@type string "smart" | "prefer_new_note" | "always_ask"
  template_handling = "smart",

  ---@type string "smart" | "prefer_home" | "same_as_current"
  new_note_location = "smart",

  -- If `true`, telekasten will automatically update the links after a file has been renamed.
  rename_update_links = true,

  -- Previewer for media files (images mostly)
  ---@type string "telescope-media-files" | "catimg-previewer" | "viu-previewer"
  media_previewer = "telescope-media-files",

  -- Customize insert image and preview image files list.
  -- This is useful to add optional filetypes into filtered list (for example telescope-media-files optionally supporting svg preview)
  media_extensions = {
    ".png",
    ".jpg",
    ".bmp",
    ".gif",
    ".pdf",
    ".mp4",
    ".webm",
    ".webp",
  },

  -- A customizable fallback handler for urls
  ---@type string "xdg-open" | "open" | "call jobstart('firefox --new-window {{url}}')" | nil
  follow_url_fallback = nil,

  -- Specify a clipboard program to use
  ---@type string "xsel" | "xclip" | "wl-paste" | "osascript"
  clipboard_program = "wl-paste",

  -- Make syntax available to markdown buffers and telescope previewers
  install_syntax = true,

  vaults = {
    personal = {
      -- configuration for personal vault. E.g.:
      -- home = "/home/user/vaults/personal",
    },
  },
}

return opts
