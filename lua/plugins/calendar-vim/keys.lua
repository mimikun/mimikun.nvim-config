---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>Kv",
    "CalendarV",
    mode = {
      "n",
    },
    desc = "Open vertical calendar",
    silent = true,
  },
  {
    "<leader>Kh",
    "CalendarH",
    mode = {
      "n",
    },
    desc = "Open horizontal calendar",
    silent = true,
  },
}

return keys
