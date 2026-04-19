-- buffer-local keymaps to be added to edgebar buffers.
-- Existing buffer-local keymaps will never be overridden.
-- Set to false to disable a builtin.
---@type table<string, fun(win:Edgy.Window)|false>
local keys = {
  -- close window
  ["q"] = function(win)
    win:close()
  end,
  -- hide window
  ["<c-q>"] = function(win)
    win:hide()
  end,
  -- close sidebar
  ["Q"] = function(win)
    win.view.edgebar:close()
  end,
  -- next open window
  ["]w"] = function(win)
    win:next({
      visible = true,
      focus = true,
    })
  end,
  -- previous open window
  ["[w"] = function(win)
    win:prev({
      visible = true,
      focus = true,
    })
  end,
  -- next loaded window
  ["]W"] = function(win)
    win:next({
      pinned = false,
      focus = true,
    })
  end,
  -- prev loaded window
  ["[W"] = function(win)
    win:prev({
      pinned = false,
      focus = true,
    })
  end,
  -- increase width
  ["<c-w>>"] = function(win)
    win:resize("width", 2)
  end,
  -- decrease width
  ["<c-w><lt>"] = function(win)
    win:resize("width", -2)
  end,
  -- increase height
  ["<c-w>+"] = function(win)
    win:resize("height", 2)
  end,
  -- decrease height
  ["<c-w>-"] = function(win)
    win:resize("height", -2)
  end,
  -- reset all custom sizing
  ["<c-w>="] = function(win)
    win.view.edgebar:equalize()
  end,
}

return keys
