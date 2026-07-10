---@type CamouflagePatternConfig[]
local patterns = {
  {
    file_pattern = {
      ".env*",
      "*.env",
      ".envrc",
    },
    parser = "env",
  },
  {
    file_pattern = {
      "*.sh",
    },
    parser = "env",
  },
  {
    file_pattern = {
      "*.json",
    },
    parser = "json",
  },
  {
    file_pattern = {
      "*.yaml",
      "*.yml",
    },
    parser = "yaml",
  },
  {
    file_pattern = {
      "*.toml",
    },
    parser = "toml",
  },
  {
    file_pattern = {
      "*.properties",
      "*.ini",
      "*.conf",
      "credentials",
    },
    parser = "properties",
  },
  {
    file_pattern = {
      ".netrc",
      "_netrc",
    },
    parser = "netrc",
  },
  {
    file_pattern = {
      "*.xml",
    },
    parser = "xml",
  },
  {
    file_pattern = {
      "*.http",
    },
    parser = "http",
  },
  {
    file_pattern = {
      "*.tf",
      "*.tfvars",
      "*.hcl",
    },
    parser = "hcl",
  },
  {
    file_pattern = {
      "Dockerfile",
      "Dockerfile.*",
      "*.dockerfile",
      "Containerfile",
      "Containerfile.*",
    },
    parser = "dockerfile",
  },
}

return patterns
