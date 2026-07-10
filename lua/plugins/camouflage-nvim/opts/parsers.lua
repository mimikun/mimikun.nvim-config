---@type CamouflageParsersConfig
local parsers = {
  -- Include commented-out variables
  ---@type boolean
  include_commented = true,

  -- Environment Files (`.env`)
  ---@type CamouflageEnvParserConfig
  env = {
    -- Include commented-out variables
    ---@type boolean
    include_commented = true,

    -- Include export KEY=value lines
    ---@type boolean
    include_export = true,
  },

  -- JSON
  ---@type CamouflageJsonParserConfig
  json = {
    -- Maximum nesting depth to traverse
    ---@type number
    max_depth = 10,
  },

  -- YAML
  ---@type CamouflageYamlParserConfig
  yaml = {
    -- Maximum nesting depth
    ---@type number
    max_depth = 10,
  },

  -- XML
  ---@type CamouflageXmlParserConfig
  xml = {
    -- Maximum nesting depth for XML elements
    ---@type number
    max_depth = 10,
  },

  -- HCL / Terraform
  ---@type CamouflageHclParserConfig
  hcl = {
    -- Maximum block nesting depth
    ---@type number
    max_depth = 10,
  },

  dockerfile = {
    --it
  },
}

return parsers
