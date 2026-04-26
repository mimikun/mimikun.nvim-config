Some examples of telescope configuration

## Padded dropdown menu in Norcalli's blue
![](https://user-images.githubusercontent.com/125701/95586779-6f379e00-0a41-11eb-8d36-88e10c431836.png)
```
local dropdown_theme = require('telescope.themes').get_dropdown({
  results_height = 20;
  winblend = 20;
  width = 0.8;
  prompt_title = '';
  prompt_prefix = 'Files>';
  previewer = false;
  borderchars = {
    prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
    results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' };
    preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
  };
})
```

## Padded full menu in Norcalli's blue
![](https://user-images.githubusercontent.com/125701/95586787-72328e80-0a41-11eb-86e3-ec4ba66866f5.png)
```
local full_theme = {
  winblend = 20;
  width = 0.8;
  show_line = false;
  prompt_prefix = 'TS Symbols>';
  prompt_title = '';
  results_title = '';
  preview_title = '';
  borderchars = {
    prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
    results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
    preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
  };
}
```

## Minimalist square box
![](https://i.imgur.com/def3MZo.png)
```lua
local no_preview = function()
  return require('telescope.themes').get_dropdown({
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    },
    width = 0.8,
    previewer = false,
    prompt_title = false
  })
end

-- then use it on whatever picker you want
-- ex:
require"telescope.builtin".current_buffer_fuzzy_find(no_preview())
```

## Borderless

![图片](https://user-images.githubusercontent.com/42114817/179353034-d105dedf-774a-4b37-8ac9-28bf42a69ffc.png)

```lua
local TelescopePrompt = {
    TelescopePromptNormal = {
        bg = '#2d3149',
    },
    TelescopePromptBorder = {
        bg = '#2d3149',
    },
    TelescopePromptTitle = {
        fg = '#2d3149',
        bg = '#2d3149',
    },
    TelescopePreviewTitle = {
        fg = '#1F2335',
        bg = '#1F2335',
    },
    TelescopeResultsTitle = {
        fg = '#1F2335',
        bg = '#1F2335',
    },
}
for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
end
```

