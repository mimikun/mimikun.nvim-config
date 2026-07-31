-- Module toggles (see Modules section for details)
---@type ShelterModulesConfig
local modules = {
  -- Buffer masking (boolean or detailed config)
  -- Detailed configuration for the files module (buffer masking)
  ---@type boolean | ShelterFilesModuleConfig
  files = {
    -- Re-mask when leaving buffer (default: true)
    -- Re-shelter when leaving buffer (default: true)
    ---@type boolean
    shelter_on_leave = true,

    -- Disable completion in .env files (default: true)
    -- Disable nvim-cmp/blink-cmp in sheltered buffers (default: true)
    ---@type boolean
    disable_cmp = true,
  },

  -- With picker integration (Telescope, FZF, Snacks)
  -- Telescope preview masking
  ---@type boolean
  telescope_previewer = true,

  -- FZF preview masking
  ---@type boolean
  fzf_previewer = false,

  -- Snacks preview masking
  ---@type boolean
  snacks_previewer = false,

  -- Oil.nvim preview masking
  ---@type boolean
  oil_previewer = false,

  -- With ecolog-v1.nvim integration
  -- Mask LSP completions and hover
  -- Or with fine-grained control:
  -- Ecolog integration (boolean or detailed config)
  -- Detailed configuration for the ecolog integration module
  ---@type boolean | ShelterEcologModuleConfig
  ecolog = {
    -- Mask completion item values (default: true)
    cmp = true,

    -- Mask hover/peek content (default: true)
    peek = true,

    -- Mask variable picker entries (default: true)
    picker = true,
  },
}

return modules
