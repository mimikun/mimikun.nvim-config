-- `Snacks.toggle` keymaps.

-- These live here rather than in `keys.lua` on purpose.
-- `Toggle:map()` also registers the mapping with which-key so the popup shows a state-dependent icon/color (green when on, yellow when off) and an `Enable ...` / `Disable ...` description.
-- A plain LazyKeysSpec entry cannot do that, since the which-key registration happens inside `Toggle:map()`.

-- Not mapped on purpose:
-- `indent`, `dim`, `words`, `scroll`, `zen` and `zoom`.
-- Those call `Snacks.<mod>.enable()` directly, which bypasses the `enabled = false` set in `opts/init.lua` and would collide with the plugins that already own those features.

---@return nil
local function setup()
  local Snacks = require("snacks")

  Snacks.toggle
    .option("spell", {
      name = "Spelling",
    })
    :map("<leader>us")

  Snacks.toggle
    .option("wrap", {
      name = "Wrap",
    })
    :map("<leader>uw")

  Snacks.toggle.line_number():map("<leader>ul")

  Snacks.toggle
    .option("relativenumber", {
      name = "Relative Number",
    })
    :map("<leader>uL")

  Snacks.toggle
    .option("conceallevel", {
      off = 0,
      on = 2,
      name = "Conceal",
    })
    :map("<leader>uc")

  Snacks.toggle.treesitter():map("<leader>uT")

  Snacks.toggle.inlay_hints():map("<leader>uh")

  Snacks.toggle
    .option("background", {
      off = "light",
      on = "dark",
      name = "Dark Background",
    })
    :map("<leader>ub")

  -- Picker backend.
  -- Neither snacks nor telescope wins outright, so this stays switchable;
  -- see `lua/config/picker.lua` for the reasoning.
  local Picker = require("config.picker")
  Snacks.toggle({
    id = "picker_backend",
    name = "Telescope",
    get = function()
      return Picker.backend() == "telescope"
    end,
    set = function(state)
      Picker.set(state and "telescope" or "snacks")
    end,
    wk_desc = {
      enabled = "Use snacks instead of ",
      disabled = "Use ",
    },
    notify = function(state)
      Snacks.notify("Picker backend: **" .. (state and "telescope" or "snacks") .. "**")
    end,
  }):map("<leader>uf")

  Snacks.toggle.profiler():map("<leader>up")
  Snacks.toggle.profiler_highlights():map("<leader>uP")
end

return setup
