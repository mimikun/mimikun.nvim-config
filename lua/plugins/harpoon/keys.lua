local harpoon = require("harpoon")
local conf = require("telescope.config").values

local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>a",
    function()
      harpoon:list():add()
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<C-e>",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<C-h>",
    function()
      harpoon:list():select(1)
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<C-t>",
    function()
      harpoon:list():select(2)
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<C-n>",
    function()
      harpoon:list():select(3)
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    "<C-s>",
    function()
      harpoon:list():select(4)
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    -- Toggle previous & next buffers stored within Harpoon list
    "<C-S-P>",
    function()
      harpoon:list():prev()
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    -- Toggle previous & next buffers stored within Harpoon list
    "<C-S-N>",
    function()
      harpoon:list():next()
    end,
    mode = "n",
    desc = "",
    --expr = true,
    --noremap = true,
    silent = true,
  },
  {
    -- basic telescope configuration
    "<C-e>",
    function()
      toggle_telescope(harpoon:list())
    end,
    mode = "n",
    desc = "Open harpoon window",
    --expr = true,
    --noremap = true,
    silent = true,
  },
}

return keys
