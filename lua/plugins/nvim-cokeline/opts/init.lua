-- cokeline's `components` is a *list*, and `cokeline/config.lua`'s `update()` replaces lists
-- wholesale instead of merging them. So the moment one extra component is wanted, the whole
-- default list has to be spelled out here.
--
-- Everything after the first entry is a verbatim copy of `defaults.components` in
-- CODES/lua/cokeline/config.lua; keep it in sync when the plugin is updated.
--
-- The added first entry is what makes two mapping families usable at all:
--   - `<leader>b1`..`<leader>b9` -> `<Plug>(cokeline-focus-N)` needs the index on screen
--   - `<leader>bP` / `<leader>bd` -> `mappings.pick(...)` blocks on `getchar()` waiting for a
--     `pick_letter` that the default components never render
--
-- Colours go through `hlgroups.get_hl_attr` rather than literal hex so they follow the
-- colorscheme, the same way the stock `unique_prefix` component does.
-- See CODES/lua/cokeline/config.lua for every available option.

local function is_picking()
  local mappings = require("cokeline.mappings")
  return mappings.is_picking_focus() or mappings.is_picking_close()
end

---@type table
local opts = {
  components = {
    -- Normally the buffer index; switches to the pick letter while a pick is in flight.
    {
      text = function(buffer)
        if is_picking() then
          return " " .. buffer.pick_letter
        end
        return " " .. buffer.index
      end,
      fg = function()
        local mappings = require("cokeline.mappings")
        local hlgroups = require("cokeline.hlgroups")
        if mappings.is_picking_focus() then
          return hlgroups.get_hl_attr("Question", "fg")
        elseif mappings.is_picking_close() then
          return hlgroups.get_hl_attr("WarningMsg", "fg")
        end
        return hlgroups.get_hl_attr("Comment", "fg")
      end,
      bold = function()
        return is_picking()
      end,
    },
    {
      text = function(buffer)
        return " " .. buffer.devicon.icon
      end,
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    {
      text = function(buffer)
        return buffer.unique_prefix
      end,
      fg = function()
        return require("cokeline.hlgroups").get_hl_attr("Comment", "fg")
      end,
      italic = true,
    },
    {
      text = function(buffer)
        return buffer.filename
      end,
      underline = function(buffer)
        if buffer.is_hovered and not buffer.is_focused then
          return true
        end
      end,
    },
    {
      text = " ",
    },
    {
      ---@param buffer Buffer
      text = function(buffer)
        if buffer.is_modified then
          return ""
        end
        if buffer.is_hovered then
          return "󰅙"
        end
        return "󰅖"
      end,
      on_click = function(_, _, _, _, buffer)
        buffer:delete()
      end,
    },
    {
      text = " ",
    },
  },
}

return opts
