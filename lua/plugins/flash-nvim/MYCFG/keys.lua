---@param opts Flash.Format
local function format(opts)
  -- always show first and second label
  return {
    { opts.match.label1, "FlashMatch" },
    { opts.match.label2, "FlashLabel" },
  }
end

---@type LazyKeysSpec[]
local keys = {
  {
    "<leader>ls",
    function()
      require("flash").jump()
    end,
    mode = {
      "n",
      "x",
      "o",
    },
    desc = "Flash",
    silent = true,
  },
  {
    "<leader>lS",
    function()
      require("flash").treesitter()
    end,
    mode = {
      "n",
      "x",
      "o",
    },
    desc = "Flash Treesitter",
    silent = true,
  },
  {
    "<leader>lr",
    function()
      require("flash").remote()
    end,
    mode = {
      "o",
    },
    desc = "Remote Flash",
    silent = true,
  },
  {
    "<leader>lR",
    function()
      require("flash").treesitter_search()
    end,
    mode = {
      "o",
      "x",
    },
    desc = "Treesitter Search",
    silent = true,
  },
  {
    "<leader><c-s>",
    function()
      require("flash").toggle()
    end,
    mode = {
      "c",
    },
    desc = "Toggle Flash Search",
    silent = true,
  },
  {
    "<leader><c-space>",
    function()
      require("flash").treesitter({
        actions = {
          ["<c-space>"] = "next",
          ["<BS>"] = "prev",
        },
      })
    end,
    mode = {
      "n",
      "x",
      "o",
    },
    desc = "Treesitter incremental selection",
    silent = true,
  },
  {
    "<leader>lh",
    function()
      require("flash").jump({
        search = { mode = "search" },
        label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
        pattern = [[\<]],
        action = function(match, state)
          state:hide()
          require("flash").jump({
            search = { max_length = 0 },
            highlight = { matches = false },
            label = { format = format },
            matcher = function(win)
              -- limit matches to the current label
              return vim.tbl_filter(function(m)
                return m.label == match.label and m.win == win
              end, state.results)
            end,
            labeler = function(matches)
              for _, m in ipairs(matches) do
                m.label = m.label2 -- use the second label
              end
            end,
          })
        end,
        labeler = function(matches, state)
          local labels = state:labels()
          for m, match in ipairs(matches) do
            match.label1 = labels[math.floor((m - 1) / #labels) + 1]
            match.label2 = labels[(m - 1) % #labels + 1]
            match.label = match.label1
          end
        end,
      })
    end,
    mode = {
      "n",
    },
    desc = "2-char jump, similar to mini.jump2d or HopWord (hop.nvim)",
    silent = true,
  },
}

return keys
