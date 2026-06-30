local harpoon = require("harpoon")

---@type LazyKeysSpec[]
local keys = {
  {
    --vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
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
  {
    --vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
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
  {
    --vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
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
  {
    --vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
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
  {
    --vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
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
  {
    --vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
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
  {
    -- Toggle previous & next buffers stored within Harpoon list
    --vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
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
  {
    -- Toggle previous & next buffers stored within Harpoon list
    --vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
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
  {
    --[[
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
]]
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
}

return keys
