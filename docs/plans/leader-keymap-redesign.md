# `<leader>` キーマップのゼロベース再設計

which-key のグループラベル付けから始めたが、prefix の分け方そのものに基準が
無いことが分かったので、配置を組み直すことにした。その設計と作業計画。

調査日 2026-08-23 / Neovim `v0.13.0-dev-1376+g6423657352`（bob nightly）。
プラグイン 170 個（有効 140 / 無効 29）、`<leader>` 配下 269 キーマップ。

## 決まっていること

**分類軸は混在。切る規則を明示する**（2026-08-23 決定）。

> **対象を差し替えても手順が変わらないか。**
> Yes なら**動詞別**の prefix に置く。No なら**対象別**の prefix に置く。

純粋な対象別・動詞別を採らない理由は、現状が既に混在で成立しているため。
`F` = Find（12件）と `u` = Toggle（11件）は動詞別、`z` = Telekasten や
`o` = GitHub は対象別。どちらかに倒すと、動いている側を壊す。

## 1. 動詞別に置く操作 — **TBD**

規則を当てると、候補は2つに絞られる。

| 操作 | 規則の判定 | 現状 |
|---|---|---|
| find / pick | 対象が buffer でも file でも grep でも「候補を出して選ぶ」で同じ | `F` に12件 |
| toggle | 対象が何であれ「オン / オフ」で同じ | `u` に11件、**他に24件が散在** |

open / run / delete は、対象ごとに手順が違うので対象別に落ちる。

**動詞別は find と toggle の2つに限定する**（2026-08-23 決定）。

規則を他の動詞に当てると全部が対象別に落ちたため。`open` は buffer / ファイル /
GitHub の PR で手順が違い、`run` は SQL / ターミナル / テストで違う。`delete` も同様。
**動詞別を増やすほど2文字目が枯渇し、対象別との境界が曖昧になる**ので、少ないほど保つ。

find と toggle 以外の動詞は、**対象別 prefix の2文字目**に置く。

**find の prefix は `t`**（2026-08-23 決定）。

`t` を telescope.nvim のキーとして使ってきた指の記憶がある。裏が snacks でも
fzf-lua でも、**探す操作の入口が `t`** という対応は変わらないので、実装の差は
些細な問題として扱う。

`f` は Format で固定。上流慣習の `f` = find には**寄せない。**

**この決定の代償: `t` の現住民12件が全員退去する。**
移動先は §3 で決める。

| 出所 | キー | 件数 |
|---|---|---|
| tabterm.nvim | `tt` `ts` `tc` | 3 |
| dooing | `td` `tD` `tN` `tn` | 4 |
| obsidian-tasks | `to` `ta` | 2 |
| translate.nvim | `tj` `te`（n/v/x） | 2 |
| bloocky | `tb` | 1 |
| template.nvim | `tp` | 1 |
| gitsigns | `tb` `tw`（バッファローカル） | 2 |
| blink-indent | `ti` | 無効 |

**副作用として `tb` の衝突が消える**（付録A）。`F` も空く。

### toggle に集めるのは「エディタ全体の見え方」だけ（2026-08-23 決定）

desc に Toggle と書いてある 35 件に規則を当てると4つに割れる。**A だけを `u` に集める。**

| 分類 | 規則の判定 | 件数 | 行き先 |
|---|---|---|---|
| **A. エディタ全体の見え方** | 対象は「エディタ自体」で差し替えようがない → 手順が同じ | 14 | **`u`** |
| **B. パネル / ウィンドウの開閉** | 開いた後にやることが対象ごとに違う。入口が同じだけ | 11 | 各対象の prefix |
| **C. プラグイン固有の内部モード** | 手順はプラグイン依存 | 9 | 各プラグインの prefix |
| **D. テキスト編集** | トグルではない | 1 | 対象別 |

- **A**: `ub` `uc` `uf` `uh` `ul` `uL` `up` `uP` `us` `uT` `uw` `dt` `dc` `gt`（＋無効の `ti`）
- **B**: `mm` `mf` `mp` `mt` `sc` `tt` `td` `tb` `ac` `v` Triptych
- **C**: `Ct` `Ci` `ct` `nt` `ef` `eh` `ei` `er` `st`
- **D**: `zt`

**C まで入れると `u` が23件になり、`ue` `uE` のような意味の取れない2文字目を
作ることになる。** そこが線を引く実務上の理由。A だけなら14件で2文字目は枯渇しない。

**副作用: `d` が5件中2件を失って3件になる。** `d` = diagnostics というラベルが
成立するかは §3 で見直す。

## 2. 上流に譲る prefix — 材料は集めた

**上流が既定値を持つ prefix に自分の割り当てをぶつけると、後から譲る羽目になる。**
先に確保しておく。インストール済み 174 プラグインのソースを走査した結果:

| プラグイン | 上流の既定 | 状態 |
|---|---|---|
| surround-ui.nvim | **`<leader>S`** | 有効。`root_key` を `"<leader>" .. root_key` で組み立てるので、ソースを grep しても `<leader>S` という文字列は出てこない |
| snacks.nvim | `f` file/find、`s` search、`g` git、`u` ui toggle、`.` scratch、`,` buffer、`/` grep | 有効。現状は独自割り当てで上書きしている |
| octo.nvim | `o` (od/oi/on/op/os)、`a`、`b`、`qa` | 有効。`o` は既に一致 |
| dooing | `td` `tD` `tn` `tN` `D` `p` | 有効 |
| codewindow.nvim | `mc` `mf` `mm` `mo` | 有効。**この設計で `M` へ移した** |
| bloocky | `tb` `tB` | 有効 |
| vallow.nvim | `v` `V` `vr` `vs` `vv` | 有効 |
| peeper-picker.nvim | `ph` `pp` | 有効 |
| fyler.nvim | `e` | 有効 |
| codediff.nvim | `b` `e` `x` `c*` `h*` | 有効（view 内のみ） |
| k8s.nvim | `d` | 有効。**既定を適用しているか要確認**（現状 `d` = diagnostics） |
| homeassistant-nvim | `ha` `hd` `hD` `he` `hp` `hr` | **無効** |
| openspec.nvim | `oa` `oh` `os` `ow` / `xa` `xh` `xn` `xs` `xt` `xw` | **無効**。有効化すると `o` `x` と衝突 |
| diffview.nvim | `a` `b` `c*` `e` `dg` | **未導入** |

gitsigns は `<leader>h` をソースに持たない。あれは README の例をこちらの
`lua/plugins/gitsigns-nvim/opts.lua` の `on_attach` に写したもので、譲る義務は無い。
ただし **hunk = `<leader>h` は界隈で広く通っている**ので、動かすと検索性が落ちる。

### 譲るのは層1と層3だけ（2026-08-23 決定）

上流の「既定」は3層に分かれる。二択ではない。

| 層 | 内容 | 扱い |
|---|---|---|
| **1. プラグインが自分で張る名前空間** | こちらの設定を経由しない。配下の構造ごと上流のもの | **譲る**（surround-ui `S`） |
| **2. 上書き可能な既定値** | `opts` / `keys` で差し替えられる | **規約を優先して上書き**（snacks・octo・dooing・vallow など） |
| **3. ソースには無い界隈の慣習** | README の例が広まっただけ | **譲る**（gitsigns `h` = hunk） |

- 層2を譲ると、規約が上流の都合で決まる。`f` = Format / `t` = find の決定が
  **層2を上書きするという判断そのもの**なので、ここで反転させると §1 が崩れる
- 層1は譲る以外にない。奪うとプラグインの機能が丸ごと死ぬ。コストは大文字1つ
- 層3を譲る理由は**検索性**。`<leader>h` = hunk は他人の設定や README で通じる
  語彙で、規約から導けない知識を外部から補充する窓口になる。しかも既にそう書いて
  いるのでコストはゼロ

**層1は今後も増える。** `"<leader>" .. root_key` の形は grep に引っかからないので、
**新しいプラグインを入れるたびに確認する**。§4 の検算手順に入れる。

### 無効なプラグインの分は確保しない（2026-08-23 決定）

29個が `enabled = false`。うち4つが `<leader>` 配下を主張している（付録A の潜在的衝突）。

**確保しない。ただし一覧には残す。**

- 29個のうち何個が有効化されるか分からない。**使っていないもののために使っている
  ものを窮屈にする**のは、`add/` ブランチ105本を全部入れてから設計するのと同じ形
- 確保しなくても困らない。規約の目的は「次に1個増えたとき置き場が規約から決まる」
  ことなので、有効化する日に規則を当てれば導出できる。**確保とは、その導出を今
  やって寝かせておくことでしかない**
- したがって **`<leader>w` は空きとして使ってよい**（無効な wind.nvim の主張は数えない）

## 3. 対象別の割り当て

**小文字は `w` 以外すべて埋まっている。** 未使用の大文字は
`A E G H I J K N O P Q R T U V W X Y Z`（`S` は surround-ui）。

### 割り当ての共通規則（2026-08-23 決定）

1. **打鍵コストは頻度に比例させる。** 稀なものは大文字でよい。Shift の1打鍵は
   月に数回なら誤差だが、**頻度の高いものに大文字を当てると毎日払う**
2. **グループを作るのは2件以上から。** 1件なら大文字1打で直接叩く。
   which-key のポップアップにも `+1 keymaps` ではなく操作名がそのまま出る
3. **ただし、同じ対象のプラグインが控えているなら1件でもグループにする。**
   例: git は `add/neogit` `add/vim-fugitive` `add/vim-gin` `add/diffview-plus-nvim`
   `add/diffs-nvim` が控えているので `<leader>g` はグループのまま
4. **「頭文字が同じ」は対象が同じことを意味しない。** `m` に minimap / markdown / mq
   が同居していたのがその形。**ラベルが書けない prefix は分類が間違っている**

### 3-1. `t` からの退去 — 完了（2026-08-23 決定）

| 現在 | 移動先 | 形 | 導出 |
|---|---|---|---|
| gitsigns `tb` blame トグル | `u` 配下 | — | A分類 |
| gitsigns `tw` word diff トグル | `u` 配下 | — | A分類 |
| blink-indent `ti`（無効） | `u` 配下 | — | A分類 |
| tiny-glimmer `ge` `gd` `gt` | `u` 配下 | — | A分類。**git とは無関係**なので `g` には残さない |
| bloocky `tb` カレンダー | **`<leader>K`** | 単独キー | 稀・1件・控えなし |
| template.nvim `tp` | **`<leader>P`** | 単独キー | 稀・1件・控えなし |
| translate.nvim `tj` `te` | **`<leader>R`** | グループ | 稀・2件 |
| tabterm.nvim `tt` `ts` `tc` | **`<leader>T`** | グループ | 稀・3件 |
| dooing `td` `tD` `tN` `tn` | **`<leader>D`** | グループ | 稀・4件 |
| obsidian-tasks `to` `ta` | **`<leader>o`** | グループ | 本人の要求。将来 obsidian.nvim も |
| octo.nvim `o*` 5件 | **`<leader>G`** | グループ | `o` を空けるため。GitHub Actions と合流 |
| github-actions.nvim `gd` `gh` `go` `gp` `gw` | **`<leader>G`** | グループ | git（ローカル）と GitHub（リモート）は別対象 |
| snacks `gB` browse | **`<leader>G`** | グループ | リモートを開く操作 |
| snacks `gl` LazyGit | **`<leader>gl` のまま** | グループ | 規則3。git 系は控えが5本ある |

**副作用:**

- `tb` の衝突が消える（gitsigns vs bloocky）
- `gd` の衝突が消える（github-actions vs tiny-glimmer）
- `F` が空く
- **`<leader>D` は dooing 自身が Todo ウィンドウ内で重複削除に使っている。**
  そのウィンドウの中だけ食い違う
- **無効な openspec.nvim が `oa` `oh` `os` `ow` を持つ。** 有効化すると obsidian と衝突

2文字目の具体（`Gi` `Gp` など）は実装時に詰める。

### 3-2. B分類（パネルの開閉）11件 — **TBD**

`mm` `mf` minimap / `mp` `mt` markdown preview / `sc` scratch / `tt` tabterm /
`td` todo list / `tb` calendar / `ac` Claude / `v` Vallow / Triptych

### 3-3. C分類（プラグイン固有の内部モード）9件 — **TBD**

`Ct` `Ci` Cord / `ct` `nt` Crates / `ef` `eh` `ei` `er` Ecolog / `st` masking

### 3-4. 残りの prefix — **TBD**

`c` 22 / `z` 19 / `b` 14 / `n` 13 / `e` 13 / `s` 10 / `a` 10 / `p` 8 / `l` 8 /
`x` 4 / `v` 4 / `q` 4 / `k` 3 / `j` 3 / `i` 2 / `d` 3（`dt` `dc` が `u` へ抜けた後）

## 4. 検算 — **TBD**

割り当てが決まったら、下の4経路すべてで一覧を作り直し、規約から外れている
ものを洗う。

## 付録A. 判明している衝突（2026-08-23 時点）

| キー | 勝つ側 | 潰れる側 | 範囲 |
|---|---|---|---|
| `st` | Toggle masking (shelter) | **Squix: run SQL in TUI** | グローバル |
| `sS` | Select scratch buffer (snacks) | **Squix: connection status** | グローバル |
| `vs` | vi-sql: Open | **Vallow: switch** | グローバル |
| `tb` | gitsigns: blame トグル | Bloocky: toggle calendar | git 配下のバッファ |
| `md` | mq: Debug current file | Markdown render demo | `.mq` のみ |
| `gd` | github-actions: Dispatch workflow | tiny-glimmer | グローバル |

上3件は**どこからも押せない。** 下2件はバッファローカルが覆っているだけなので、
そのファイル種別の外では効く。

**潜在的な衝突**（今は無効なプラグインを有効化すると発生する）:

- wind.nvim の breath 名前空間 `<leader>b`（`bb` `bn` `bd` `bc`）→ buffer 群と衝突
- wind.nvim の window 名前空間 `<leader>w` → 現在唯一空いている小文字
- openspec.nvim の `x*` → trouble 群と衝突
- openspec.nvim の `o*`（`oa` `oh` `os` `ow`）→ **obsidian 群と衝突**（3-1 で `o` を割り当てたため）

## 付録B. 一覧の作り方（実行時ダンプだけでは足りない）

`nvim_get_keymap` を headless で叩くだけでは**取りこぼす**。この設計の途中で
2回、prefix の空き判定を外した。経路は4つある。

1. **グローバル** — `nvim_get_keymap` に出る。lazy.nvim の `keys` spec もここ
   （読み込み前はスタブとして登録される）
2. **バッファローカル** — LSP の `on_attach`、gitsigns の `on_attach`、
   `FileType` autocmd 内の `vim.keymap.set(..., { buffer = true })`。
   **グローバル一覧には一切出ない**（例: gitsigns の `<leader>h` 12件、
   mq.nvim の `<leader>m` 6件）
3. **which-key への直接登録** — `require("which-key").add({...})`。
   キーマップではなくラベルだけのこともある（例: `lua/config/picker.lua` の
   `<leader>F` = "Find"）
4. **文字列連結で組み立てる prefix** — `"<leader>" .. config.root_key` のような形。
   **ソースを `<leader>X` で grep しても出てこない**（例: surround-ui の `<leader>S`）

**空いていると判断する前に、4つとも見ること。**
