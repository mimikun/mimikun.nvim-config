## Quick Chat with Buffer

Set up a quick chat command that uses the entire buffer content:

```lua
-- Quick chat keybinding
vim.keymap.set('n', '<leader>ccq', function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, {
      resources = {
        'buffer'
      },
    })
  end
end, { desc = "CopilotChat - Quick chat" })
```

## Inline Chat Window

Configure the chat window to appear inline near the cursor:

```lua
require("CopilotChat").setup({
  window = {
    layout = 'float',
    relative = 'cursor',
    width = 1,
    height = 0.4,
    row = 1
  }
})
```

## Markdown Rendering

Use [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) for better chat display:

```lua
-- Register copilot-chat filetype
require('render-markdown').setup({
  file_types = { 'markdown', 'copilot-chat' },
})

-- Adjust chat display settings
require('CopilotChat').setup({
  highlight_headers = false,
  separator = '---',
  error_header = '> [!ERROR] Error',
})
```