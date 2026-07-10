# Supported File Formats

```lua
parsers = {
-- Environment Files (`.env`)
  include_commented = true,  -- Include commented-out variables
  env = {
    include_export = true,   -- Include export KEY=value lines
  },
-- JSON
  json = {
    max_depth = 10,  -- Maximum nesting depth to traverse
  },
-- YAML
  yaml = {
    max_depth = 10,  -- Maximum nesting depth
  },
-- XML
  xml = {
    max_depth = 10,  -- Maximum nesting depth
  },
-- HCL / Terraform
  hcl = {
    max_depth = 10,  -- Maximum block nesting depth
  },
}
```
