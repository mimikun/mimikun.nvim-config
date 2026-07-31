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
    -- Match filenames like ".env.development", "env.local" and so on.
    -- The priority is needed to beat Neovim's built-in `.env.*` -> `env` pattern.
    ["%.?env%..*"] = {
      "dotenv",
      {
        priority = 10,
      },
    },
  },
})
