vim.filetype.add({
  -- Mappings based on file extension
  extension = {
    env = "dotenv",
  },
  -- Mappings based on FULL filename
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  -- Mappings based on filename pattern match
  pattern = {
    -- Match filenames like ".env.development", "env.local" and so on
    [".?env.*"] = "dotenv",
  },
})
