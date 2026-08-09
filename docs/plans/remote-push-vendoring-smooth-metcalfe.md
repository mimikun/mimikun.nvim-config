# カラースキーム15本の spec を仕上げてマージする（実装者: Codex）

## Context

`~/.config/nvim` は `add-plugin` スキルで新規プラグインを **vendor-only** モードで
取り込んでいる。プラグイン本体を `CODES/` に vendoring し、lazy.nvim の spec
テンプレートを `TODO: it` マーカー入りのまま置いて止まる、という運用。

その結果 `origin/add/*` が 144 本たまった。分類スクリプト
`scripts/check-vendor-stalled.sh`（`task cvs`）で棚卸ししたところ、
**A（vendoring したまま停止）が 104 本**あり、そのうち **`lua/colorschemes/` を
対象とするものが 15 本**ある。背景と分類の定義は `docs/vendor-stalled-branches.md`。

本人の意向は「**テーマ切り替え用プラグインを別途入れて管理するので、基本は全部入れる**」。
よってこの 15 本すべてについて spec を仕上げ、1 本ずつ PR を出してマージする。

**目的地**: `lua/colorschemes/` に 15 ディレクトリが増え、いずれも
`vim.cmd.colorscheme(...)` で切り替えられる状態になること。

---

## 前提として確定している事実（調査済み。再調査不要）

### 1. lazy.nvim はカラースキームを自動ロードする

`~/.local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:29` に
`ColorSchemePre` の autocmd があり、`M.colorscheme(name)`（同 515 行）が
**未ロードのプラグインの `colors/<name>.{lua,vim}` を探して load する**。

したがって:

- **15 本とも `lazy` は既定（`true`）でよい。** `event` や `priority` は不要
- `event = "VeryLazy"` を残すと起動時に読まれてしまうので**外す**
- **`cond = false` / `enabled = false` は必ず外す。** 残っているとインストールすら
  されず、切り替えプラグインから見えない
- `lazy = false` + `priority = 1000` が要るのは「起動時に当たっているテーマ」だけ。
  現状それは `tokyonight-nvim` で、**この 15 本では誰も `lazy = false` にしない**

### 2. 完成形は spec の `.lua` だけ（vendoring 物は消す）

`origin/master` には `CODES/` を含むパスが **0 件**。マージ済みの実例:

```text
lua/colorschemes/tokyonight-nvim/   init.lua opts.lua
lua/plugins/penguin-nvim/           cmds.lua events.lua init.lua keys.lua opts.lua
```

つまり fill の工程で次を**削除する**。

- `CODES/`、`WIKIS/`（および `WIKIS.*.md` のような取り込み残骸）
- テンプレート由来の `stylua.toml`、`.editorconfig`
- vendoring で紛れ込んだ `README.md` / `INSTALL.md` / `*.txt` / `*.md`
- **使わなかった spec ファイル**（`cmds.lua` / `keys.lua` / `ft.lua` /
  `dependencies.lua` / `events.lua` / 空の `config.lua`）。
  カラースキームなら通常 `init.lua` と `opts.lua` の 2 つだけが残る

### 3. opts.lua のハウススタイル

基準は `lua/colorschemes/tokyonight-nvim/opts.lua`。

- 先頭に `---@type <PluginConfigType>` の注釈（型名が upstream にあればそれを使う）
- **upstream の README / doc のコメントごと写し、値は意図を持って決める**
- 透過は `lua/plugins/transparent-nvim` と連動させる。tokyonight は
  `transparent = vim.g.transparent_enabled` としている。**同等のキーがあるテーマは
  同じ書き方に揃える**（rose-pine なら `styles.transparency`）
- **デッドコードを残さない。** `local readme = { ... }` のような使われない
  ローカル変数、全行コメントアウトされた空関数は消す
- **キーの重複禁止**（Lua は後勝ちで黙って通る）

### 4. 検証は headless ではなく `neowright`

`CLAUDE.md` の規定。「読み込めるか」までは headless でよいが、
**カラースキームは描画なので `neowright` スキルを使う**。過去に headless で
偽の失敗を踏んで切り分けに 3 往復使っている。

### 5. force push は禁止 → **既存の `add/*` ブランチを書き換えない**

`add/*` は marker commit + `wip` の履歴を持つ。これを squash すると force push が
必要になり、`rules/general.md` で禁止されている。したがって:

**`origin/master` から新しいブランチを切り、1 コミットだけ載せる。**
既存の `add/<name>` は読み取り元として使うだけで、触らない。

---

## 各ブランチの手順（1 本ずつ、この順で繰り返す）

`<name>` = ディレクトリ名（例 `gruvbox-nvim`）、`<slug>` = `owner/repo`（例 `ellisonleao/gruvbox.nvim`）。

### 手順 1. worktree を切る（**素の `git worktree add` を使わないこと**）

**既存の作業ディレクトリでは作業しない**（`rules/general.md`。並行セッションと
衝突する）。ただし **素の `git worktree add` では検証できない。**
Neovim を起動して確認する必要があるので、**このリポジトリ専用の
`scripts/nvim-worktree.sh` を使う**（`nvim-worktree` スキルと同じもの）。

```bash
cd ~/.config/nvim
git fetch --prune origin
git branch feat/colorscheme-<name> origin/master          # ブランチだけ先に作る
scripts/nvim-worktree.sh add feat/colorscheme-<name> cs-<name>
cd ~/.config/nvim-cs-<name>
```

これで次がまとめて用意される。**素の `git worktree add` にはどれも無い。**

- worktree の位置が `~/.config/nvim-cs-<name>` — `NVIM_APPNAME` の規約に合う場所
- `lazy/`（プラグイン）と `site/`（treesitter parser）は**実コピー**なので
  ブランチごとに構成が分岐できる
- `mason/` `lazy-rocks/` `databases/` などは本体へ symlink 共有。再ダウンロードしない
- cache ディレクトリ全体が本体への symlink
- `.envrc` が生成され `direnv allow` 済み。**`cd` するだけで
  `NVIM_APPNAME=nvim-cs-<name>` が有効になる**

**`--detach` で `../nvim-cs-<name>` に切ると失敗する。** そのディレクトリは
Neovim から見て設定ディレクトリではないので、`:Lazy` が登録されず、データ・swap・
セッションの保存先も無いまま起動して `EROFS` になる。2026-08-09 に実際に踏んだ。

### 手順 2. vendoring 済みのディレクトリを取り込む

```bash
git checkout origin/add/<name> -- lua/colorschemes/<name>
```

`rose-pine-neovim` だけ `CODES/` が無い（下の表を参照）。その場合は upstream を
浅くクローンして調査材料にする。**クローン先はリポジトリ外の一時ディレクトリ**に
すること。

### 手順 3. spec を書く

調査元は `lua/colorschemes/<name>/CODES/README.md`、`CODES/doc/*.txt`、`WIKIS/`。
埋めるのは次の 2 ファイルだけ。

**`init.lua`** — テンプレートのコメントアウト行のうち、使わないものは**行ごと削除**する
（コメントのまま残さない）。カラースキームの標準形:

```lua
---@type LazySpec
local spec = {
  "<slug>",
  name = "<lazy.nvim 上の名前。require するモジュール名と揃える>",
  config = function()
    local opts = require("colorschemes.<name>.opts")
    require("<module>").setup(opts)
  end,
}

return spec
```

- `setup()` が不要なテーマ（Vim script 実装など）は `config` ごと落とし、
  `init = function() vim.g.<name>_* = ... end` の形にする
- `opts = require(...)` 形式でも可（tokyonight はこちら）。**どちらか一方にする**
- **`vim.cmd.colorscheme(...)` を spec の中で呼ばない。** 切り替えは別プラグインが持つ

**`opts.lua`** — 上の「ハウススタイル」に従う。

### 手順 4. 不要ファイルを消す

```bash
cd lua/colorschemes/<name>
rm -rf CODES WIKIS
rm -f stylua.toml .editorconfig *.md *.txt
# 使わなかった spec ファイルも消す
rm -f cmds.lua keys.lua ft.lua dependencies.lua events.lua config.lua
git status --short   # init.lua と opts.lua だけが残ることを確認
```

### 手順 5. 検証

```bash
# 静的チェック
selene lua/colorschemes/<name>          # 0 error / 0 warning
stylua --check lua/colorschemes/<name>
task check-keys                          # keys.lua を残した場合のみ意味があるが、必ず通す
```

次に、まず headless で**プラグインを取得して spec が壊れていないこと**を確認する。
ここまでは headless で構わない（`CLAUDE.md`「読み込めるか = headless」）。

```bash
cd ~/.config/nvim-cs-<name>     # direnv により NVIM_APPNAME が有効
nvim --headless "+Lazy! install" +qa
nvim --headless "+lua local ok, err = pcall(vim.cmd.colorscheme, '<variant>')
  print('ok=' .. tostring(ok)); if not ok then print(err) end
  print('colors_name=' .. tostring(vim.g.colors_name))
  local p = require('lazy.core.config').plugins['<lazy 上の名前>']
  print('lazy=' .. tostring(p and p.lazy))
  print('loaded=' .. tostring(p and p._.loaded ~= nil))
  print('Normal_bg=' .. tostring(vim.api.nvim_get_hl(0, { name = 'Normal' }).bg))" +qa
```

- `ok=true` / `colors_name=<variant>` — 適用できている
- **`lazy=true` かつ `loaded=true`** — 「前提 1」の自動ロードが効いている。
  ここが `lazy=false` なら spec の設計ミス
- `Normal_bg` が既定から変わっている — 配色が実際に当たっている

そのうえで **`neowright` スキル**で実機の描画を確認する。**ここを飛ばさない。**
headless の highlight 値は「値が設定された」ことしか言えず、**実際に描かれたか**は
別の話。過去に headless で偽の失敗を踏んで切り分けに 3 往復使っている。

1. `NVIM_APPNAME=nvim-cs-<name>` で Neovim を起動する
2. `colors/` にあるバリアントを**全部** `:colorscheme` で試す
3. エラーが出ないことと、配色が変わることをスクリーンショットで確認する

### 手順 6. コミットと PR

コミットは **1 本 = 1 コミット**。メッセージは master の既存形式に合わせる
（`git log --oneline origin/master` を見ること）。

```bash
git add lua/colorschemes/<name>
git commit -m "feat: add <slug>"
git push origin HEAD:refs/heads/feat/colorscheme-<name>
gh pr create --base master --head feat/colorscheme-<name> \
  --title "feat: add <slug>" --body "<問題と解決策。ツールへの言及は入れない>"
```

- **detached HEAD から新規ブランチを push するときは ref を完全修飾する**
  （`HEAD:refs/heads/<name>`。短い `HEAD:<name>` は既存ブランチにしか当たらない）
- push 先は **GitHub（`origin`）のみ**。Codeberg へは push しない
- PR 本文に co-authored-by やツール名を書かない
- **マージは本人が行う。** Codex は PR を出すところまで

### 手順 7. 後片付け

```bash
cd ~/.config/nvim
scripts/nvim-worktree.sh remove cs-<name>
```

**素の `git worktree remove` を使わないこと。** データ・state・cache の
専用ディレクトリが残る。上のコマンドはそこまで消す
（ただしブランチは消さない。これは意図的な仕様）。

マージ後に `git cherry origin/master feat/colorscheme-<name>` で `-` が付いていない
ことを確認する（`-` は master に同等パッチが既にある印で、rebase merge が空コミットで
落ちる）。**`mergeable: MERGEABLE` は当てにしない。**

---

## 対象 15 本と個別の注意

`origin/add/<ブランチ>` が読み取り元。全部 2026-08-02 の vendoring。

| # | ブランチ | slug | CODES | 注意 |
|---|---|---|---|---|
| 1 | `gruvbox-nvim` | `ellisonleao/gruvbox.nvim` | 17 | **最初にこれをやる。** 典型形で source が小さい。ここで確定した形を残り14本に流す |
| 2 | `oxocarbon-nvim` | `nyoom-engineering/oxocarbon.nvim` | 11 | 設定項目がほぼ無い。`opts.lua` が空に近くなるなら **`opts.lua` ごと落として `init.lua` だけ**にしてよい |
| 3 | `vague-nvim` | `vague-theme/vague.nvim` | 31 | 設定項目少なめ |
| 4 | `everforest-nvim` | `neanias/everforest-nvim` | 17 | `WIKIS` あり。`background` = hard/medium/soft |
| 5 | `sonokai` | `sainnhe/sonokai` | 14 | **Vim script 実装。`setup()` が無い。** `vim.g.sonokai_*` を `init` で設定する形になる。`opts.lua` は使わない可能性が高い |
| 6 | `dracula-vim` | `dracula/vim` | 6 | **Vim script 実装。** 同上。`name` の指定に注意（`colors/dracula.vim`）。ディレクトリ直下に `INSTALL.md` `README.md` `dracula.txt` が紛れているので消す |
| 7 | `kanagawa-nvim` | `rebelot/kanagawa.nvim` | 96 | wave/dragon/lotus の3テーマ |
| 8 | `monokai-pro-nvim` | `loctvl842/monokai-pro.nvim` | 80 | filter が6種 |
| 9 | `catppuccin-nvim` | `catppuccin/nvim` | 119 | **`opts.lua` に README の設定が 74 行貼り付け済み。**`local readme = {...}` のデッドコードとして入っているので、必要な値を本体へ移して readme 変数は消す。`name = "catppuccin"` |
| 10 | `github-nvim-theme` | `projekt0n/github-nvim-theme` | 143 | バリアントが多い |
| 11 | `kanagawa-paper-nvim` | `thesimonho/kanagawa-paper.nvim` | 151 | `WIKIS` あり。#7 と配色系統が重なるが、本人は「全部入れる」方針なので両方入れる |
| 12 | `cyberdream-nvim` | `scottmckendry/cyberdream.nvim` | 190 | dark/light トグルのコマンドを持つ。`cmds.lua` を残す判断があり得る |
| 13 | `nightfox-nvim` | `EdenEast/nightfox.nvim` | 252 | `WIKIS` あり。7バリアントを1 spec で抱える |
| 14 | `onedarkpro-nvim` | `olimorris/onedarkpro.nvim` | 255 | 設定項目が多く `opts.lua` が重くなる |
| 15 | `rose-pine-neovim` | `rose-pine/neovim` | **0** | **他と形が違う。下の節を読むこと** |

### `rose-pine-neovim` の個別事情

このブランチだけ古い形式で、**`CODES/` が無い**。加えて既に手が入っているが、
そのまま使える状態ではない。修正が要る点:

- **`opts.lua` で `extend_background_behind_borders` が 2 回定義されている**
  （Lua は後勝ちで黙って通る）。1 つに統合する
- **`local readme = { ... }` が未使用のまま残っている。** selene が拾う。消す
- `highlight_groups` の `Comment = { fg = "foam" }` と
  `StatusLine = { fg = "love", bg = "love", blend = 15 }` は upstream README の
  **デモ例をそのまま写したもの**で、意図した設定ではない。採用するか消すか判断する
- `groups.ok = "leaf"` / `h6 = "leaf"` の `leaf` が現行 upstream のパレットに
  存在するか**確認する**（`CODES/` が無いので upstream を一時クローンして
  `lua/rose-pine/palette.lua` を見る）
- `config.lua` が 0 バイトで存在する。消す
- `WIKIS.Recipes.md` と `rose-pine-neovim.md` が直下にある。消す
- `events.lua`（`VeryLazy`）と `init.lua` の `event = ...` を外す
  — 「前提 1」により不要
- `variant = "auto"` / `dark_variant = "main"` は残してよい。`styles.transparency`
  を `vim.g.transparent_enabled` に揃える

---

## 進め方（刻み）

**1 本ずつ、PR を出すところまでやって止める。** 15 本を一括で進めない。

1. **#1 `gruvbox-nvim` を手順 1〜7 まで通して PR を出す。ここでいったん報告する。**
   本人が spec の形を確認し、必要なら直す。**形が確定するまで 2 本目に進まない**
2. 形が承認されたら #2〜#8 を同じ形で進める（1 本ずつ PR）
3. #9 `catppuccin-nvim` と #15 `rose-pine-neovim` は既に手が入っているので、
   既存の記述を活かしつつ上の指摘を潰す
4. 残り（#10〜#14）は設定項目が多いので最後

**中断してよい。** 途中で止まってもブランチと PR は残るので、次に着手した時点で
継続として扱う。遅れを取り返そうとして 1 歩を大きくしないこと。

## やらないこと

- **既存の `origin/add/*` ブランチを書き換えない・消さない**（force push 禁止）
- `master` へ直接 push しない
- **PR のマージをしない。** マージは本人が行う
- カラースキームを `lazy = false` にしない、`priority` を付けない
  （「前提 1」の設計が崩れる）
- spec の中で `vim.cmd.colorscheme(...)` を呼ばない
- **テーマ切り替えプラグインを勝手に選んで導入しない。** 未定。この 15 本とは別件
- `docs/vendor-stalled-branches.md` のスナップショット節を更新しない
  （日付付きの記録なので、古くなるのは想定内）
- 同日に vendoring された非カラースキーム 7 本
  （`vim-matchup` `visual-multi-nvim` `atlas-nvim` `nvim-pio` `pi2-nvim`
  `swapson-nvim` `termfile-nvim`）には触らない

## 完了条件

15 本それぞれについて、次がすべて満たされたとき完了。

1. `lua/colorschemes/<name>/` に `init.lua`（と必要なら `opts.lua`）だけが存在し、
   `CODES/`・`WIKIS/`・テンプレート由来の設定ファイル・vendoring 残骸が無い
2. `selene` と `stylua --check` が通る
3. `neowright` で全バリアントの `:colorscheme` が **エラーなく配色を変える**
4. `lazy = true` のまま自動ロードされる
5. `feat/colorscheme-<name>` が origin に push され、PR が開いている

**全体の完了判定**: `task cvs -- --names` の出力に
`lua/colorschemes` 対象のブランチが残っていないこと。
（判定コマンド: `docs/vendor-stalled-branches.md` の「使い方」節を参照）
