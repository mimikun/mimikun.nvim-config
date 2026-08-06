# nvim-dap の mason 連携

nvim-dap は将来入れる予定。そのとき mason 側の DAP アダプタも入れたいので、
橋渡しプラグインを先に調べた。**このファイルは調査した事実ではなく、判断の理由を
残すためにある。** 事実は再検証コマンドで取り直せるが、なぜその選択をしたかは
どこにも自動生成されない。

調査日: 2026-08-07（mason.nvim 2.3.1 / registry 587パッケージ時点）

## 結論

`jay-babu/mason-nvim-dap.nvim` は存在するが、**採らない。**

`mason-conform.nvim` / `mason-nvim-lint.nvim` と同じ設計で
`mimikun/mason-nvim-dap.nvim` を書く。ただし**スコープは install 半分だけ**で、
`dap.configurations` の生成はやらない（理由は後述）。

## jay-babu 版を採らない理由

| 項目 | jay-babu 版 | 自作2つの設計 |
| --- | --- | --- |
| 名前解決 | 手書きテーブル 19件（`lua/mason-nvim-dap/mappings/source.lua`） | registry の `bin` + `categories` から導出 |
| registry の DAP パッケージ | 32件（13件が未対応） | 漏れという概念がない |
| 依存する mason API | `mason-core.log` / `.functional` / `.optional` / `.notify` = 内部 API | `mason-registry` のみ（公開 API） |
| 最終 push | 2025-10-20（調査時点で約9.5ヶ月前） | 自分で持っている |
| License | AGPL-3.0 | Apache-2.0（mason-lspconfig 由来） |

`mason-nvim-lint.nvim` の README に自分で書いた

> The existing bridges all keep a hand-written linter-to-package table in the
> plugin. That table is what rots: it goes stale whenever the mason registry
> renames or adds a package, and the failure is silent.

が、そのまま該当する。jay-babu 側の README も
"Not all debuggers available by Mason are included in this extension" と明記している。

**今すぐ壊れるわけではない。** mason 2.3.1 には `mason-core.*` が全部存在するので、
入れれば動く。問題は、内部 API に依存した停止中のリポジトリが、mason 側の変更で
**黙って**壊れうること。lint / conform で2回同じ判断をしているので、3回目もそろえる。

## DAP は lint / conform より難しい

同じ設計をそのまま移植できない箇所が3つある。自作に着手する日の前提。

### 1. registry に `neovim.dap` フィールドが無い

`mason-lspconfig` は各パッケージが publish する `neovim.lspconfig` から
マッピングを導出できる。DAP には対応するフィールドが無い。

```sh
# neovim キーを持つパッケージが publish しているのは lspconfig だけ
jq -r '[.[] | select(.neovim != null) | .neovim | keys[]] | unique' "$R"
# => ["lspconfig"]
```

よって導出元は `categories: ["DAP"]` + `bin` になる。`mason-nvim-lint` が
`cmd` を `bin` に照合しているのと同じ手口で、キーが変わるだけ。

### 2. nvim-dap に `linters_by_ft` 相当の宣言的リストが無い

nvim-lint は `linters_by_ft`、conform は `formatters_by_ft` という
「ツール名の宣言的リスト」を持っていて、そこから読めば済む。

nvim-dap の解決元は `dap.adapters[name]` の中身になる。

```lua
-- executable adapter
{ type = "executable", command = "dlv", args = { "dap" } }
-- server adapter
{ type = "server", port = 13000, executable = { command = "js-debug-adapter" } }
```

`command` / `executable.command` の両方を見る必要がある。さらに絶対パスや
`node <path>` 形式で書かれることもあり、その場合 `bin` 照合は効かない。
**bare な実行ファイル名で設定されているアダプタしか解決できない**、と
最初から割り切る。`overrides` が逃げ道になるのは lint 版と同じ。

なおこの制約は実害が小さい。registry 側の `bin` を見ると、非自明な対応
（`delve` → `dlv`、`cpptools` → `OpenDebugAD7`、`erlang-debugger` → `els_dap`）が
まさに導出で拾いたいところで、これらは bare 名で書くのが普通。

### 3. jay-babu の付加価値は install ではなく設定生成

`handlers` / `default_setup` は `dap.adapters` と `dap.configurations` を
自動で組み立てる機能で、19件の手書きテーブルが必要なのはこのため。

**ここは registry から導出できないし、導出すべきでもない。**
デバッグ設定はプロジェクト固有（実行ファイルのパス、引数、cwd、環境変数）で、
自動生成しても結局書き換えることになる。

→ 自作版のスコープは **`ensure_installed` / `automatic_installation` だけ**。
`dap.adapters` と `dap.configurations` は `lua/plugins/nvim-dap/` 側に手で書く。
これを明記しておかないと、実装時に「jay-babu と同じ機能を作る」方向に流れる。

## 現状の DAP 関連（着手時に踏むもの）

- `nvim-dap` は `lazy-lock.json` に既にある（commit `9e848e09`）。ただし
  `lua/plugins/statuscol-nvim/dependencies.lua` の transitive dep として
  入っているだけで、`setup()` されていない
- `lua/plugins/statuscol-nvim/opts/clickhandlers.lua` が `DapBreakpoint` /
  `DapBreakpointCondition` / `DapBreakpointRejected` の `toggle_breakpoint` を
  既に持っている
- `<leader>d*` は `lua/plugins/tiny-inline-diagnostic-nvim/keys.lua` が
  `de` / `dd` / `dt` / `dc` / `dr` を占有済み。**DAP キーマップは別 prefix が要る**
- `lua/plugins/mq-nvim/init.lua` が mq.nvim 側の `dap.setup()` 通知を抑制している。
  nvim-dap を一級プラグインに昇格させたら、この抑制が要るか見直す

## 再検証コマンド

registry の内容に依存しているので、上の数字は古くなる。**外れたら分かる形**にしておく。

```sh
R=~/.local/share/nvim/mason/registries/github/mason-org/mason-registry/registry.json

# DAP カテゴリのパッケージ数。期待: 32
jq -r '[.[] | select(.categories | index("DAP"))] | length' "$R"

# neovim フィールドが publish するキー。期待: ["lspconfig"]
jq -r '[.[] | select(.neovim != null) | .neovim | keys[]] | unique' "$R"

# 導出のネタになる name と bin の一覧
jq -r '.[] | select(.categories | index("DAP")) | "\(.name)\t\((.bin // {}) | keys | join(","))"' "$R"
```

1つめが 32 から増えていれば、jay-babu 版の未対応件数（13）はさらに増えている。
2つめが `["lspconfig", "dap"]` などに変われば、**導出方法を `bin` 照合から
そのフィールドに切り替えられる**ので、上の「難しい」1と2はまるごと消える。
