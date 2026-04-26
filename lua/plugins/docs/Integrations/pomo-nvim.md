# Integrations

## epwalsh/pomo.nvim

### rcarriga/nvim-notify

The "Default" notifier integrates seamlessly with `nvim-notify`, you just need to have `nvim-notify` installed.

### nvim-lualine/lualine.nvim

**pomo.nvim** can easily be added to a section in your `lualine`. For example, this would extend the defaults for section X to include the next timer to finish (min time remaining):

```lua
require("lualine").setup {
  sections = {
    lualine_x = {
      function()
        local ok, pomo = pcall(require, "pomo")
        if not ok then
          return ""
        end

        local timer = pomo.get_first_to_finish()
        if timer == nil then
          return ""
        end

        return "󰄉 " .. tostring(timer)
      end,
      "encoding",
      "fileformat",
      "filetype",
    },
  },
}
```

### nvim-telescope/telescope.nvim

Pomo.nvim ships with a telescope extension for managing timers. Here's an example of mapping the keys `<leader>pt` to open the telescope picker for timers.

```lua
require("telescope").load_extension "pomodori"

vim.keymap.set("n", "<leader>pt", function()
  require("telescope").extensions.pomodori.timers()
end, { desc = "Manage Pomodori Timers"})
```

