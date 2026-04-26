# Integrations

## delphinus/md-render.nvim

### nvim-telescope/telescope.nvim

#### Previewer

`require("md-render.telescope").previewer()` で作成した previewer は、任意の
[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) picker
（builtin、extension、カスタム問わず）に渡せます：

```lua
local previewer = require("md-render.telescope").previewer()

require("telescope.builtin").find_files({ previewer = previewer })
require("telescope").extensions.egrepify.egrepify({ previewer = previewer })
```

ファイルの種類に応じて自動的に表示方法を切り替えます：

| ファイル種別 | 動作 |
|---|---|
| Markdown (`.md`, `.markdown`) | md-render によるフルレンダリング（ハイライト、リンク、画像） |
| 画像・動画 (PNG, JPEG, WebP, GIF, MP4, ...) | Kitty graphics protocol でインライン表示 |
| その他 | telescope のデフォルト previewer（シンタックスハイライト付き）にフォールバック |

grep 系の picker では、マッチした行に自動スクロールします。

#### `:Telescope md_render` Extension

builtin picker 用のショートカットです。`telescope.builtin` の picker を md-render
previewer 付きでラップします。引数はすべてそのまま渡されます：

```vim
:Telescope md_render find_files
:Telescope md_render live_grep cwd=~/notes
:Telescope md_render grep_string search=TODO
```

### folke/snacks.nvim

`require("md-render.snacks").preview()` で
[snacks.nvim](https://github.com/folke/snacks.nvim) の picker 用プレビュー関数を
作成します。telescope 版と同じく Markdown、画像・動画、その他のファイルに対応します。

グローバルに全 picker へ適用：

```lua
require("snacks").setup({
  picker = {
    preview = require("md-render.snacks").preview(),
  },
})
```

source ごとに個別設定：

```lua
require("snacks").setup({
  picker = {
    sources = {
      files = { preview = require("md-render.snacks").preview() },
      grep = { preview = require("md-render.snacks").preview() },
    },
  },
})
```

