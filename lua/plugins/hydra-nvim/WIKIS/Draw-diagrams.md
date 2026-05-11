[venn.nvim](https://github.com/jbyuki/venn.nvim) plugin is needed for this hydra.

#### Drawing extended

![grafik](https://github.com/nvimtools/hydra.nvim/assets/13089667/a62b36a1-70b2-4398-9614-fee15938cb8e)

Includes utf and convenient on-cursor arrow head modifications.

```lua
local venn_hint_utf = [[
 Arrow^^^^^^  Select region with <C-v>^^^^^^
 ^ ^ _K_ ^ ^  _f_: Surround with box ^ ^ ^ ^
 _H_ ^ ^ _L_  _<C-h>_: ◄, _<C-j>_: ▼
 ^ ^ _J_ ^ ^  _<C-k>_: ▲, _<C-l>_: ► _<C-c>_
]]

-- :setlocal ve=all
-- :setlocal ve=none
M.venn_hydra = Hydra {
  name = 'Draw Utf-8 Venn Diagram',
  hint = venn_hint_utf,
  config = {
    color = 'pink',
    invoke_on_body = true,
    on_enter = function() vim.wo.virtualedit = 'all' end,
  },
  mode = 'n',
  body = '<leader>ve',
  heads = {
    { '<C-h>', 'xi<C-v>u25c4<Esc>' }, -- mode = 'v' somehow breaks
    { '<C-j>', 'xi<C-v>u25bc<Esc>' },
    { '<C-k>', 'xi<C-v>u25b2<Esc>' },
    { '<C-l>', 'xi<C-v>u25ba<Esc>' },
    { 'H', '<C-v>h:VBox<CR>' },
    { 'J', '<C-v>j:VBox<CR>' },
    { 'K', '<C-v>k:VBox<CR>' },
    { 'L', '<C-v>l:VBox<CR>' },
    { 'f', ':VBox<CR>', { mode = 'v' } },
    { '<C-c>', nil, { exit = true } },
  },
}
```

#### Drawing ascii

![grafik](https://github.com/nvimtools/hydra.nvim/assets/13089667/2fbe3848-31a7-4a51-bcde-04b8e5a2f11a)

Includes ascii and diagonals, but is missing boxing support.
- simplified ascii art with hydra
- symbols (-,|,^,<,>,/,\\)
- capital letters: -| movements
- C-letters: \<v^\>
- leader clockwise (time running): \\/ including movements
- leader anti-clockwise (enough time): \\/ without movements
- leader hjkl: arrow including rectangular movements
```lua
local venn_hint_ascii   = [[
 -| moves: _H_ _J_ _K_ _L_
 <v^> arrow: _<C-h>_ _<C-j>_ _<C-k>_ _<C-l>_
 diagnoal + move: leader + clockwise like ◄ ▲
 _<leader>jh_ _<leader>hk_ _<leader>lj_ _<leader>kl_
 diagnoal + nomove: anticlockwise like ▲ + ◄
 _<leader>hj_ _<leader>kh_ _<leader>jl_ _<leader>lk_
 set +: _<leader>n_
 rectangle move + arrow, ie ► with ->
 _<leader>h_ _<leader>j_ _<leader>k_ _<leader>l_
                              _<C-c>_
]]
-- _F_: surround^^   _f_: surround     ^^ ^
-- + corners ^  ^^   overwritten corners

M.ascii_hydra = Hydra {
  name = 'Draw Ascii Diagram',
  hint = venn_hint_ascii,
  config = {
    color = 'pink',
    invoke_on_body = true,
    on_enter = function() vim.wo.virtualedit = 'all' end,
  },
  mode = 'n',
  body = '<leader>va',
  heads = {
    { '<C-h>', 'r<' },
    { '<C-j>', 'rv' },
    { '<C-k>', 'r^' },
    { '<C-l>', 'r>' },
    { 'H', 'r-h' },
    { 'J', 'r|j' },
    { 'K', 'r|k' },
    { 'L', 'r-l' },
    { '<leader>jh', 'r/hj' },
    { '<leader>hj', 'r/' },
    { '<leader>hk', 'r\\hk' },
    { '<leader>kh', 'r\\' },
    { '<leader>lj', 'r\\jl' },
    { '<leader>jl', 'r\\' },
    { '<leader>kl', 'r/kl' },
    { '<leader>lk', 'r/' },
    { '<leader>n', 'r+' },
    { '<leader>h', 'r-hr<' },
    { '<leader>j', 'r|jrv' },
    { '<leader>k', 'r|kr^' },
    { '<leader>l', 'r-lr>' },

    { '<C-c>', nil, { exit = true } },
  },
}
```