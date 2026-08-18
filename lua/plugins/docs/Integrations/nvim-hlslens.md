# nvim-hlslens

## Integrate with other plugins

### [vim-asterisk](https://github.com/haya14busa/vim-asterisk)

```lua
-- packer
use 'haya14busa/vim-asterisk'

vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
```

#### [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)

The lens has been adapted to the folds of nvim-ufo, still need remap `n` and `N` action if you want
to peek at folded lines.

```lua
-- packer
use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

-- if Neovim is 0.8.0 before, remap yourself.
local function nN(char)
    local ok, winid = hlslens.nNPeekWithUFO(char)
    if ok and winid then
        -- Safe to override buffer scope keymaps remapped by ufo,
        -- ufo will restore previous buffer keymaps before closing preview window
        -- Type <CR> will switch to preview window and fire `trace` action
        vim.keymap.set('n', '<CR>', function()
            return '<Tab><CR>'
        end, {buffer = true, remap = true, expr = true})
    end
end

vim.keymap.set({'n', 'x'}, 'n', function() nN('n') end)
vim.keymap.set({'n', 'x'}, 'N', function() nN('N') end)
```

#### [vim-visual-multi](https://github.com/mg979/vim-visual-multi)

<https://user-images.githubusercontent.com/17562139/144655345-9185df0e-e27e-4877-9ee6-d0acb811c907.mp4>

```lua
-- packer
use 'mg979/vim-visual-multi'

local hlslens = require('hlslens')
if hlslens then
    local overrideLens = function(render, posList, nearest, idx, relIdx)
        local _ = relIdx
        local lnum, col = unpack(posList[idx])

        local text, chunks
        if nearest then
            text = ('[%d/%d]'):format(idx, #posList)
            chunks = {{' ', 'Ignore'}, {text, 'VM_Extend'}}
        else
            text = ('[%d]'):format(idx)
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end
    local lensBak
    local config = require('hlslens.config')
    local gid = vim.api.nvim_create_augroup('VMlens', {})
    vim.api.nvim_create_autocmd('User', {
        pattern = {'visual_multi_start', 'visual_multi_exit'},
        group = gid,
        callback = function(ev)
            if ev.match == 'visual_multi_start' then
                lensBak = config.override_lens
                config.override_lens = overrideLens
            else
                config.override_lens = lensBak
            end
            hlslens.start()
        end
    })
end
```
