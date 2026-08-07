-- Bring tasks from other plugins into the calendar
local integrations = {
  dooing = {
    -- show dooing.nvim todos on their due date
    enabled = true,

    -- also show completed todos
    show_done = true,
  },
}

return integrations
