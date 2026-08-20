local utils = require("ccc.utils")
local mapping = require("ccc").mapping

-- The mappings are set in the UI of ccc.
-- The table where lhs is key and rhs is value.
-- To disable all default mappings, use |ccc-option-disable-default-mappings|.
-- To disable only some of the default mappings, set ccc.mapping.none.
---@type table<string, function>
local mappings = {
  ["<CR>"] = mapping.complete,
  ["q"] = mapping.quit,
  ["l"] = mapping.increase1,
  ["d"] = mapping.increase5,
  [","] = mapping.increase10,
  ["h"] = mapping.decrease1,
  ["s"] = mapping.decrease5,
  ["m"] = mapping.decrease10,
  ["H"] = mapping.set0,
  ["M"] = mapping.set50,
  ["L"] = mapping.set100,
  ["0"] = mapping.set0,
  ["1"] = utils.bind(mapping._set_percent, 10),
  ["2"] = utils.bind(mapping._set_percent, 20),
  ["3"] = utils.bind(mapping._set_percent, 30),
  ["4"] = utils.bind(mapping._set_percent, 40),
  ["5"] = mapping.set50,
  ["6"] = utils.bind(mapping._set_percent, 60),
  ["7"] = utils.bind(mapping._set_percent, 70),
  ["8"] = utils.bind(mapping._set_percent, 80),
  ["9"] = utils.bind(mapping._set_percent, 90),
  ["r"] = mapping.reset_mode,
  ["a"] = mapping.toggle_alpha,
  ["g"] = mapping.toggle_prev_colors,
  ["b"] = mapping.goto_prev,
  ["w"] = mapping.goto_next,
  ["B"] = mapping.goto_head,
  ["W"] = mapping.goto_tail,
  ["i"] = mapping.cycle_input_mode,
  ["o"] = mapping.cycle_output_mode,
  ["<LeftMouse>"] = mapping.click,
  ["<ScrollWheelDown>"] = mapping.decrease1,
  ["<ScrollWheelUp>"] = mapping.increase1,
}

return mappings
