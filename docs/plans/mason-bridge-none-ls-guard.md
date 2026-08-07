# none-ls と guard.nvim の mason 橋渡し

`none-ls.nvim` と `guard.nvim` について、**mason 橋渡しが存在するか、
無いなら自作できるか**を調べたもの。採用の是非はこのファイルの対象外。

調査日: 2026-08-07（mason.nvim 2.3.1 / mason registry 587パッケージ）

## 結論から

| 対象 | 既存の橋渡し | 自作できるか | 解決元 |
| --- | --- | --- | --- |
| none-ls.nvim | `jay-babu/mason-null-ls.nvim`（9ヶ月停止） | **できる** | `sources.get_all()` → `generator.opts.command` |
| guard.nvim | **存在しない** | **できる** | `guard.filetype` の `M[ft]` → `cmd` |

**どちらも `mason-nvim-lint` と同じ手法がそのまま成立する。**
登録済みのツールを実行時に列挙でき、そこから素の実行ファイル名が取れて、
mason registry の `bin` に照合できる。**nvim-dap のときのような
「解決元が無い」問題は起きない。**

## 前提 — 自作2本が使っている手法

`mimikun/mason-conform.nvim` と `mimikun/mason-nvim-lint.nvim` は、
プラグイン内に手書きの対応表を持たない。**登録済みツールの実行ファイル名を、
mason registry が publish する `bin` と `categories` に照合する。**
以下はその手法が使えるかどうかの判定。

橋渡しごとの解決元を並べるとこうなる。

| 橋渡し | 列挙の入口 | 実行ファイル名の在り処 | 判定 |
| --- | --- | --- | --- |
| mason-lspconfig | registry 側 | `neovim.lspconfig`（registry が publish） | 上流が提供 |
| mason-conform（自作） | `formatters_by_ft` | conform の formatter 定義 | 成立済み |
| mason-nvim-lint（自作） | `linters_by_ft` | nvim-lint の `cmd` | 成立済み |
| mason-nvim-dap（未着手） | `dap.adapters` | `command` / `executable.command` | 部分的（絶対パス・`node <path>` は不可） |
| **none-ls** | `sources.get_all()` | `generator.opts.command` | **成立する** |
| **guard.nvim** | `guard.filetype` の `M[ft]` | `cmd` | **成立する**（ラッパーは不可） |

## none-ls.nvim

### 既存の橋渡しは2本、どちらも停止中

| | `jay-babu/mason-null-ls.nvim` | `zeioth/none-ls-autoload.nvim` |
| --- | --- | --- |
| stars / license | 598 / AGPL-3.0 | 27 / GPL-3.0 |
| 最終 push | 2025-11-05（約9ヶ月前） | 2025-06-24（約13ヶ月前） |

後者は "Modern alternative to the plugin mason-null-ls" を名乗るが、
**前者より4ヶ月古い。**

### mason-null-ls は、実は大半が規則ベース

`mason-nvim-dap` の 19件テーブルとは事情が違うので、正確に書いておく。

`lua/mason-null-ls/mappings/source.lua` の手書きテーブルは **11件しかない。**
残りは `_` → `-` の置換で解決している。

```lua
local null_ls_to_package = {
  ['cmake_lint'] = 'cmakelint',
  ['cmake_format'] = 'cmakelang',
  ['phpcsfixer'] = 'php-cs-fixer',
  ['ruff_format'] = 'ruff',
  -- 全11件
}
-- 未登録のものは source 名の `_` を `-` に置換して mason パッケージ名とする
```

**つまり設計は悪くない。** 却下するとしても、`mason-nvim-dap` に書いた
「手書きテーブルが腐る」という理由はここには弱くしか当たらない。

### ただし列挙が「全ビルトイン」になっている

`lua/mason-null-ls/automatic_installation.lua` は、**登録済みソースではなく
none-ls が同梱する全ビルトインを列挙する。**

```lua
local sources = {}
sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').diagnostics))
sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').formatting))
sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').code_actions))
sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').completion))
sources = vim.list_extend(sources, vim.tbl_keys(require('null-ls.builtins').hover))
```

`require("null-ls.sources").get_all()` を**使っていない**。
自作するならここは変える。

### 自作の実現性 — 成立する

none-ls は登録済みソースを実行時に公開している。

- `require("null-ls.sources")` が `get_all()` / `get_available(ft, method)` /
  `get(query)` / `get_filetypes()` / `is_registered(query)` を持つ
- `get_all()` が返すソースは `{ id, name, can_run, generator, filetypes,
  methods, condition, config }` の形
- **実行ファイル名は `generator.opts.command`。**
  `lua/null-ls/helpers/generator_factory.lua` が `opts` をそのまま generator に
  載せている

`command` が関数のケースも問題にならない。解決後の値が `opts.command` へ
書き戻される。

```lua
if type(command) == "function" then
    command = command(params)
    -- prevent issues displaying / attempting to serialize generator.opts.command
    opts.command = command
end
```

→ **`generator.opts.command` を registry の `bin` に照合すれば済む。**
`mason-nvim-lint` が `cmd` に対してやっているのと同一。

さらに `name` も取れるので、`mason-null-ls` の `_` → `-` 規則を
フォールバックとして併用できる。**解決経路が2本ある分、lint 版より条件が良い。**

## guard.nvim

### 橋渡しは存在しない

検索で見つかる `frostplexx/mason-bridge.nvim` は**逆方向**
（mason に入っているものを conform / nvim-lint に登録する）で、
guard.nvim 用ではない。guard.nvim / guard-collection の README にも
mason への言及は無い。

| | guard.nvim | guard-collection |
| --- | --- | --- |
| stars / license | 520 / MIT | 45 / MIT |
| 最終 push | 2026-01-31 | 2026-02-12 |

### 自作の実現性 — 成立する

- `lua/guard/filetype.lua` はモジュールレベルのテーブル `M` に登録内容を持ち、
  `M[filetype].formatter` / `M[filetype].linter` として**実行時に読める**
- 各エントリは `lua/guard/util.lua` の `toolcopy()` を通っていて、
  `cmd` フィールドが残る

```lua
function M.toolcopy(c)
  if type(c) == 'function' then return c end
  if not c or vim.tbl_isempty(c) then return nil end
  return {
    cmd = c.cmd, args = c.args, fname = c.fname, stdin = c.stdin,
    fn = c.fn, events = c.events, ignore_patterns = c.ignore_patterns,
    ignore_error = c.ignore_error, find = c.find, env = c.env,
    timeout = c.timeout, parse = c.parse, health = c.health,
  }
end
```

`cmd` の値は素の実行ファイル名（`stylua`, `rustfmt`, `black`）。
→ **`cmd` を registry の `bin` に照合すれば済む。**

### 解決できないもの2種

1. **`toolcopy()` が元のツール名を捨てる。** 残るのは `cmd` だけなので、
   none-ls のような「名前による第2の経路」が使えない。照合が1本になる
2. **ラッパー経由のものは当たらない。** `prettier` と `eslint_d` は
   `cmd = 'npx'`、`rustfmt_nightly` は `cmd = 'rustup'`。
   mason のパッケージ名にならない

2 は `mason-nvim-dap` で `node <path>` 形式が解決できないと書いたのと同型。
`overrides` を逃げ道にする点も同じ。

### guard-collection の規模

| | guard-collection |
| --- | --- |
| formatter | 66（`lua/guard-collection/formatter.lua` の単一ファイル） |
| linter | 26（`lua/guard-collection/linter/*.lua`） |

橋渡しが扱う母数はこの 92 件。

## 着手するなら

`mason-conform.nvim` / `mason-nvim-lint.nvim` と同じ構成をコピーする。
両者で `lua/<name>/` 以下の構成は既に共通化されている
（`source.lua` / `mappings.lua` / `install.lua` / `settings.lua` /
`health.lua` / `notify.lua` / `api/command.lua` /
`features/{ensure_installed,automatic_installation}.lua`）。

差し替えるのは `source.lua` の1点だけ。

| 対象 | `source.lua` が返すもの |
| --- | --- |
| none-ls | `require("null-ls.sources").get_all()` を回して `generator.opts.command`（+ フォールバックに `name`） |
| guard.nvim | `require("guard.filetype")` の `M` を回して `M[ft].formatter[*].cmd` と `M[ft].linter[*].cmd` |

`:checkhealth` を持たせる点も既存2本にそろえる。
**どちらのプラグインも設定後に読む必要がある**ので、lazy.nvim の
`dependencies` に対象プラグインを入れる（`mason-conform-nvim/dependencies.lua`
の conform と同じ理由。あちらのコメントに経緯がある）。

## このファイルが答えていないこと

- **入れるかどうか。** conform + nvim-lint と同じ層になる点は別途判断が要る
- **どちらを先に作るか**
- none-ls の `code_actions` / `completion` / `hover` 系ソースの扱い。
  これらは実行ファイルを持たないものがあり、`bin` 照合の対象外になる。
  **未確認**

## 再検証コマンド

上流の API 形状に依存しているので、変わったら結論も変わる。

```sh
# none-ls: 列挙 API と command の在り処
gh api repos/nvimtools/none-ls.nvim/contents/lua/null-ls/sources.lua \
  --jq '.content' | base64 -d | grep -n "^M.get_all = function\|^M.get_available = function"

# none-ls: generator に opts が載っているか
gh api repos/nvimtools/none-ls.nvim/contents/lua/null-ls/helpers/generator_factory.lua \
  --jq '.content' | base64 -d | grep -n "opts = opts"

# guard: toolcopy が cmd を残しているか
gh api repos/nvimdev/guard.nvim/contents/lua/guard/util.lua \
  --jq '.content' | base64 -d | grep -n "cmd = c.cmd"

# guard-collection の母数。期待: formatter 66 / linter 26
gh api "repos/nvimdev/guard-collection/git/trees/main?recursive=1" --jq \
  '[.tree[].path | select(test("linter/.*\\.lua$"))] | length'

# mason-null-ls の手書きテーブルが増えていないか。期待: 11
gh api repos/jay-babu/mason-null-ls.nvim/contents/lua/mason-null-ls/mappings/source.lua \
  --jq '.content' | base64 -d | grep -c "^\s*\['"
```

`grep` が空を返すようになったら、その節の前提が崩れている。

## 参照

- `docs/plans/mason-nvim-dap.md` — 同じ判定を DAP に対してやったもの
- `~/ghq/github.com/mimikun/mason-nvim-lint.nvim/lua/mason-nvim-lint/source.lua` — 差し替える対象の実物
- `~/ghq/github.com/mimikun/mason-conform.nvim/` — 同上
- https://github.com/nvimtools/none-ls.nvim
- https://github.com/jay-babu/mason-null-ls.nvim
- https://github.com/nvimdev/guard.nvim / https://github.com/nvimdev/guard-collection
