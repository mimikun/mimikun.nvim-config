---@type LazyKeysSpec[]
local keys = {
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  --<leader>mo - open the minimap
  --require('codewindow').open_minimap()

  --<leader>mc - close the minimap
  --require('codewindow').close_minimap()

  --<leader>mf - focus/unfocus the minimap
  --require('codewindow').toggle_focus()

  --<leader>mm - toggle the minimap
  --require('codewindow').toggle_minimap()
}

return keys
