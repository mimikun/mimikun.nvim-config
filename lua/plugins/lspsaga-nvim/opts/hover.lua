local open_cmds = {
  mac = "!open",
  windows = "!explorer",
  wsl = "!wsl-open",
  linux_x = "!xdg-open",
  --linux_way = "",
}

local hover = {
  max_width = 0.9,
  max_height = 0.8,
  open_link = "gx",
  open_cmd = open_cmds.wsl,
}

return hover
