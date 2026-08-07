# none-ls と guard.nvim を採らない理由

conform.nvim + nvim-lint が入っている状態で、同じ層のプラグイン2つを
再検討したときのメモ。**mason 連携が要りそう**という動機から始めたが、
調べた結果、mason 以前の段階で結論が出た。

調査日: 2026-08-07（mason.nvim 2.3.1 / mason registry 587パッケージ）

## 結論から

| 候補 | mason 橋渡し | 判定 |
| --- | --- | --- |
| ~~nvimtools/none-ls.nvim~~ | `jay-babu/mason-null-ls.nvim` あり | **不採用** — 重複層。固有機能に消費者が居ない |
| ~~nvimdev/guard.nvim~~ | **存在しない** | **不採用** — 重複層。ツール網羅が 1/5 |

調べる前は「mason 橋渡しがあるか」が争点だと思っていた。実際の争点は
**そこではなかった**。どちらも conform + nvim-lint と同じ層で、
入れ替えなら既存設定と自作プラグイン2本を捨てることになり、併存なら
同じファイルを2つの経路がフォーマットする。mason 橋渡しの有無は
その後の話でしかない。

**この判断は実質すでに下されている。** none-ls は 2026-05-11 に vendor 済みで
PR #141 が draft のまま開いている。その後に conform（2026-07-31 に設定完了）と
nvim-lint（2026-08-05）が master に入った。**選択の事実は git に残っているが、
理由はどこにも書かれていなかった。** このファイルがそれ。

## 現状のスタック（比較の土台）

| | 同梱ツール数 | この config で設定済み | mason 橋渡し |
| --- | --- | --- | --- |
| conform.nvim | 260 | 51 filetype | `mimikun/mason-conform.nvim`（自作、51中31解決） |
| nvim-lint | 186 | 42 filetype | `mimikun/mason-nvim-lint.nvim`（自作、37中26解決） |

`lua/plugins/nvim-lint/opts.lua` の冒頭コメントのとおり、両者の
ツール選択は**意図的にそろえてある**。

> The toolchain mirrors `plugins.conform-nvim.opts` wherever both sides ship a
> tool for the same filetype, so formatting and linting never disagree about style.

ずらしてある箇所も1つだけ明記されている（scss は biome が非対応なので
formatter=biome / linter=stylelint）。**この対応表が資産で、乗り換えると消える。**

## none-ls.nvim

### 上流は健康。問題はそこではない

| 項目 | 値 |
| --- | --- |
| stars / license | 3252 / Unlicense |
| 最終 push | 2026-06-02（約2ヶ月前） |
| open issues | 12 |

null-ls のメンテ終了を引き継いだ fork で、生きている。
`none-ls-extras.nvim`（2026-07-17）も動いている。

### mason 橋渡しは、今日却下したのと同じ形

| | `jay-babu/mason-null-ls.nvim` | `zeioth/none-ls-autoload.nvim` |
| --- | --- | --- |
| stars / license | 598 / AGPL-3.0 | 27 / GPL-3.0 |
| 最終 push | 2025-11-05（約9ヶ月前） | 2025-06-24（約13ヶ月前） |

`mason-null-ls.nvim` は `mason-nvim-dap.nvim` と**同じ作者・同じ設計**で、
`docs/plans/mason-nvim-dap.md` に書いた却下理由がそのまま当てはまる。
「modern alternative」を名乗る `none-ls-autoload.nvim` のほうが**より古い**。

### 固有機能はあるが、消費者が居ない

none-ls が conform + nvim-lint より広いのは、フォーマットと診断の**外側**。

| 系統 | none-ls | この config の現状 |
| --- | --- | --- |
| formatting | あり | conform が担当。**重複** |
| diagnostics | あり | nvim-lint が担当。**重複** |
| code actions | あり | **何も無い** |
| completion | あり | **補完エンジン自体が無い** |
| hover | あり | LSP のみ |

- `grep -rn "code_action" --include="*.lua"` が**リポジトリ全体でゼロ件**。
  `vim.lsp.buf.code_action` のキーマップも、code action UI プラグインも無い
- 補完エンジンが未導入（`docs/plans/lsp-plugin-conflicts.md` の
  nvim-html-css の節で確認済み）。`builtins.completion.*` は表示先が無い

つまり **none-ls を入れて得られる固有の価値は、現状すべて受け皿が無い。**
先に必要なのは none-ls ではなく、code action のキーマップと補完エンジン。

なお `lua/plugins/semgrep-nvim/` が外部ツールの自動修正（`:SemgrepFix`）を
持っているが、これは LSP code action ではなくプラグイン独自コマンド。

## guard.nvim

### mason 橋渡しは存在しない

検索して見つかるのは `frostplexx/mason-bridge.nvim` だが、これは
**逆方向**（mason に入っているものを conform / nvim-lint に登録する）で、
guard.nvim 用ではない。

| 項目 | guard.nvim | guard-collection |
| --- | --- | --- |
| stars / license | 520 / MIT | 45 / MIT |
| 最終 push | 2026-01-31（約6ヶ月前） | 2026-02-12（約6ヶ月前） |

### ツール網羅が 1/5

| | guard-collection | 現状 |
| --- | --- | --- |
| formatter | 66 | conform 260 |
| linter | 26 | nvim-lint 186 |

現在 conform で設定している 51 filetype 分のツールが guard-collection に
そろっている保証は無い。**乗り換えは機能追加ではなく機能削減になる。**

### 自作橋渡しの実現性は、実は高い（採らないが記録する）

`mason-nvim-lint` と同じ手が使える。判定に必要だったので確認した結果を残す。

- `lua/guard/filetype.lua` はモジュールレベルのテーブル `M` に登録内容を持ち、
  `M[filetype].formatter` / `M[filetype].linter` として**実行時に読める**
- 各エントリは `lua/guard/util.lua` の `toolcopy()` を通っていて、
  `cmd` フィールドが残る。値は素の実行ファイル名（`stylua`, `rustfmt`, `black`）
- → `cmd` を mason registry の `bin` に照合する、`mason-nvim-lint` と同一の手法が成立する

**成立しない箇所も同じ形で存在する。**

- `toolcopy()` は**元のツール名を捨てる**。残るのは `cmd` だけ
- ラッパー経由のものは解決できない — `prettier` と `eslint_d` は `cmd = 'npx'`、
  `rustfmt_nightly` は `cmd = 'rustup'`。mason のパッケージ名に当たらない

nvim-dap で `node <path>` 形式が解決できないと書いたのと同じ制約。
**つまり技術的な障害は無い。採らない理由は層の重複だけ。**

## 未処理の PR

`add/none-ls-nvim`（PR #141、draft、2026-05-11）が開いたまま。
vendor 済みで spec は upstream の README 例のまま（`stylua` と
`completion.spell` が入っている状態）。

このファイルの結論に従うなら**閉じる**。ただし vendor した
`WIKIS/Avoiding-LSP-formatting-conflicts.md` などは、将来 code action が
必要になったときの資料として一度目を通す価値がある。

## 再検証コマンド

判断の前提が変わったら結論も変わる。**変わったと分かる形**で残す。

```sh
# 1. code action の消費者が現れたか（ゼロ件でなくなったら none-ls の前提が変わる）
cd ~/.config/nvim && grep -rn "code_action" --include="*.lua" . | wc -l   # 期待: 0

# 2. 補完エンジンが入ったか
ls -d lua/plugins/blink-cmp lua/plugins/nvim-cmp 2>/dev/null   # 期待: 無し

# 3. guard-collection の網羅が増えたか
gh api "repos/nvimdev/guard-collection/git/trees/main?recursive=1" --jq \
  '[.tree[].path | select(test("linter/.*\\.lua$"))] | length'   # 期待: 26

# 4. conform / nvim-lint 側の同梱数（分母）
ls lua/plugins/conform-nvim/formatters/*.lua | grep -v _types | wc -l      # 期待: 260
ls ~/.local/share/nvim/lazy/nvim-lint/lua/lint/linters/*.lua | wc -l       # 期待: 186
```

1 が非ゼロになったときだけ none-ls を再検討する。**それ以外は再検討しない。**

## 参照

- `docs/plans/mason-nvim-dap.md` — `jay-babu/*` 系を却下する理由の初出
- `lua/plugins/conform-nvim/opts.lua` — `formatters_by_ft`（51 filetype）
- `lua/plugins/nvim-lint/opts.lua` — `linters_by_ft` と、conform と揃えている旨の説明
- `lua/plugins/mason-conform-nvim/` / `lua/plugins/mason-nvim-lint/` — 自作橋渡し2本
- https://github.com/nvimtools/none-ls.nvim
- https://github.com/nvimdev/guard.nvim / https://github.com/nvimdev/guard-collection
