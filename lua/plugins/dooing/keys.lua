---@type LazyKeysSpec[]
local keys = {
  -- Only set up keymap if it's enabled in config
  {
    "<leader>Dd",
    function()
      require("dooing").open_global_todo()
    end,
    mode = {
      "n",
    },
    desc = "Toggle Global Todo List",
    silent = true,
  },
  -- Set up project todo keymap if enabled
  {
    "<leader>DD",
    function()
      require("dooing").open_project_todo()
    end,
    mode = {
      "n",
    },
    desc = "Open Local Project Todo List",
    silent = true,
  },
  -- Set up due notification keymap if enabled
  {
    "<leader>DN",
    function()
      require("dooing").show_due_notification()
    end,
    mode = {
      "n",
    },
    desc = "Show Due Items Notification",
    silent = true,
  },
}

return keys
