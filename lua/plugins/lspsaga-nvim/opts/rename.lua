---@type LspsagaConfig.Rename
local rename = {
  ---@type boolean
  in_select = true,

  ---@type boolean
  auto_save = false,

  ---@type number
  project_max_width = 0.5,

  ---@type number
  project_max_height = 0.5,

  ---@type LspsagaConfig.Rename.Keys
  keys = {
    -- quit rename window or `project_replace` window
    ---@type string | string[]
    quit = "<C-k>",

    -- execute rename in `rename` window or execute replace in `project_replace` window
    ---@type string | string[]
    exec = "<CR>",

    -- select or cancel select item in `project_replace` float window
    ---@type string | string[]
    select = "x",
  },
}

return rename
