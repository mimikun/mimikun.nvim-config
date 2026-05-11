local actions = require("nvim-navbuddy.actions")

-- by user are set.
-- Else default mappings are used for keys that are not set by user
---@type table<string, KeyMapping>
local mappings = {
  -- Close and cursor to original location
  ["<esc>"] = actions.close(),

  ["q"] = actions.close(),

  -- down
  ["j"] = actions.next_sibling(),

  -- up
  ["k"] = actions.previous_sibling(),

  -- Move to left panel
  ["h"] = actions.parent(),

  -- Move to right panel
  ["l"] = actions.children(),

  -- Move to first panel
  ["0"] = actions.root(),

  -- Visual selection of name
  ["v"] = actions.visual_name(),

  -- Visual selection of scope
  ["V"] = actions.visual_scope(),

  -- Yank the name to system clipboard "+
  ["y"] = actions.yank_name(),

  -- Yank the scope to system clipboard "+
  ["Y"] = actions.yank_scope(),

  -- Insert at start of name
  ["i"] = actions.insert_name(),

  -- Insert at start of scope
  ["I"] = actions.insert_scope(),

  -- Insert at end of name
  ["a"] = actions.append_name(),

  -- Insert at end of scope
  ["A"] = actions.append_scope(),

  -- Rename currently focused symbol
  ["r"] = actions.rename(),

  -- Delete scope
  ["d"] = actions.delete(),

  -- Create fold of current scope
  ["f"] = actions.fold_create(),

  -- Delete fold of current scope
  ["F"] = actions.fold_delete(),

  -- Comment out current scope
  ["c"] = actions.comment(),

  -- Goto selected symbol
  ["<enter>"] = actions.select(),
  ["o"] = actions.select(),

  -- Move focused node down
  ["J"] = actions.move_down(),

  -- Move focused node up
  ["K"] = actions.move_up(),

  -- Show preview of current node
  ["s"] = actions.toggle_preview(),

  -- Open selected node in a vertical split
  ["<C-v>"] = actions.vsplit(),

  -- Open selected node in a horizontal split
  ["<C-s>"] = actions.hsplit(),

  -- Fuzzy finder at current level.
  ["t"] = actions.telescope({
    -- All options that can be
    layout_config = {
      -- passed to telescope.nvim's
      height = 0.60,

      -- default can be passed here.
      width = 0.60,

      prompt_position = "top",
      preview_width = 0.50,
    },
    layout_strategy = "horizontal",
  }),

  -- Open mappings help window
  ["g?"] = actions.help(),
}

return mappings
