local M = {}

local config = {
  active_in_terminals = false,
  auto_enable = false,
  exclude_filetypes = { "help" },
  max_lines = nil,
  max_minimap_height = nil,
  minimap_width = 20,
  use_lsp = true,
  use_treesitter = true,
  use_git = true,
  use_heatmap = false,
  heatmap_encoder_path = nil,
  heatmap_special_tokens = {},
  width_multiplier = 4,
  z_index = 1,
  show_cursor = true,
  screen_bounds = "lines",
  window_border = "single",
  relative = "win",
  show_ruler = true,
  ruler_side = "right",
  ruler_width = 3,
  ruler_gap = 1,
  ruler_interval = nil,
  ruler_tick_interval = nil,
  events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" },
}

function M.get()
  return config
end

function M.setup(new_config)
  if new_config == nil then
    return config
  end
  for k, v in pairs(new_config) do
    config[k] = v
  end
  return config
end

return M
