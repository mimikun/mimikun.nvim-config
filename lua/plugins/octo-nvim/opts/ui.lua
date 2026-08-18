---@type OctoConfigUi
local ui = {
  -- conceallevel for octo buffers
  ---@type integer
  conceallevel = 2,

  -- show "modified" marks on the sign column
  ---@type boolean
  use_signcolumn = false,

  -- show "modified" marks on the status column
  ---@type boolean
  use_statuscolumn = true,

  ---@type boolean
  use_foldtext = true,
}

return ui
