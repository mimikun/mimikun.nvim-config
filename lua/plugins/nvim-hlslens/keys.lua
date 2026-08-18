---Build a callback running a `normal!` search motion, then showing the lens.
---@param motion string motion fed to `normal!` (e.g. "n", "*", "g#")
---@param counted boolean? prefix the motion with `v:count1`
---@return function
local function search(motion, counted)
  return function()
    local ok, err = pcall(vim.cmd, "normal! " .. (counted and vim.v.count1 or "") .. motion)
    if not ok then
      vim.notify(tostring(err), vim.log.levels.ERROR)
      return
    end
    require("hlslens").start()
  end
end

---@type LazyKeysSpec[]
local keys = {
  {
    "n",
    search("n", true),
    mode = {
      "n",
    },
    desc = "Next search match",
    noremap = true,
    silent = true,
  },
  {
    "N",
    search("N", true),
    mode = {
      "n",
    },
    desc = "Prev search match",
    noremap = true,
    silent = true,
  },
  {
    "*",
    search("*"),
    mode = {
      "n",
    },
    desc = "Search word under cursor (forward)",
    noremap = true,
    silent = true,
  },
  {
    "#",
    search("#"),
    mode = {
      "n",
    },
    desc = "Search word under cursor (backward)",
    noremap = true,
    silent = true,
  },
  {
    "g*",
    search("g*"),
    mode = {
      "n",
    },
    desc = "Search partial word under cursor (forward)",
    noremap = true,
    silent = true,
  },
  {
    "g#",
    search("g#"),
    mode = {
      "n",
    },
    desc = "Search partial word under cursor (backward)",
    noremap = true,
    silent = true,
  },
  {
    "<leader>l",
    function()
      vim.cmd("nohlsearch")
    end,
    mode = {
      "n",
    },
    desc = "Clear search highlight",
    noremap = true,
    silent = true,
  },
}

return keys
