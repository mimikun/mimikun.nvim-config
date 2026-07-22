---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>cal",
    "CalendarV",
    mode = {
      "n",
    },
    desc = "Open vertical calendar",
    silent = true,
  },
  {
    "<leader>caL",
    "CalendarH",
    mode = {
      "n",
    },
    desc = "Open horizontal calendar",
    silent = true,
  },
}

return keys
