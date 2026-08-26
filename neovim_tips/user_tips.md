# Your personal Neovim tips

# Title: カレントディレクトリからファイルを開く
# Category: this_config
# Tags: file, oil, cmdline, project
---
`:e <Tab>` の補完は cwd 起点。project.nvim が cwd をプロジェクトルート（`.git` などのパターン一致）へ移すので、深い階層のファイルを開いていても補完はルートから始まる。

ルート起点の cwd は grep・picker・LSP root が使うので、そのままにして開き方を変える。

- `-` — oil.nvim。**開いているファイルのディレクトリ**が開く。cwd は関係ない。ディレクトリを選べばそのまま下へ潜れる。既定はこれ
- `:e %:h/<Tab>` — cmdline から。`%` が現在のファイル、`:h` がその親ディレクトリ
- `<leader>Ff` — picker でファイル名から探す（ルート全体が対象）
- `<leader>Fg` — picker で中身から grep
***

# Title: プラグインが張ったキーマップを引く
# Category: this_config
# Tags: keymap, which-key, lazy
---
`:PluginKeys [plugin]` — プラグイン名から、そのプラグインが張ったキーと説明を出す。which-key の逆引き。

未ロードのプラグインも lazy の spec 側から拾うので、まだ動かしていないプラグインのキーも見える。
***
