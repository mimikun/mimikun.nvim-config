---@type table
local opts = {
  repositories = {
    {
      name = "personal",
      -- optional display label
      alias = "Personal tasks",
      path = "~/notes/personal/Tasks.md",
    },
    {
      name = "work",
      vault = "~/notes/work",
      todo_file = "Projects/Tasks.md",
    },
  },

  view = {
    ---@type string | "float" | "window"
    type = "float",

    -- fraction of editor width
    width = 0.5,

    -- fraction of editor height
    height = 0.5,

    border = "rounded",

    title = " Obsidian tasks ",

    -- close a float when focus leaves it
    close_on_leave = true,

    ---@type string | "sections" | "tabs"
    repository_mode = "sections",

    window_command = "botright new",

    ---@type string | "active" | "done" | "all"
    status = "active",

    ---@type string | "source" | "deadline" | "title"
    sort = "source",

    -- optional initial tag filter, e.g. "#work"
    filter = nil,

    -- initially expand groups through this tag depth
    fold_level = 99,
  },

  dates = {
    -- strftime format used in the task view
    display_format = "%d.%m.%Y",
  },

  creation = {
    default_start_today = true,
    prompt_additional_tags = true,
    infinity_marker = "♾️",
  },

  completion = {
    marker = "✅",
  },

  mappings = {
    -- global mapping, nil disables it
    open = "<leader>to",

    -- global mapping, nil disables it
    create = "<leader>ta",
    create_in_view = "a",
    toggle = "<Space>",
    edit = "<CR>",
    delete = "d",
    undo = "u",
    open_source = "gf",
    refresh = "r",
    close = {
      "q",
      "<Esc>",
    },
    cycle_status = "s",
    cycle_sort = "o",
    filter = "f",
    next_repository = "<Tab>",
    previous_repository = "<S-Tab>",
  },
}

return opts
