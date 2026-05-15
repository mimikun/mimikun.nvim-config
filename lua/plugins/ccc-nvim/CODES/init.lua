  vim.keymap.set("i", "<Plug>(ccc-insert)", function()
require("ccc.core").new():insert()
  end)

  vim.keymap.set("o", "<Plug>(ccc-select-color)", function()
    require("ccc.select").select("v")
  end)
  vim.keymap.set("x", "<Plug>(ccc-select-color)", function()
    require("ccc.select").select("o")
  end)

