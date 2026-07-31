---@type EcologUserConfig
local opts = {
  -- LSP configuration
  ---@type EcologLspConfig
  lsp = require("plugins.ecolog2-nvim.opts.lsp"),

  -- Picker configuration
  ---@type EcologPickerConfig
  picker = require("plugins.ecolog2-nvim.opts.picker"),

  -- Statusline configuration
  ---@type EcologStatuslineConfig
  statusline = require("plugins.ecolog2-nvim.opts.statusline"),

  --- Additional Options
  -- Enable vim.env sync (default: false)
  ---@type boolean | false
  vim_env = false,

  -- Custom sorting: function(a, b) return a.name < b.name end
  -- Custom variable sort function
  ---@type fun(a: EcologVariable, b: EcologVariable): boolean | nil
  sort_var_fn = function(_a, _b)
    --local function get_source_priority(var)
    --  local source = var.source or ""
    --  if source == "System Environment" then
    --    return 3
    --  elseif source:match("^Remote") then
    --    return 2
    --  else
    --    return 1
    --  end
    --end

    --local a_priority = get_source_priority(a)
    --local b_priority = get_source_priority(b)

    --if a_priority ~= b_priority then
    --  return a_priority < b_priority
    --end

    --return a.name < b.name
    return nil
  end,
}

return opts
