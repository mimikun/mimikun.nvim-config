-- WRAPPER FOR `vim.fn.fnamemodify()`, EXPANDS PATHS
--local expand = require("project.util").strip_slash

local custom_projects = {
  -- CAUTION:
  -- The `path` field has to be an absolute path!

  --{
  --  path = expand("~/Projects"),
  --},
  -- The `name` field is optional
  --{
  --  path = expand("~/Documents"),
  --  name = "Documents",
  --},
}

return custom_projects
