---@type LazyKeysSpec[]
local keys = {
  {
    "<tab>",
    function()
      -- if there is a next edit, jump to it, otherwise apply it if any
      if not require("sidekick").nes_jump_or_apply() then
        -- fallback to normal tab
        return "<Tab>"
      end
    end,
    expr = true,
    desc = "Goto/Apply Next Edit Suggestion",
    { silent = true },
  },
  {
    "<c-.>",
    function()
      require("sidekick.cli").focus()
    end,
    mode = { "n", "t", "i", "x" },
    desc = "Sidekick Focus",
    { silent = true },
  },
  {
    "<leader>aa",
    function()
      require("sidekick.cli").toggle()
    end,
    desc = "Sidekick Toggle CLI",
    { silent = true },
  },
  {
    "<leader>as",
    function()
      require("sidekick.cli").select()
      -- Or to select only installed tools:
      --require("sidekick.cli").select({ filter = { installed = true } })
    end,
    desc = "Select CLI",
    { silent = true },
  },
  {
    "<leader>ad",
    function()
      require("sidekick.cli").close()
    end,
    desc = "Detach a CLI Session",
    { silent = true },
  },
  {
    "<leader>at",
    function()
      require("sidekick.cli").send({ msg = "{this}" })
    end,
    mode = { "x", "n" },
    desc = "Send This",
    { silent = true },
  },
  {
    "<leader>af",
    function()
      require("sidekick.cli").send({ msg = "{file}" })
    end,
    desc = "Send File",
    { silent = true },
  },
  {
    "<leader>av",
    function()
      require("sidekick.cli").send({ msg = "{selection}" })
    end,
    mode = { "x" },
    desc = "Send Visual Selection",
    { silent = true },
  },
  {
    "<leader>ap",
    function()
      require("sidekick.cli").prompt()
    end,
    mode = { "n", "x" },
    desc = "Sidekick Select Prompt",
    { silent = true },
  },
  -- Example of a keybinding to open Claude directly
  {
    "<leader>ac",
    function()
      require("sidekick.cli").toggle({ name = "claude", focus = true })
    end,
    desc = "Sidekick Toggle Claude",
    { silent = true },
  },
}

return keys
