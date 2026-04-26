---@alias obsidian.sync.FileType
---"image" |
---"audio" |
---"video" |
---"pdf" |
---"unsupported"

---@alias obsidian.sync.ConfigCategory
---"app" |
---"appearance" |
---"appearance-data" |
---"hotkey" |
---"core-plugin" |
---"core-plugin-data" |
---"community-plugin" |
---"community-plugin-data"

local has_nvim_cmp, _ = pcall(require, "cmp")
local has_blink = pcall(require, "blink.cmp")

---@module 'obsidian'
---@type obsidian.config
local opts = {
  ---@type obsidian.workspace.WorkspaceSpec[]
  workspaces = {
    {
      name = "mimikun",
      path = "$HOME/Documents/Obsidian/mimikun",
    },
  },

  ---@type integer
  log_level = vim.log.levels.INFO,

  ---@type string | nil
  notes_subdir = nil,

  ---@type obsidian.config.TemplateOpts
  templates = {
    ---@type boolean | nil
    enabled = true,

    ---@type string | obsidian.Path | nil
    folder = nil,

    ---@type string
    date_format = "YYYY-MM-DD",

    ---@type string
    time_format = "HH:mm",

    -- A map for custom variables, the key should be the variable and the value a function.
    -- Functions are called with obsidian.TemplateContext objects and optional suffix strings.
    -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
    ---@type table<string, string|fun(ctx: obsidian.TemplateContext, suffix: string|?):string|?>
    substitutions = {
      date = function(_, suffix)
        local format = suffix or Obsidian.opts.templates.date_format
        return require("obsidian.util").format_date(os.time(), format)
      end,
      time = function(_, suffix)
        local format = suffix or Obsidian.opts.templates.time_format
        return require("obsidian.util").format_date(os.time(), format)
      end,
      title = function(ctx)
        return ctx.partial_note and ctx.partial_note:display_name()
      end,
      id = function(ctx)
        return ctx.partial_note and ctx.partial_note.id
      end,
      path = function(ctx)
        return ctx.partial_note and tostring(ctx.partial_note.path)
      end,
    },

    ---@type table<string, obsidian.config.CustomTemplateOpts>|?
    customizations = {
      ---@type string
      --notes_subdir = nil,

      ---@type note_id_func? (fun(title: string|?, path: obsidian.Path|?): string)
      --note_id_func = nil,
    },
  },

  ---@type obsidian.config.NewNotesLocation
  new_notes_location = "current_dir",

  -- random zettel IDs.
  ---@type (fun(title: string|?, path: obsidian.Path|?): string)|?
  --note_id_func = require("obsidian.builtin").zettel_id,
  -- readable UTF-8 slug IDs
  ---@type (fun(title: string|?, path: obsidian.Path|?): string)|?
  note_id_func = require("obsidian.builtin").title_id,

  ---@type fun(spec: { id: string, dir: obsidian.Path, title: string|? }): string|obsidian.Path
  note_path_func = function(spec)
    -- This is equivalent to the default behavior.
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md", true)
  end,

  ---@type obsidian.config.FrontmatterOpts
  frontmatter = {
    -- Whether to enable frontmatter, boolean for global on/off, or a function that takes filename and returns boolean.
    ---@type (fun(fname: string?): boolean)|boolean
    enabled = true,

    -- Function to turn Note attributes into frontmatter.
    ---@type fun(note: obsidian.Note): table<string, any>
    func = require("obsidian.builtin").frontmatter,

    -- Function that is passed to table.sort to sort the properties, or a fixed order of properties.
    -- List of string that sorts frontmatter properties, or a function that compares two values, set to vim.NIL/false to do no sorting
    ---@type string[] | (fun(a: any, b: any): boolean) | vim.NIL | boolean
    sort = {
      "id",
      "aliases",
      "tags",
    },
  },

  ---@type obsidian.config.BacklinkOpts
  backlinks = {
    ---@type boolean
    parse_headers = true,
  },

  ---@type obsidian.config.CompletionOpts
  completion = {
    ---@type boolean
    nvim_cmp = has_nvim_cmp and not has_blink,

    ---@type boolean
    blink = has_blink,

    ---@type integer
    min_chars = 2,

    ---@type boolean
    match_case = true,

    ---@type boolean
    create_new = true,
  },

  ---@type obsidian.config.PickerOpts
  picker = {
    ---@type obsidian.config.Picker | nil
    name = nil,

    ---@type obsidian.config.PickerNoteMappingOpts
    note_mappings = {
      ---@type string
      new = "<C-x>",

      ---@type string
      insert_link = "<C-l>",
    },

    ---@type obsidian.config.PickerTagMappingOpts
    tag_mappings = {
      ---@type string
      tag_note = "<C-x>",

      ---@type string
      insert_tag = "<C-l>",
    },
  },

  ---@type obsidian.config.DailyNotesOpts
  daily_notes = {
    ---@type boolean
    enabled = true,

    ---@type string
    folder = nil,

    ---@type string
    date_format = "YYYY-MM-DD",

    ---@type string
    alias_format = nil,

    ---@type string[]
    default_tags = {
      "daily-notes",
    },

    ---@type boolean
    workdays_only = true,
  },

  ---@type obsidian.config.OpenStrategy
  open_notes_in = "current",

  ---@type obsidian.config.UIOpts
  ui = {
    ---@type boolean
    enable = true,

    ---@type boolean
    --enabled = true,

    ---@type boolean
    ignore_conceal_warn = false,

    ---@type integer
    update_debounce = 200,

    ---@type integer | nil
    max_file_length = 5000,

    ---@type table<string, obsidian.config.CheckboxSpec>
    --checkboxes = {
    --  [" "] = {
    --    ---@type string
    --    char = "󰄱",

    --    ---@type string
    --    hl_group = "obsidiantodo",
    --  },
    --  ["~"] = {
    --    ---@type string
    --    char = "󰰱",

    --    ---@type string
    --    hl_group = "obsidiantilde",
    --  },
    --  ["!"] = {
    --    ---@type string
    --    char = "",

    --    ---@type string
    --    hl_group = "obsidianimportant",
    --  },
    --  [">"] = {
    --    ---@type string
    --    char = "",

    --    ---@type string
    --    hl_group = "obsidianrightarrow",
    --  },
    --  ["x"] = {
    --    ---@type string
    --    char = "",

    --    ---@type string
    --    hl_group = "obsidiandone",
    --  },
    --},

    ---@type obsidian.config.UICharSpec | nil
    bullets = {
      ---@type string
      char = "•",

      ---@type string
      hl_group = "ObsidianBullet",
    },

    ---@type obsidian.config.UICharSpec
    external_link_icon = {
      ---@type string
      char = "",

      ---@type string
      hl_group = "ObsidianExtLinkIcon",
    },

    ---@type obsidian.config.UIStyleSpec
    reference_text = {
      ---@type string
      hl_group = "ObsidianRefText",
    },

    ---@type obsidian.config.UIStyleSpec
    highlight_text = {
      ---@type string
      hl_group = "ObsidianHighlightText",
    },

    ---@type obsidian.config.UIStyleSpec
    tags = {
      ---@type string
      hl_group = "ObsidianTag",
    },

    ---@type obsidian.config.UIStyleSpec
    block_ids = {
      ---@type string
      hl_group = "ObsidianBlockID",
    },

    ---@type table<string, table>
    hl_groups = {
      ObsidianTodo = {
        bold = true,
        fg = "#f78c6c",
      },
      ObsidianDone = {
        bold = true,
        fg = "#89ddff",
      },
      ObsidianRightArrow = {
        bold = true,
        fg = "#f78c6c",
      },
      ObsidianTilde = {
        bold = true,
        fg = "#ff5370",
      },
      ObsidianImportant = {
        bold = true,
        fg = "#d73128",
      },
      ObsidianBullet = {
        bold = true,
        fg = "#89ddff",
      },
      ObsidianRefText = {
        underline = true,
        fg = "#c792ea",
      },
      ObsidianExtLinkIcon = {
        fg = "#c792ea",
      },
      ObsidianTag = {
        italic = true,
        fg = "#89ddff",
      },
      ObsidianBlockID = {
        italic = true,
        fg = "#89ddff",
      },
      ObsidianHighlightText = {
        bg = "#75662e",
      },
    },
  },

  ---@type obsidian.config.AttachmentsOpts
  attachments = {
    -- Default folder to save images to, relative to the vault root (/) or current dir (.), see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images#change-image-save-location
    ---@type string
    folder = "attachments",

    -- Default name for pasted images
    ---@type fun(): string
    img_name_func = function()
      return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
    end,

    -- Default text to insert for pasted images
    ---@type fun(path: obsidian.Path): string
    img_text_func = require("obsidian.builtin").img_text_func,

    -- Whether to confirm the paste or not.
    -- Defaults to true.
    ---@type boolean
    confirm_img_paste = true,
  },

  ---@type obsidian.config.CallbackConfig
  callbacks = {
    -- Runs right after setup
    ---@type fun()
    post_setup = function()
      -- TODO: its?
    end,

    -- Runs when entering a note buffer.
    ---@type fun(note: obsidian.Note)
    enter_note = function(note)
      -- TODO: its?
    end,

    -- Runs when leaving a note buffer.
    ---@type fun(note: obsidian.Note)
    leave_note = function(note)
      -- TODO: its?
    end,

    -- Runs right before writing a note buffer.
    ---@type fun(note: obsidian.Note)
    pre_write_note = function(note)
      -- TODO: its?
    end,

    -- Runs anytime the workspace is set/changed.
    ---@type fun(workspace: obsidian.Workspace)
    post_set_workspace = function(workspace)
      -- TODO: its?
    end,
  },

  ---@type boolean
  legacy_commands = false,

  ---@type obsidian.config.FooterOpts
  footer = {
    ---@type boolean
    enabled = true,

    ---@type string
    format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",

    ---@type string
    hl_group = "Comment",

    -- Set false to disable separator; set an empty string to insert a blank line separator.
    ---@type string | false
    separator = string.rep("-", 80),
  },

  ---@type obsidian.config.OpenOpts
  open = {
    -- Opens the file with current line number
    ---@type boolean
    use_advanced_uri = false,

    -- Function to do the opening, default to vim.ui.open
    ---@type fun(uri: string)
    func = vim.ui.open,

    -- URI scheme whitelist, new values are appended to this list, and URIs with schemes in this list, will not be prompted to confirm opening
    ---@type string[]
    schemes = {
      "https",
      "http",
      "file",
      "mailto",
    },
  },

  ---@type obsidian.config.CheckboxOpts
  checkbox = {
    ---@type boolean
    enabled = true,

    -- Whether to create new checkbox on paragraphs
    ---@type boolean
    create_new = true,

    -- Order of checkbox state chars, e.g. { " ", "x" }
    ---@type string[]
    order = {
      " ",
      "~",
      "!",
      ">",
      "x",
    },
  },

  ---@type obsidian.config.CommentOpts
  comment = {
    ---@type boolean
    enabled = false,
  },

  ---@type obsidian.config.SearchOpts
  search = {
    ---@type string | false
    sort_by = "modified",

    ---@type boolean
    sort_reversed = true,

    ---@type integer
    max_lines = 1000,
  },

  ---@type obsidian.config.NoteOpts
  note = {
    -- Default template to use, relative to template.folder or an absolute path.
    ---@type string | nil
    template = (function()
      local root = vim.iter(vim.api.nvim_list_runtime_paths()):find(function(path)
        return vim.endswith(path, "obsidian.nvim")
      end)
      if not root then
        return nil
      end
      return vim.fs.joinpath(root, "data/default_template.md")
    end)(),
  },

  ---@type obsidian.config.LinkOpts
  link = {
    ---@type obsidian.link.LinkStyle | "wiki" | "markdown" | fun(opts: obsidian.link.LinkCreationOpts): string
    style = "wiki",

    ---@type obsidian.link.LinkFormat | "shortest" | "relative" | "absolute"
    format = "shortest",

    ---@type boolean
    auto_update = false,
  },

  ---@type obsidian.config.UniqueNoteOpts
  unique_note = {
    ---@type boolean
    enabled = true,

    ---@type string | fun():string
    format = "YYYYMMDDHHmm",

    ---@type string
    folder = nil,

    ---@type string
    template = nil,
  },

  ---https://help.obsidian.md/sync/settings
  ---@type obsidian.config.SyncOpts
  sync = {
    ---@type boolean
    enabled = false,

    -- Sync mode:
    -- bidirectional (default),
    -- pull-only (only download, ignore local changes),
    -- mirror-remote (only download, revert local changes)
    ---@type string | "bidirectional" | "pull-only" | "mirror-remote"
    mode = nil,

    -- NOTE: conflict is not currently supported in this client

    -- Conflict strategy when a conflict is detected,
    ---@type string | "merge" | "conflict"
    conflict_strategy = "merge",

    ---Folders to exclude
    ---@type string[]
    excluded_folders = {},

    -- -Device name to identify this client in the sync version history
    ---@type string
    device_name = nil,

    -- Attachment types to sync: image, audio, video, pdf, unsupported, empty table to disable attachment syncing
    ---@type obsidian.sync.FileType[]
    file_types = {
      "image",
      "audio",
      "video",
      "pdf",
      "unsupported",
    },

    -- Config categories to sync.
    -- nil = leave server config unchanged.
    -- {} = explicitly disable config syncing (pass --configs "").
    -- Non-empty list = sync only those categories.
    ---@type obsidian.sync.ConfigCategory[]
    configs = nil,

    -- Config directory name, this is for obsidian app
    ---@type string
    config_dir = ".obsidian",
  },

  ---@type obsidian.config.SlidesOpts
  slides = {
    ---@type boolean
    enabled = true,
  },
}

return opts
