-- Fuzzy buffer picker that honours cokeline's own buffer order.
--
-- `<leader>Fb` (lua/config/picker.lua) already offers a backend-agnostic buffer picker, but it
-- lists buffers in bufnr order. Once `<leader>bH` / `<leader>bL` have moved buffers around, the
-- tabline order and the bufnr order disagree, and the picker no longer matches what is on screen.
-- This module reads `cokeline.state.visible_buffers` so the picker lists exactly the tabline,
-- in exactly the tabline's order.
--
-- snacks-only, deliberately: cokeline order needs a custom finder, and a telescope equivalent
-- would mean a separate `finders.new_table` + `entry_maker`. It is therefore NOT registered as a
-- source in `lua/config/picker.lua`, and `<leader>uf` does not affect it. When bufnr order is
-- good enough, `<leader>Fb` remains available on both backends.

local M = {}

---Open a snacks picker over cokeline's visible buffers, in tabline order.
function M.buffers()
  -- snacks is lazy-loaded, so it may not be on the runtimepath yet when the keymap fires.
  pcall(function()
    require("lazy").load({
      plugins = {
        "snacks.nvim",
      },
    })
  end)

  local state = require("cokeline.state")
  local visible = state.visible_buffers

  -- `visible_buffers` is populated while the tabline renders, so it is empty until the first draw.
  if not visible or #visible == 0 then
    vim.notify("cokeline: no visible buffers to pick from", vim.log.levels.WARN)
    return
  end

  -- Snapshot the buffers now: the picker's finder runs later, and cokeline rebuilds the list on
  -- every redraw.
  local items = {}
  for _, buffer in ipairs(visible) do
    local path = buffer.path
    items[#items + 1] = {
      -- The default sort is score desc, then `idx`, so with an empty query the tabline order wins.
      idx = buffer.index,
      buf = buffer.number,
      file = path ~= "" and path or buffer.filename,
      -- What the matcher scans; the index is included so "3" narrows to the third buffer.
      text = ("%d %s"):format(buffer.index, path ~= "" and path or buffer.filename),
    }
  end

  -- `format = "buffer"` reuses snacks' own buffer rendering and preview, which only read
  -- `item.buf`. The `<c-x>` / `dd` delete keys do NOT come with it: they live in the `buffers`
  -- entry of snacks' `picker/config/sources.lua`, and a custom `source` name gets no source
  -- config at all. They are restored here so this picker behaves like `<leader>Fb`.
  require("snacks").picker.pick({
    source = "cokeline_buffers",
    title = "Cokeline Buffers",
    format = "buffer",
    finder = function()
      return items
    end,
    win = {
      input = {
        keys = {
          ["<c-x>"] = {
            "bufdelete",
            mode = {
              "n",
              "i",
            },
          },
        },
      },
      list = {
        keys = {
          ["dd"] = "bufdelete",
        },
      },
    },
  })
end

return M
