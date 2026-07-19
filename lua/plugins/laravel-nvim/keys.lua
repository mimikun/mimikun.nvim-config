---@type LazyKeysSpec[]
local keys = {
  {
    -- TODO: it
    "<lhs>",
    function()
      -- TODO: it
    end,
    mode = {
      "n",
      -- TODO: it
      --"x",
      --"v",
    },
    desc = "",
    -- TODO: it
    --expr = true,
    --noremap = true,
    silent = true,
  },
}
local readme_keys = {
  {
    "<leader>ll",
    function()
      Laravel.pickers.laravel()
    end,
    desc = "Laravel: Picker",
  },
  {
    "<leader>la",
    function()
      Laravel.pickers.artisan()
    end,
    desc = "Laravel: Artisan Picker",
  },
  {
    "<leader>lr",
    function()
      Laravel.pickers.routes()
    end,
    desc = "Laravel: Routes Picker",
  },
  {
    "<leader>lm",
    function()
      Laravel.pickers.make()
    end,
    desc = "Laravel: Make Picker",
  },
  {
    "<leader>lc",
    function()
      Laravel.pickers.commands()
    end,
    desc = "Laravel: Custom Commands Picker",
  },
  {
    "<leader>lo",
    function()
      Laravel.pickers.resources()
    end,
    desc = "Laravel: Resources Picker",
  },
  {
    "<leader>lh",
    function()
      Laravel.run("artisan docs")
    end,
    desc = "Laravel: Documentation",
  },
  {
    "<leader>lt",
    function()
      Laravel.commands.run("actions")
    end,
    desc = "Laravel: Code Actions",
  },
  {
    "<leader>lu",
    function()
      Laravel.commands.run("hub")
    end,
    desc = "Laravel: Artisan Hub",
  },
  {
    "<leader>lp",
    function()
      Laravel.commands.run("command_center")
    end,
    desc = "Laravel: Command Center",
  },
  {
    "<c-g>",
    function()
      Laravel.commands.run("view:finder")
    end,
    desc = "Laravel: View Finder",
  },
  {
    "gf",
    function()
      if Laravel.app("gf").cursorOnResource() then
        return "<cmd>lua Laravel.commands.run('gf')<cr>"
      end
      return "gf"
    end,
    expr = true,
    noremap = true,
    desc = "Laravel: Go to resource",
  },
}

return keys
