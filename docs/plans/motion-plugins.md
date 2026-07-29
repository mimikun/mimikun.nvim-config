# 移動系プラグインの再編

`flash.nvim` の 2-hop jump（ラベル先行の単語頭ジャンプ）が動かない件を調べた
結果、プラグイン構成そのものを組み直すことになった。その調査結果と作業計画。

調査日 2026-07-29 / Neovim `v0.13.0-dev-1141+ge3c5974adf`（bob nightly）。

## 結論から

| 役割 | 担当 | 状態 |
| --- | --- | --- |
| ラベル先行（2-hop jump / 行頭 / 1文字） | **mini.jump2d** | 新規導入 |
| 検索先行 + treesitter + remote + f/t | **leap.nvim** | 導入済み・有効・そのまま |
| ~~flash.nvim~~ | 不採用 | nightly で故障中、かつ leap が全機能を代替 |
| ~~hop.nvim~~ | 不採用 | mini.jump2d が上位互換 |

当初は「4 つのどれか 1 つで全部カバーできる」という前提で調べていたが、
**2 本必要**で、**うち 1 本（leap）は既に入っている**、が答えだった。

## flash.nvim は今の Neovim で動かない

`<leader>lh`（2-hop jump）を実機で叩くと出る。

```text
E5108: Lua: .../flash/search/init.lua:58: .../flash/hacks.lua:28:
/home/mimikun/.local/share/bob/nightly/bin/nvim: undefined symbol: search_match_lines
```

flash.nvim は「マッチがどこで終わるか」を求めるために Neovim の C グローバル
変数を FFI で直接読んでいる（`lua/flash/hacks.lua:13-15`）。Neovim 側の
[neovim#39485](https://github.com/neovim/neovim/pull/39485)（commit `9bfa3378`）が
バラバラだった変数を `SearchState Search` 構造体に統合したため、シンボルが消えた。

| シンボル | 0.13.0-dev での状態 |
| --- | --- |
| `search_match_lines` | **undefined** |
| `search_match_endcol` | **undefined** |
| `no_mapping` | 生存 |
| `setcursor_mayforce` | 生存（`nvim__redraw` の代替パスあり） |

### 影響範囲 — 2-hop jump だけの問題ではない

`lua/flash/search/init.lua:35` が全マッチで `Hacks.get_end_pos()` を呼ぶため、
**regex 検索を通る機能は全滅**する。

```lua
-- 検証: State.new の時点で例外
require('flash.state').new({ pattern = 'a', search = { mode = 'exact' } })
--> undefined symbol: search_match_lines
```

- ✗ `flash.jump()` / `flash.remote()` / `f,F,t,T` の char モード / `/` 連携
  / 2-hop jump
- ○ `flash.treesitter()` のみ生存（`vim.treesitter` の node を直接見るため）

プロンプトの ⚡ は出るので、1 文字打つまで壊れていることに気付けない。

### 上流は事実上停滞している

- `main` HEAD は `b634694`（2026-07-10）で修正は入っていない
- この不具合の修正 PR が **2 本**出ているが**どちらも未マージ**
  - [#492](https://github.com/folke/flash.nvim/pull/492)（2026-07-17）
  - [#496](https://github.com/folke/flash.nvim/pull/496)（2026-07-28、mergeable）
- open PR は 10 本、最古は 2025-08-20 から**11 ヶ月放置**

マージ待ちは博打なので、待たない判断をした。

### 自前パッチは書けるが採らない

`hacks.get_end_pos` の代わりに `searchpos(pattern, "cen")` を使う shim を書いて
2-hop jump が通ることまでは確認した（複数文字マッチの `end_pos` も正しい。
`ro` → `2:4-2:5`、regex `\<` → 25 マッチ）。

```lua
function Search:_next(flags)
  local ok, pos = pcall(vim.fn.searchpos, self.state.pattern.search, flags or "")
  if not ok or pos[1] == 0 then return end
  local ok_end, end_pos = pcall(vim.fn.searchpos, self.state.pattern.search, "cen")
  if not ok_end or end_pos[1] == 0 then return end
  return {
    win = self.win,
    pos = Pos({ pos[1], pos[2] - 1 }),
    end_pos = Pos({ end_pos[1], math.max(0, end_pos[2] - 1) }),
  }
end
```

ただし**FFI で C 内部を触る構造そのものが残る**ので、nightly が動くたびに
また壊れる。PR #496 の方が正確（`Search` 構造体を正しく読み、incsearch 状態の
復元まで対応）でもある。自前 shim を抱える理由が無い。

## 4 プラグインの機能マトリクス

すべてソース実測。

| 機能 | leap.nvim (andyg) | flash.nvim | hop.nvim (smoka7) | mini.jump2d |
| --- | --- | --- | --- | --- |
| **2-hop jump**（ラベル先行・単語頭） | △ 自作 targets 必要 | ○ **故障中** | ○ HopWord | **◎ 標準** |
| 検索先行ジャンプ（2文字→ラベル） | **◎** `<Plug>(leap)` | ○ **故障中** | △ HopChar2 | △ `query` はモーダル入力 |
| treesitter ノード選択 | **◎** `leap.treesitter.select()` | ○ **唯一生存** | ✗ | **✗** grep 0 件 |
| remote 操作 | **◎** `leap.remote.action()` | ○ **故障中** | ✗ | **✗** |
| f/t/T 強化 | ◎ `<Plug>(leap-forward-to/-next-to)` | ○ **故障中** | △ HopChar1 | ✗ 別モジュール(mini.jump) |
| クロスウィンドウ | ◎ | ○ | ○ | ◎ |
| 最終更新 | **2026-07-19** | 2026-07-10（PR放置） | 2025-08-22 | **2026-07-23** |
| FFI で C 内部依存 | なし | **あり** | なし | なし |

### leap.nvim は flash.nvim をほぼ完全に代替する

ここが調査で一番大きかった発見。Codeberg 版 leap（`codeberg.org/andyg/leap.nvim`）は
オリジナルの ggandor 版から進化していて、**treesitter 選択と remote 操作を内蔵**する。

```text
~/.local/share/nvim/lazy/leap.nvim/lua/leap/
  treesitter.lua   → select()    # flash.treesitter() 相当
  remote.lua       → action()    # flash.remote() 相当
```

`<Plug>` も揃っている。

```text
(leap) (leap-anywhere) (leap-cross-window) (leap-from-window)
(leap-forward) (leap-backward) (leap-forward-to) (leap-backward-to)
(leap-forward-next-to) (leap-backward-next-to) (leap-next-to)
```

コミット頻度も 2026-07-19 / 06-09 / 06-01 / 05-28 / 05-24 / 05-17 / 05-05 と定期的。
**flash.nvim に残る固有価値はゼロ**になった。

`doc/leap.txt:457` の `leap-custom-targets` で任意のターゲット列を渡せるため、
単語頭を返す関数を 20 行ほど書けばラベル先行ジャンプも leap で実現できる
（treesitter 選択がまさにその仕組み）。1 本構成も可能だが、自作コードの
メンテを抱えるより既製品の mini.jump2d を使う方を採った。

### mini.jump2d は hop.nvim を完全に代替する

hop の各ヒントモードに 1 対 1 の対応物がある。

| hop.nvim | mini.jump2d |
| --- | --- |
| HopWord | `builtin_opts.word_start` |
| HopLine | `builtin_opts.line_start` |
| HopChar1 | `builtin_opts.single_character` |
| HopPattern / HopChar2 | `builtin_opts.query` |
| HopAnywhere | `default_spotter` |

ただし **leap / flash は代替できない**。ソース全体で `treesitter` が **0 ヒット**、
remote 操作なし、検索先行は `vim.fn.input` によるモーダル入力
（`lua/mini/jump2d.lua:1146`）で leap のインクリメンタルな操作感とは別物。

operator-pending は dot-repeat 込みで対応済み（`lua/mini/jump2d.lua:1121`）。

### hop.nvim を採らない理由

| リポジトリ | 状態 |
| --- | --- |
| `phaazon/hop.nvim` | **リポジトリごと削除済み**（404） |
| `smoka7/hop.nvim` | 最終コミット 2025-08-22（約 11 ヶ月前）、★799 |
| `wsdjeg/hop.nvim` | smoka7 の**フォークのフォーク**、最終 2026-04-12、★5 |

`smoka7` は archived ではないが「アクティブにメンテされている」とは言えない。
`wsdjeg` は smoka7 より新しいものの実質個人フォークでバス係数 1。
同じ移籍コストなら mini.jump2d が明確に上。

### mini.jump2d の 2-hop 動作確認

実機で完走を確認済み。

```text
<leader>lh  →  120 個の単語頭に 2 文字ラベル
                aapha0 asavo0 adarlie0 aflta0 agho0 saxtrot0 ...
w           →  絞り込み + 1 文字に再ラベル
                alpha2 bravo2 ... ailo2 sima2 dike2 fovember2 ...
s           →  cursor=3,79  word=lima2   errmsg=[]
```

flash のレシピと同じ見た目・同じ操作感。ターゲットが 26 個以下なら 1-hop。

## 作業ブランチ

`refactor/motion-plugins`（master `89d58728` から作成）。

master の移動系プラグインは `lua/plugins/leap-nvim` **1 つだけ**で、flash も
hop も master には存在しない。つまり「一括削除」の実体はツリーからの削除ではなく、
**未マージのブランチ 2 本を畳むこと**。

| ブランチ | 内容 | 扱い |
| --- | --- | --- |
| `add/flash-nvim` | `3eef0c87` spec + `0dc87430` docs 103行 + `83485bd0` wip（CODES 一式 + MYCFG / MYOLDCFG） | 未決 |
| `origin/add/hop-nvim` | `51701210 feat: add wsdjeg/hop.nvim`（テンプレのみ、`enabled = false`） | 未決 |

⚠️ `add/flash-nvim` を消すと **MYCFG / MYOLDCFG も一緒に消える**。あのブランチに
しか存在しない。2-char jump のレシピ自体は flash の upstream README と同一
（`README.md:701-741`）なので内容としては失われないが、消す前に判断が要る。

**2026-07-29 追記 — 削除前の転記。** レシピ本体が upstream README
（`CODES/README.md:703-744`）とバイト単位で同一であることを確認した（`Flash` という
ローカル変数を `require("flash")` に置換した差分のみ）。よってレシピは失われない。
README に存在しないのはキー割り当てだけなので、それをここに残して両ブランチを削除した。

| キー | mode | 機能 |
| --- | --- | --- |
| `<leader>ls` | n,x,o | `flash.jump()` |
| `<leader>lS` | n,x,o | `flash.treesitter()` |
| `<leader>lr` | o | `flash.remote()` |
| `<leader>lR` | o,x | `flash.treesitter_search()` |
| `<leader>lh` | n | 2-char jump（HopWord 相当） |
| `<leader><c-s>` | c | `flash.toggle()` ← leader が `<Space>` なので事実上のバグ |
| `<leader><c-space>` | n,x,o | treesitter incremental selection |

MYOLDCFG は同じレシピを `<leader>hs` / `<leader>hS` / `<leader>hh` に割り当てた旧版。
つまり **`<leader>l*` は leap ではなく flash の名前空間**として始まっている。
移動系のキー体系を決め直すときの出発点はこの表。

## 作業骨組み

```text
1. mini.jump2d を追加            … 2-hop jump（ラベル先行）
   ├ 導入方法        : 済  nvim-plugin-clone.sh で add/mini-jump2d を作成（2026-07-29）
   │                        URL は nvim-mini/mini.jump2d（oil-nvim が nvim-mini/mini.icons
   │                        を使っている慣習に合わせた）
   └ キーマップ      : TBD  (<leader>lh 踏襲 / <CR> デフォルト / 別)
                             ※ 設定は本人が手で書く。<CR> は qf と cmdwin だけ
                                プラグイン側が自動 revert する（jump2d.lua:783-789）。
                                help / man は未対応なのでタグジャンプが潰れる

2. leap-nvim を拡張              … 検索先行 + treesitter + remote + f/t
   ├ 現状は s / gs の 2 つだけ
   ├ 有効化する機能  : TBD  (treesitter / remote / f,t のどこまで)
   └ キーマップ      : TBD

3. ドキュメント                   … lua/plugins/docs/Integrations/
   └ 対象            : TBD  (mini-jump2d.md / leap-nvim.md)

4. 旧ブランチの後始末            … 済（2026-07-29）
   ├ add/flash-nvim  : 削除  PR #58 クローズ済み、remote / local とも削除
   │                        キー割り当ては上の表に転記して保存
   └ add/hop-nvim    : 削除  PR #91 クローズ済み、remote 削除（local は元々無し）
```

## 参考 — MYCFG に残っていた設定バグ

flash を採らないので直す必要は無いが、同じ轍を踏まないための記録。
今回の故障とは**無関係な独立したバグ**が 3 つあった。

| 箇所 | 内容 |
| --- | --- |
| `init.lua:13-14` | `cond = false` / `enabled = false` がテンプレのまま残り、そもそもロードされない |
| `opts.lua:14-24` | `search.mode` を関数にして `"exact"` を返していた。関数を渡した場合の戻り値は**モード名ではなく検索パターンそのもの**（`lua/flash/search/pattern.lua:73-82`）なので、入力に関係なく常に `exact` という文字列を検索する |
| `keys.lua:62` | `<leader><c-s>` を cmdline モードに割り当て。leader が `<Space>`（`lua/config/variables.lua:1`）なのでスペース入力のたびに待ちが入る。上流どおり `<c-s>` 単体にすべき |

`opts.lua` は upstream デフォルトのほぼ全コピー（310 行）で、selene の
unused variable も出る（`search` / `fuzzy` / `example`）。

## 再現・検証手順

`neowright` で実機を駆動できる。プラグイン本体は
`~/.local/share/nvim/lazy/<plugin>` に既にあるものを rtp に prepend すれば
最小構成で再現できる。

```bash
neowright open --name t -- -u init.lua sample.txt
neowright keys --name t "<Space>lh"
neowright snapshot --name t
neowright eval --name t "return vim.api.nvim_win_get_cursor(0)[1]"
neowright close --name t
```

FFI シンボルの生死は単体で確認できる。

```lua
pcall(require('flash.hacks').get_end_pos, {1, 0})
pcall(require('flash.hacks').save_incsearch_state)
```

## 参照

- `lua/plugins/leap-nvim/` — 現行の leap spec（`s` / `gs` のみ設定）
- `~/.local/share/nvim/lazy/leap.nvim/doc/leap.txt` — `leap-custom-targets` は L457
- `scripts/nvim-plugin-clone.sh` — プラグイン追加のスキャフォールド
- [folke/flash.nvim#496](https://github.com/folke/flash.nvim/pull/496) — 未マージの修正 PR
- [neovim/neovim#39485](https://github.com/neovim/neovim/pull/39485) — シンボル削除の原因
- [echasnovski/mini.jump2d](https://github.com/echasnovski/mini.jump2d) — 単体版ミラー
