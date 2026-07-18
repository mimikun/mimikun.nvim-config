# 言語別プラグインと mason-lspconfig の衝突

`rustaceanvim` や `nvim-jdtls` のような「自前で LSP クライアントを起動する」
プラグインを入れるとき、mason-lspconfig が同じサーバを起動していないかを
確認するためのメモ。調査時点で検討していた 19 プラグイン分の判定を残す。

## なぜ衝突するのか

この config には `vim.lsp.enable()` / `vim.lsp.config()` の直接呼び出しが
**一箇所も無い**。サーバのアタッチは
`lua/plugins/mason-lspconfig-nvim/opts/automatic_enable.lua` の allowlist に
完全に委譲されている。

ここで重要なのが 2 つのリストの役割の違い。

| ファイル | 役割 | 衝突するか |
| --- | --- | --- |
| `opts/ensure_installed.lua` | mason でバイナリを**導入**する | しない |
| `opts/automatic_enable.lua` | サーバを**起動・アタッチ**する | **する** |

つまり衝突を避けるために `ensure_installed` から消す必要は無い。
むしろ rustaceanvim・haskell-tools・powershell.nvim・nvim-jdtls は
mason が入れたバイナリをそのまま使えるので、**`ensure_installed` は残して
`automatic_enable` からだけ外す**のが正しい。

allowlist の意味論は `automatic_enable.lua` の冒頭コメントのとおりで、
`exclude` キーが無い限り「ここに書いたものだけが起動する」。
同ファイルには既にこう書かれている:

```
-- Uncommenting one usually means commenting out its sibling,
-- otherwise both attach to the same filetype and diagnostics are duplicated.
```

言語別プラグインを入れるというのは、この「sibling」が config の外に
現れるということ。

## 判定一覧

| プラグイン | 担当サーバ | allowlist の現状 | 判定 |
| --- | --- | --- | --- |
| rustaceanvim | rust_analyzer | L34 有効 | **衝突** |
| typescript-tools.nvim | 独自 tsserver | L50 `vtsls` 有効 | **衝突** |
| haskell-tools.nvim | hls | L196 有効 | **衝突** |
| elixir-tools.nvim | elixirls | L114 有効 | **衝突** |
| powershell.nvim | powershell_es | L170 有効 | **衝突** |
| nvim-jdtls | jdtls | L122 有効 | **衝突** |
| go.nvim | gopls | L97 有効 | 条件付き |
| py_lsp.nvim | pyright / basedpyright | L38 `basedpyright` 有効 | 条件付き |
| nvim-html-css | html-css-lsp | — | 前提不足 |
| laravel.nvim | (LSP 無し) | — | 前提不足 |
| flutter-tools.nvim | dartls | 不在 | 衝突なし |
| roslyn.nvim | Roslyn | `omnisharp` コメント済 | 衝突なし |
| nvim-metals | metals | 不在 | 衝突なし |
| kotlin.nvim | kotlin_language_server | 両方コメント済 | 衝突なし |
| rustowl | rustowl (拡張プロトコル) | 不在 | 衝突なし（併存が正） |
| lean.nvim | lake serve | 不在 | 衝突なし |
| ts-error-translator.nvim | (LSP 無し) | — | 衝突なし |
| pymple.nvim | (LSP 無し) | — | 衝突なし |
| cmake-tools.nvim | (LSP 無し) | L128 `neocmake` 有効 | 衝突なし（相性良） |

## 要対応の 6 件

対応は全部同じパターン。`automatic_enable.lua` の該当行を
コメントアウトし、理由を英語コメントで添えるだけ。
`ensure_installed.lua` は触らない。

```lua
-- Before
  "rust_analyzer",

-- After
  --"rust_analyzer", -- managed by rustaceanvim
```

| 行 | 変更後 | 備考 |
| --- | --- | --- |
| L34 | `--"rust_analyzer", -- managed by rustaceanvim` | upstream が lspconfig 併用を明示的に禁止 |
| L50 | `--"vtsls", -- replaced by typescript-tools.nvim` | `eslint` (L51) は役割が別なので残す |
| L196 | `--"hls", -- managed by haskell-tools.nvim` | upstream が lspconfig 併用を明示的に禁止 |
| L114 | `--"elixirls", -- managed by elixir-tools.nvim` | elixir-tools 側の `elixirls` は既定 `true` |
| L170 | `--"powershell_es", -- managed by powershell.nvim` | 下記の `bundle_path` が必要 |
| L122 | `--"jdtls", -- managed by nvim-jdtls` | 下記の autocmd 構成が必要 |

`elp` (L119) は Erlang 用で elixir-tools と無関係なので残す。
`bacon_ls` は既にコメントアウト済みなので rustaceanvim と衝突しない。

### powershell.nvim の追加設定

mason が入れた PowerShellEditorServices の実体を指す必要がある。

```lua
require("powershell").setup({
  bundle_path = vim.fs.joinpath(
    vim.fn.stdpath("data"),
    "mason", "packages", "powershell-editor-services"
  ),
})
```

### nvim-jdtls の追加設定

他プラグインのような `opts` 一発では済まない。プロジェクトごとに
workspace ディレクトリを分ける必要があるため、`ft = "java"` と
自前の `FileType` autocmd で `require("jdtls").start_or_attach()` を
呼ぶ構成になる。

## 条件付きの 2 件

### go.nvim — 既定なら衝突しない

go.nvim は `lsp_cfg` が既定 `false` で、この状態では gopls を
セットアップしない。README も「To use gopls setup provided by go.nvim」
として明示的な opt-in を求めている。

そのまま入れれば `gopls` (L97) はそのままでよい。
`lsp_cfg = true` にしたくなった時だけ L97 をコメントアウトする。
`golangci_lint_ls` (L98) は go.nvim の既定挙動と重ならないので常に残す。

### py_lsp.nvim — 見送り推奨

upstream の README に警告がある。

> WARNING: py_lsp is currently not agnostic against other python lsp
> servers that are starting or attaching.

既定は `language_server = 'pyright'` で、現在 `basedpyright` (L38) が
有効なので二重に attach する。導入するなら `basedpyright` を allowlist
から外して py_lsp 側に一本化することになる。

ただし py_lsp の主目的である venv 自動検出は basedpyright が既に
対応済みで、**得られるものが少ない割に Python の LSP 構成を
作り直す羽目になる**。見送りでよい。

なお `pylsp` と `pyright` は `ensure_installed` では有効だが
`automatic_enable` ではコメントアウト済み（導入だけされていて
起動していない状態）なので、これらとは衝突しない。

## 前提不足の 2 件

衝突はしないが、**今の config に入れても動かない**もの。
ここが一番ハマりやすい。

### nvim-html-css — 補完エンジンが無い

このプラグインは `html-css-lsp` という LSP の形をしているが、
成果物は補完候補としてしか表示されない。ところがこの config には
補完エンジンが 1 つも入っていない。

- `lua/plugins/` に blink.cmp / nvim-cmp のディレクトリ無し
- `lazy-lock.json`（121 個）にも無し
- `lua/plugins/lazydev-nvim/dependencies.lua` で両方コメントアウト
- スニペットエンジンも未設定

紛らわしいが、`blink-pairs` は autopairs、`blink-indent` は
インデントガイドで `enabled = false`、`blink.lib` は blink.pairs の
推移的依存。どれも補完エンジンではない。

→ **先に blink.cmp 等を入れるかどうかを決める。それまで保留。**

### laravel.nvim — PHP LSP がゼロ

laravel.nvim 自体は LSP を起動しないので衝突しない。が、この config に
PHP の言語サーバが一切設定されていない。

- `ensure_installed.lua` L358-360 — `intelephense` / `phpactor` / `psalm`
  すべてコメントアウト
- `ensure_installed.lua` L163 — `laravel_ls` もコメントアウト
- `automatic_enable.lua` に PHP 系は 1 つも無し
- treesitter は `php` パーサ導入済み、`blade` は unstable 扱いで未導入

laravel.nvim は Eloquent のメソッド解決のため `vendor/` に `@method` /
`@property` の doc-block を生成するが、**それを読む intelephense が
居ないと効果が出ない**。

導入するなら以下がセットになる。

1. `intelephense` を `ensure_installed` と `automatic_enable` の両方で有効化
2. treesitter に `blade` パーサを追加
3. 依存プラグイン `nvim-nio` を追加（`nui.nvim` / `plenary.nvim` は導入済み）
4. picker（telescope / fzf-lua / snacks のいずれか）と `ripgrep`

## 衝突しない 9 件

| プラグイン | 注記 |
| --- | --- |
| flutter-tools.nvim | dartls は両リストに不在 |
| roslyn.nvim | `omnisharp` はコメント済、`csharp_ls` は元から無し |
| nvim-metals | metals は両リストに不在。インストールは nvim-metals 自身が扱う |
| kotlin.nvim | `kotlin_language_server` / `kotlin_lsp` とも `ensure_installed` でコメント済。どちらを使うかは kotlin.nvim 側の要求次第 |
| lean.nvim | config 全体で Lean への言及ゼロ（treesitter パーサも無し）。`lean` パーサ追加を検討 |
| rustowl | **下記参照** |
| ts-error-translator.nvim | TS の診断メッセージを読みやすく書き換えるだけ。`vtsls` でも typescript-tools でも動く |
| pymple.nvim | Python ファイル移動時の import 追従。LSP ではない |
| cmake-tools.nvim | ビルド/実行統合。`neocmake` とは役割が別。`cmake` (L129) は既にコメント済 |

### rustowl は 2 クライアント付くのが正常

rustowl は `vim.lsp.start` で自前クライアントを起動し `auto_attach` が
既定 ON。ただしこれは所有権・ライフタイム可視化専用の**拡張プロトコル**で、
汎用の LSP ではない。rust-analyzer と同時に `.rs` へ attach するのが
**設計どおり**であり、rustaceanvim とも共存できる。

つまり後述の確認手順で `.rs` を見るとき、rustowl を入れているなら
期待値は 1 ではなく 2 になる。

### cmake-tools.nvim はむしろ既存構成を改善する

`cmake_soft_link_compile_commands` を有効にすると
`compile_commands.json` がプロジェクトルートに置かれ、
有効になっている `clangd` がヘッダやインクルードパスを正しく
解決できるようになる。

## 導入後の確認手順

各言語のファイルを開いて、attach しているクライアント数を見る。

```vim
:lua =vim.lsp.get_clients({ bufnr = 0 })
```

| 拡張子 | 期待するクライアント |
| --- | --- |
| `.rs` | rust_analyzer のみ（rustowl 導入時は rustowl と合わせて 2 つ） |
| `.ts` | typescript-tools + eslint（`vtsls` が居ないこと） |
| `.hs` | haskell-tools 由来の hls のみ |
| `.ex` | elixir-tools 由来の elixirls のみ |
| `.ps1` | powershell.nvim 由来の 1 つのみ |
| `.java` | nvim-jdtls 由来の jdtls のみ |
| `.go` | gopls + golangci_lint_ls（gopls が二重になっていないこと） |

あわせて `:checkhealth vim.lsp` と `:Mason` も見る。

## mason 管理外のバイナリ

`ensure_installed` に足しても入らないもの。手動または
プラグイン側の仕組みで用意する。

| 対象 | 入手方法 |
| --- | --- |
| rustowl | `build = 'cargo install rustowl'`（lazy.nvim の build フック） |
| Lean | elan / lake ツールチェーンを別途インストール |
| Roslyn | mason registry 経由では入らない。roslyn.nvim の手順を参照 |
| metals | nvim-metals が自前でインストールを扱う |
| pymple.nvim | `gg` と `ripgrep` |
| laravel.nvim | `ripgrep` |
| powershell.nvim | バイナリは mason 導入済み。ただし `bundle_path` の明示が必要 |

## 参照

- `lua/plugins/mason-lspconfig-nvim/opts/automatic_enable.lua` — allowlist
- `lua/plugins/mason-lspconfig-nvim/opts/ensure_installed.lua` — 導入リスト
- `after/lsp/<server>.lua` — サーバ個別の設定上書き
- `scripts/nvim-plugin-clone.sh` — プラグイン追加のスキャフォールド
