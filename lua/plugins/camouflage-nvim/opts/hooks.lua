---@type CamouflageHooksConfig | nil
local hooks = {
  ---@type fun(bufnr: number, filename: string): boolean | nil
  on_before_decorate = function(_bufnr, _filename)
    return nil
  end,

  ---@type fun(bufnr: number, var: ParsedVariable): boolean | nil
  on_variable_detected = function(_bufnr, _var)
    return nil
  end,

  ---@type fun(bufnr: number, variables: ParsedVariable[]): nil
  on_after_decorate = function(_bufnr, _variables)
    return nil
  end,
}

hooks = nil

return hooks
