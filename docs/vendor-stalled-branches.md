# vendoring 停止ブランチの棚卸し

`origin/add/*` のうち、`add-plugin` の vendoring だけ済んで spec が未記入のまま
止まっているブランチを機械的に判定するための資料。判定スクリプトは
`scripts/check-vendor-stalled.sh`。

## 背景

`add-plugin` スキルは既定で **vendor-only** モードで動く。1 プラグインにつき
`add/<dir-name>` ブランチを切り、次を積んで**そこで止まる**。

- 空の marker コミット `feat: add <owner>/<repo>`
- `lua/<tree>/<dir-name>/CODES/`（および wiki があれば `WIKIS/`）— "wip" コミット
- lazy.nvim の spec テンプレート — `TODO: it` マーカーが入ったまま、"wip" コミット

`--fill` を通すと spec が埋まり、wip コミットが 1 つの `feat:` に squash される。
vendoring だけして後回しにしたブランチが積み上がり、**ブランチ名からは
どこまで進んだのか分からない**。2026-08-09 時点で `origin/add/*` は 146 本ある。

## 判定ロジック

`origin/master..<branch>` に対して 2 つの数を取る。

- **todo** — このブランチが追加した `.lua` のうち、`CODES/` と `WIKIS/` 配下を除いて
  `TODO: it` を含むファイル数。**spec が未記入**であることの印
- **wip** — コミット subject がちょうど `wip` のものの数。**squash 前**であることの印

この 2 つで 4 分類する。

| 分類 | 条件 | 意味 | 残作業 |
|---|---|---|---|
| **A** | todo > 0, wip > 0 | vendoring したまま停止 | spec を埋める → 検証 → squash |
| **B** | todo > 0, wip = 0 | 埋める前に squash された | spec を埋める |
| **C** | todo = 0, wip > 0 | spec 済み・squash 前 | 検証 → squash |
| **D** | todo = 0, wip = 0 | 完了形 | なし（マージ待ち） |

vendored な `CODES/`・`WIKIS/` を除外するのが要点。プラグイン本体のソースにも
`TODO` は当たり前に含まれるので、除外しないと全部 A になる。

## 使い方

```bash
task cvs                      # 分類 A を新しい順に一覧（既定）
task cvs -- --class C         # 分類 C だけ
task cvs -- --class all       # 全 146 本
task cvs -- --names           # ブランチ名だけ（パイプ用）
task cvs -- --fetch           # remote refs を更新してから判定
```

出力は 1 行 1 ブランチで、末尾に必ず 4 分類の件数サマリが付く。

```text
2026-08-02  add/catppuccin-nvim                (class=A todo=4 wip=1)
...
A stalled at vendoring : 104
B filled but squashed  : 0
C spec done, no squash : 22
D finished shape       : 20
total                  : 146
```

`--names` は他コマンドへ渡す用。

```bash
task cvs -- --class C --names | while read -r b; do
  git log --oneline "origin/master..origin/$b"
done
```

**exit code は常に 0。** これは lint ではなく棚卸しで、該当ブランチが存在するのは
正常な状態だから。CI のゲートには使わない。

その他のオプションは `scripts/check-vendor-stalled.sh --help`。
`--base` / `--remote` で比較対象を変えられる。

### なぜ一発のシェルコマンドではなくスクリプトなのか

同じ判定を Bash ツール上で直接パイプで書くと、`rtk` フックが `git` の出力を
要約・改変するため、`git diff --name-only` のファイル一覧が壊れる。実際にこれで
**全ブランチが todo=0 という誤った結果**が出た（`Changes:` のような要約行が
ファイル名として混ざった）。`bash <script>` 経由なら git の出力はそのまま渡る。
判定をファイルに固定してあるのはこの理由による。

## スナップショット（2026-08-09 時点）

> **この節は古くなる。** 最新の状態は `task cvs` を実行して得ること。
> ここに残しているのは、後から「いつ時点で何本あったか」を辿るため。

### A: vendoring したまま停止（104 本）

```text
2026-08-02  add/atlas-nvim                     (class=A todo=2 wip=1)
2026-08-02  add/catppuccin-nvim                (class=A todo=4 wip=1)
2026-08-02  add/cyberdream-nvim                (class=A todo=4 wip=1)
2026-08-02  add/dracula-vim                    (class=A todo=4 wip=1)
2026-08-02  add/everforest-nvim                (class=A todo=4 wip=1)
2026-08-02  add/github-nvim-theme              (class=A todo=4 wip=1)
2026-08-02  add/gruvbox-nvim                   (class=A todo=4 wip=1)
2026-08-02  add/kanagawa-nvim                  (class=A todo=4 wip=1)
2026-08-02  add/kanagawa-paper-nvim            (class=A todo=4 wip=1)
2026-08-02  add/monokai-pro-nvim               (class=A todo=4 wip=1)
2026-08-02  add/nightfox-nvim                  (class=A todo=4 wip=1)
2026-08-02  add/nvim-pio                       (class=A todo=4 wip=1)
2026-08-02  add/onedarkpro-nvim                (class=A todo=4 wip=1)
2026-08-02  add/oxocarbon-nvim                 (class=A todo=4 wip=1)
2026-08-02  add/pi2-nvim                       (class=A todo=4 wip=1)
2026-08-02  add/rose-pine-neovim               (class=A todo=1 wip=1)
2026-08-02  add/sonokai                        (class=A todo=4 wip=1)
2026-08-02  add/swapson-nvim                   (class=A todo=4 wip=1)
2026-08-02  add/termfile-nvim                  (class=A todo=4 wip=1)
2026-08-02  add/vague-nvim                     (class=A todo=4 wip=1)
2026-08-02  add/vim-matchup                    (class=A todo=4 wip=1)
2026-08-02  add/visual-multi-nvim              (class=A todo=4 wip=1)
2026-07-26  add/grug-far-nvim                  (class=A todo=2 wip=1)
2026-07-26  add/jujutsu-nvim                   (class=A todo=2 wip=1)
2026-07-26  add/nerdtree                       (class=A todo=3 wip=1)
2026-07-26  add/vim-fern                       (class=A todo=3 wip=1)
2026-07-25  add/nvim-deck                      (class=A todo=4 wip=5)
2026-07-25  add/nvim-insx                      (class=A todo=4 wip=1)
2026-07-24  add/nvim-aibo                      (class=A todo=3 wip=1)
2026-07-24  add/searchbox-nvim                 (class=A todo=3 wip=5)
2026-07-20  add/cmake-tools-nvim               (class=A todo=2 wip=1)
2026-07-20  add/codesettings-nvim              (class=A todo=1 wip=9)
2026-07-20  add/elixir-tools-nvim              (class=A todo=4 wip=5)
2026-07-20  add/flutter-tools-nvim             (class=A todo=4 wip=5)
2026-07-20  add/go-nvim                        (class=A todo=4 wip=9)
2026-07-20  add/haskell-tools-nvim             (class=A todo=4 wip=7)
2026-07-20  add/kotlin-nvim                    (class=A todo=3 wip=8)
2026-07-20  add/laravel-nvim                   (class=A todo=3 wip=4)
2026-07-20  add/lean-nvim                      (class=A todo=4 wip=12)
2026-07-20  add/nvim-java                      (class=A todo=3 wip=9)
2026-07-20  add/nvim-jdtls                     (class=A todo=3 wip=8)
2026-07-20  add/nvim-metals                    (class=A todo=3 wip=10)
2026-07-20  add/pymple-nvim                    (class=A todo=2 wip=8)
2026-07-20  add/roslyn-nvim                    (class=A todo=4 wip=4)
2026-07-20  add/typescript-tools-nvim          (class=A todo=2 wip=1)
2026-07-19  add/powershell-nvim                (class=A todo=1 wip=1)
2026-07-19  add/rustaceanvim                   (class=A todo=3 wip=1)
2026-07-18  add/keeper-nvim                    (class=A todo=4 wip=1)
2026-07-18  add/neojj                          (class=A todo=4 wip=1)
2026-07-18  add/tasks-nvim                     (class=A todo=4 wip=1)
2026-07-17  add/render-markdown-nvim           (class=A todo=9 wip=1)
2026-07-14  add/fzf-lua                        (class=A todo=4 wip=1)
2026-07-14  add/fzf-oil-nvim                   (class=A todo=4 wip=1)
2026-07-14  add/yankdown-nvim                  (class=A todo=4 wip=1)
2026-07-13  add/diffs-nvim                     (class=A todo=4 wip=1)
2026-07-13  add/vim-fugitive                   (class=A todo=4 wip=1)
2026-07-10  add/camouflage-nvim                (class=A todo=2 wip=1)
2026-07-10  add/wind-nvim                      (class=A todo=1 wip=1)
2026-06-30  add/harpoon                        (class=A todo=1 wip=8)
2026-06-30  add/kulala-nvim                    (class=A todo=3 wip=13)
2026-06-30  add/refactoring-nvim               (class=A todo=2 wip=6)
2026-06-29  add/juu-nvim                       (class=A todo=2 wip=5)
2026-06-24  add/jj-nvim                        (class=A todo=2 wip=1)
2026-06-21  add/neominimap-nvim                (class=A todo=4 wip=3)
2026-06-19  add/blink-cmp                      (class=A todo=2 wip=1)
2026-06-19  add/codewindow-nvim                (class=A todo=2 wip=1)
2026-06-19  add/minimap-vim                    (class=A todo=2 wip=1)
2026-06-19  add/mini-nvim                      (class=A todo=4 wip=1)
2026-06-19  add/nvim-autopairs                 (class=A todo=3 wip=1)
2026-06-19  add/nvim-cmp                       (class=A todo=2 wip=1)
2026-05-19  add/neo-tree-nvim                  (class=A todo=1 wip=18)
2026-05-15  add/codedocs-nvim                  (class=A todo=3 wip=1)
2026-05-15  add/hydra-nvim                     (class=A todo=3 wip=7)
2026-05-15  add/neotest                        (class=A todo=2 wip=1)
2026-05-15  add/nvim-neorg                     (class=A todo=3 wip=1)
2026-05-15  add/nvim-orgmode                   (class=A todo=3 wip=3)
2026-05-15  add/nvim-tree-lua                  (class=A todo=1 wip=1)
2026-05-15  add/zk-nvim                        (class=A todo=1 wip=1)
2026-05-14  add/none-ls-nvim                   (class=A todo=1 wip=1)
2026-05-12  add/lspsaga-nvim                   (class=A todo=1 wip=1)
2026-05-12  add/multiple-cursors-nvim          (class=A todo=2 wip=6)
2026-05-11  add/multicursors-nvim              (class=A todo=1 wip=1)
2026-05-05  add/nvim-hlslens                   (class=A todo=4 wip=3)
2026-05-05  add/project-nvim                   (class=A todo=1 wip=2)
2026-05-05  add/vim-quickrun                   (class=A todo=3 wip=3)
2026-05-04  add/helpview-nvim                  (class=A todo=4 wip=6)
2026-05-03  add/diffview-nvim                  (class=A todo=1 wip=1)
2026-05-03  add/nvim-bqf                       (class=A todo=4 wip=2)
2026-05-03  add/nvim-ufo                       (class=A todo=4 wip=2)
2026-05-03  add/toggleterm-nvim                (class=A todo=3 wip=8)
2026-05-02  add/skkeleton                      (class=A todo=3 wip=7)
2026-05-02  add/vim-gin                        (class=A todo=2 wip=1)
2026-05-01  add/markview-nvim                  (class=A todo=4 wip=1)
2026-05-01  add/obsidian-nvim                  (class=A todo=1 wip=8)
2026-05-01  add/vimwiki                        (class=A todo=4 wip=4)
2026-04-28  add/tiny-code-action-nvim          (class=A todo=1 wip=1)
2026-04-27  add/octo-nvim                      (class=A todo=1 wip=1)
2026-04-26  add/dial-nvim                      (class=A todo=2 wip=1)
2026-04-26  add/lexima-vim                     (class=A todo=2 wip=1)
2026-04-26  add/noice-nvim                     (class=A todo=4 wip=1)
2026-04-26  add/nvumi                          (class=A todo=4 wip=1)
2026-04-26  add/overseer-nvim                  (class=A todo=1 wip=1)
2026-04-26  add/snacks-nvim                    (class=A todo=3 wip=1)
2026-04-26  add/telescope-nvim                 (class=A todo=1 wip=1)
```

### C: spec は埋まっているが squash 前（22 本）

```text
2026-08-02  add/pastelnight-nvim               (class=C todo=0 wip=1)
2026-07-26  add/neogit                         (class=C todo=0 wip=16)
2026-07-20  add/nvim-html-css                  (class=C todo=0 wip=18)
2026-07-11  add/skkelua-nvim                   (class=C todo=0 wip=1)
2026-06-21  add/fff-nvim                       (class=C todo=0 wip=1)
2026-05-15  add/ccc-nvim                       (class=C todo=0 wip=23)
2026-05-04  add/dashboard-nvim                 (class=C todo=0 wip=1)
2026-05-04  add/eskk-vim                       (class=C todo=0 wip=1)
2026-05-04  add/hover-nvim                     (class=C todo=0 wip=1)
2026-05-04  add/nvim-dap                       (class=C todo=0 wip=1)
2026-05-04  add/nvim-dap-ui                    (class=C todo=0 wip=1)
2026-05-04  add/nvim-ts-autotag                (class=C todo=0 wip=1)
2026-05-04  add/substitute-nvim                (class=C todo=0 wip=1)
2026-05-04  add/template-nvim                  (class=C todo=0 wip=1)
2026-05-04  add/translate-nvim                 (class=C todo=0 wip=1)
2026-05-04  add/wezterm-nvim                   (class=C todo=0 wip=4)
2026-04-29  add/nvim-surround                  (class=C todo=0 wip=1)
2026-04-26  add/bento-nvim                     (class=C todo=0 wip=1)
2026-04-26  add/line-justice-nvim              (class=C todo=0 wip=1)
2026-04-26  add/pomo-nvim                      (class=C todo=0 wip=1)
2026-04-26  add/sidekick-nvim                  (class=C todo=0 wip=1)
2026-04-26  add/solarized-osaka-nvim           (class=C todo=0 wip=1)
```

### B / D

- **B**: 0 本
- **D**: 20 本 —
  `cellwidths-nvim` `droast-nvim` `ferris-nvim` `hamal-nvim` `homegrown-nvim`
  `mason-tool-installer-nvim` `match-nvim` `matugen-nvim` `neovim-tips`
  `nvim-dora` `nvim-lsp-endhints` `penguin-nvim` `review-nvim` `rustowl`
  `scratch-nvim` `squix-nvim` `stickybuf-nvim` `ts-error-translator-nvim`
  `vim-startuptime` `weborigami-nvim`

## 読み取れること

- **A の 104 本は「1 本ずつ順に消す」対象にすると終わらない。** 生成された塊が
  そのまま意味の塊になっているので、塊で扱うほうが刻める。
  - 2026-08-02 の 22 本 — ほぼ全部カラースキーム
  - 2026-07-20 の 15 本 — 言語ごとの LSP / ツール（`nvim-java`、`nvim-metals`、
    `haskell-tools-nvim`、`elixir-tools-nvim` など）
  - それ以外は単発
- **C の 22 本が一番手離れが近い。** spec は書けているので、読み込み検証と squash
  だけで D になる。
- **B が 0 本**なのは、`--fill` が「埋める」と「squash する」を必ずセットで
  やっているため。B が出てきたら手作業で squash した跡ということになる。
