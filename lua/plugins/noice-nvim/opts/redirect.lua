-- default options for require('noice').redirect
-- see the section on Command Redirection
---@type NoiceRouteConfig
local redirect = {
  view = "popup",
  filter = {
    event = "msg_show",
  },
}

return redirect
