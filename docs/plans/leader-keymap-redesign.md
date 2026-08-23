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
5. **グループの親に単独マッピングを置かない。** ラベルが目的なら which-key の `spec`
   に書く。lazy.nvim の `keys` spec に `rhs` なしのエントリを置いて代用しない —
   **マッピングとしては登録されるので、押すたびに `timeoutlen` を払って何も起きない**

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

### 3-2. B分類（パネルの開閉）11件 — 完了（2026-08-23 決定）

4件は 3-1 で行き先が決まっている（`tt`→`T` / `td`→`D` / `tb`→`K` / `mm` `mf`→`M`）。
`mp` `mt` は `m`（markdown）配下、`ac` は `a`（ai）配下のままで規則に合う。残り3件:

| 対象 | 決定 | 導出 |
|---|---|---|
| snacks scratch `sc` `sS` | **`bs` `bS`**（buffer 配下） | **scratch buffer はバッファ**。`s` にいたのは squix と場所を取り合っていただけで意味的な理由が無い |
| SQL 系10件（squix 8 + vi-sql 2） | **`<leader>Q`** に統合 | 同じ対象。`v` は vallow 専用になる |
| ファイラ2つ（Fyler `e` / Triptych `-`） | **両方 `enabled = false`** | **どちらも使っていない**（本人確認）。§2 どおり、使っていないものに prefix を確保しない |

**SQL 統合で、判明していた到達不能3件が全部消える。**

| 衝突 | 消える理由 |
|---|---|
| `st`（masking が squix を潰す） | squix が `Q` へ退去 |
| `sS`（scratch が squix を潰す） | 同上 |
| `vs`（vi-sql が vallow を潰す） | vi-sql が `Q` へ退去 |

`gd` と `tb` は 3-1 で解消済みなので、**付録A の5件は全て片付く。**

**副作用:**

- Fyler を無効化すると `<leader>e` の単独マッピングが消え、**Ecolog 13件の
  `timeoutlen` 待ちが無くなる**（単独キーが13件の親を兼ねていた）
- `<leader>-` が空く
- Triptych はウィンドウ内で `<leader>cd` `<leader>.` も使っていたが、無効化で消える

### 3-3. C分類（プラグイン固有の内部モード）9件 — 完了（2026-08-23 決定）

| キー | 決定 | 導出 |
|---|---|---|
| `Ct` `Ci` Cord | **そのまま**（`C`） | 対象別で既に正しい |
| `ef` `eh` `ei` `er` Ecolog | **そのまま**（`e`） | 同上。Fyler が抜けて `e` は Ecolog 専用になる |
| `ct` Crates | **そのまま**（`c`） | 3-4 で `c` = crates に整理する |
| `st` masking（shelter.nvim） | **`es`**（Ecolog 配下） | **shelter は Ecolog の masking 機能。** 別プラグインだが対象は Ecolog |
| `nt` | **crates ではない** | package-info.nvim（npm）。3-4 で扱う |

`s` に残るのは `sr`（Rename file）と `sz`（Chezmoi source files）の2件になる。

### 3-4. 残りの prefix

#### `c` = crates（2026-08-23 決定。2件だけ保留）

`c` には7プラグインが同居していて、**新たに衝突が3件見つかった。**

| キー | 効くもの | 潰れているもの |
|---|---|---|
| `cd` | Convert to decimal（convy） | crates.nvim の `cd` |
| `cf` | Crates: show features | chezmoi.nvim の `cf` |
| `cs` | Symbols（Trouble） | convy の `cs` |

crates が最大勢力（14件）なので **`c` = crates** とし、他を退去させる。

| 退去するもの | 行き先 | 導出 |
|---|---|---|
| trouble `cl` `cs` | **`x` 配下**（`xl` `xs`） | **Trouble は既に `x` に4件持っている。** 同じプラグインが2箇所に分かれていた |
| calendar-vim `cal` `caL` | **`K` 配下** | 3-1 で bloocky カレンダーを `K` にした。カレンダーという対象で統合 |
| chezmoi.nvim `cf` `cfn` | **`sz` と統合** | 同じ対象が `c` と `s` に分かれていた |
| codediff 8件 | **そのまま** | diff ビュー内のみ。グローバルには出ない |
| nvim-html-css `cp` | — | **登録されていない**。要調査 |
| convy `cc` `cd` `cs` | **保留**（2026-08-23 時点） | 「変換」に同居先が無い。大文字1つが要る |
| calcium `<leader>c` 単独 | **保留**（2026-08-23 時点） | 電卓。1件・控えなし → 大文字1打 |

**この整理で `cd` `cf` `cs` の3件が全部消える**（convy と chezmoi が退去し、Trouble が `x` へ移るため）。

#### `n` = package-info（2026-08-23 決定）

package-info.nvim 7件（`nc` `nd` `ni` `np` `ns` `nt` `nu`）と
neovim-tips 6件（`nto` `ntb` `nte` `nta` `ntp` `ntr`）が同居していた。
**`nt` が親子で衝突**（package-info の `nt` = Toggle dependency versions が、
neovim-tips の `nt*` の親として扱われ、`timeoutlen` 待ちの後にしか発火しない）。
**両方とも有効**であることを確認済み。

- **`n` = package-info**（npm）。7件はそのまま。`nt` の待ちが消える
- **neovim-tips は `<leader>N`**（未使用）。6件でグループが要る
- `c` = cargo / `n` = npm で**エコシステム別に揃う**

#### `p` = yank / paste（2026-08-23 決定。2件保留）

4つの対象が同居していた。**`<leader>p` は yank の paste で決め打ち**（本人）。

| 出所 | キー | 状態 |
|---|---|---|
| yankbank | `bind_indices` → **`p1`〜`p9`** | インデックス貼り付け |
| yanky.nvim | `p`（Open Yank History、n/x） | **潰れている** |
| ports.nvim | `p` 単独 | 勝っている |
| pomodoro.nvim | `ps` `pr` `pS` `pw` `px` ＋ `pp` | **`pp` が潰れている** |
| peeper-picker.nvim | `pp` `ph` | `pp` を勝ち取っている |
| dooing | `p`（Todo スクラッチパッド） | dooing ウィンドウ内のみ |

**`p1`〜`p9` の存在で `<leader>p` が数字の親になり、ports の単独キーは
毎回 `timeoutlen` を待ってから発火していた**（`b` `e` `l` と同じ形）。

| 対象 | 決定 |
|---|---|
| yank / paste | **`p` を維持**。yankbank の `p1`〜`p9` ＋ yanky の履歴 |
| peeper-picker 2件 | **`t`（find）配下**。README で確認 — カーソル下のシンボルの出現箇所を、LSP の定義・参照に加えて文字列・コメント・生成物からも拾って1リストにする。**§1 の find の定義にそのまま当たる** |
| pomodoro 6件 | **保留**（2026-08-23 時点）。退去は確定、文字が未定 |
| ports.nvim 1件 | **保留**（同上）。ローカルの listening ポート一覧と kill / open / tail |

**`pp` の衝突は peeper が `t` へ抜けることで消える。**

#### `a` = ai（2026-08-23 決定）

claudecode 10件と codex 3件が第2キーを取り合っていた。

| キー | claudecode | codex | aerial |
|---|---|---|---|
| `a` 単独 | AI/Claude Code | — | **Aerial: toggle outline（潰れている）** |
| `ab` | Add current buffer（**潰れている**） | Add current buffer to Codex | — |
| `as` | Send to Claude / Add file（**同一ファイル内で2回定義**） | （codex の `as`） | — |

- **`a` = ai を維持。** claudecode と codex は対象が同じ（AI エージェント）
- **第2キーはツール別に分ける。** 同じ操作（buffer 追加、送信）が両方にあるので、
  **操作で分けると必ず衝突する。** ツールで先に分ければ構造的に解決し、
  `add/avante-nvim` `add/codecompanion-nvim` `add/copilotchat-nvim`
  `add/sidekick-nvim` `add/nvim-aibo` が控えているので**実際に効いてくる**
- **aerial は退去。** アウトラインは AI と無関係。1件・控えなし → 大文字1打（保留）
- **`as` の重複定義は設計とは別のバグ。** claudecode の `keys.lua` が同じキーを
  46行目（Send to Claude）と55行目（Add file）で2回定義している

#### `k` = hover（2026-08-23 決定）

作業の最初に保留にした prefix。**規則が揃ったので導出できるようになった。**

- hover.nvim は `K` と `gK` も持つ。`<leader>k` はその仲間として筋が通る
- codedocs は1件・控えなし → **大文字1打**（保留）。`k` に残すとラベルと食い違う
- 当初検討した「hover を `<leader>h` へ」は**成立しない**。`h` は gitsigns の
  hunk 12件（バッファローカル）が使っている

#### `l` = leap（2026-08-23 決定）

leap 7件に、nvim-hlslens の `<leader>l`（Clear search highlight）が単独キーとして
乗っている。**leap の親を兼ねているので、押すたびに `timeoutlen` 待ちが入る**
（`b` `e` `p` と同じ形）。

- **`l` = leap。** hlslens は1件・控えなし → 大文字1打（保留）

#### そのまま（確認済み・触る必要なし）

| prefix | オーナー | 件数 |
|---|---|---|
| `z` | telekasten 単独 | 19 |
| `x` | trouble 単独 | 4（＋ `c` から `cl` `cs` が合流） |
| `j` | mini.jump2d 単独 | 3 |
| `d` | tiny-inline-diagnostic 単独 | 3（`dt` `dc` が `u` へ抜けた後） |
| `b` | cokeline ＋ snacks | 6（octo が `G` へ、scratch が合流） |
| `e` | ecolog 単独 | 12（Fyler 無効化、shelter が `es` で合流） |
| `q` | persistence 単独 | 4（octo の `qa` が抜けた後） |
| `i` | img-clip `ip` ＋ lazyissues `i` | 2。**`i` 単独が `ip` の親を兼ねている**が、2件なので影響は小さい |

#### 大文字待ちの列 — **TBD**

退去は確定しているが、文字が未定のもの。

| 対象 | 件数 | 内容 |
|---|---|---|
| convy | 3 | 変換（`cc` `cd` `cs`） |
| calcium | 1 | 電卓 |
| pomodoro | 6 | ポモドーロ |
| ports.nvim | 1 | listening ポート一覧 |
| aerial | 1 | アウトライン切り替え |
| codedocs | 1 | アノテーション挿入 |
| nvim-hlslens | 1 | 検索ハイライト消去 |

空いている大文字: `A E H I J O U V W X Y Z`
（使用済み: `B` brew / `C` cord / `D` dooing / `F`→廃止 / `G` github / `K` calendar /
`L` lint / `M` minimap / `N` neovim-tips / `P` template / `Q` sql / `R` translate /
`S` surround-ui / `T` tabterm）

## 4. 検算（2026-08-23 実施）

### 手順

付録B の4経路を突き合わせる。`nvim_get_keymap` の実行時ダンプだけでは足りない。

1. **実行時ダンプ** — headless で全モードの `nvim_get_keymap` を取る。
   グローバルに登録されているものが出る
2. **設定ソースの走査** — `lua/` 全体を `"<leader>..."` で拾い、
   プラグインごとに集計する。**バッファローカルも無効なプラグインも拾える**
3. **which-key のラベル登録を除外する** — `which-key-nvim/opts.lua` の `spec` と
   `config/picker.lua` の `which-key.add()` は**マッピングではない**。
   除外しないと衝突として誤検出する（実際に誤検出した）
4. **組み立て型の prefix を個別に確認する** — `"<leader>" .. root_key` の形は
   grep に出ない

その上で3つを出す — ①同じキーを複数プラグインが定義、②prefix 自体が実マッピング、
③1プラグインが複数の prefix にまたがる。

### 結果 — 衝突はグローバル11件、うち10件が設計で解決済み

| 衝突 | 解決する決定 |
|---|---|
| `a`（aerial / claudecode / octo） | aerial 退去、octo → `G` |
| `ab` `as`（claudecode / codex） | ツール別に第2キーを分割 |
| `cd`（convy / crates / triptych） | convy 退去、triptych 無効化 |
| `cs`（convy / trouble） | 両方退去（trouble → `x`） |
| `gd` | tiny-glimmer → `u` |
| `pp` | peeper → `t`（find） |
| `sS` `st` | squix → `Q`、shelter → `es` |
| `tb` | bloocky → `K` |
| `vs` | vi-sql → `Q` |
| `p`（dooing / ports / yankbank / yanky） | **部分解決。** ports の文字が未定 |

ビュー内限定の衝突（codediff の `b` `cX` `ct` `cx` `hr` `hs`、mq の `md`）は、
そのウィンドウの外では効くので設計対象外。

### 結果 — 設計に無かった論点が1つ出た

**グループの親に単独マッピングが乗っているものが10件。** うち3件は `rhs` を持たない。

| キー | 正体 |
|---|---|
| `<leader>a`（claudecode） | `rhs` なし。desc = "AI/Claude Code" |
| `<leader>u`（snacks） | `rhs` なし。desc = "UI toggles" |
| `<leader>B`（brewfile） | `rhs` なし。desc = "Brewfile" |

**which-key のグループラベルを lazy.nvim の `keys` spec で代用したもの。**
今日 `spec` に書いたラベルと同じ役目を別の仕組みで二重にやっており、しかも
**マッピングとしては登録されるので `timeoutlen` 待ちが発生して何も起きない。**

→ 共通規則5 として明文化した。

## 5. 実装リスト

設計が決まった分。**上から順に、1コミット1論理単位で入れる。**

### 5-1. 削除するだけで効くもの（機能を失わない）

- [ ] `<leader>a`（claudecode）の `rhs` なしエントリを削除。ラベルは `spec` 側が持つ
- [ ] `<leader>u`（snacks）の同上
- [ ] `<leader>B`（brewfile）の同上。遅延ロードは子キーが引く

### 5-2. 無効化

- [ ] Fyler.nvim を `enabled = false`（`<leader>e` の待ちが消える）
- [ ] Triptych を `enabled = false`（`<leader>-` `<leader>cd` `<leader>.` が空く）

### 5-3. prefix の移動

- [ ] find: `F` → `t`（12件）。`t` の現住民は先に退去させる
- [ ] tabterm → `T` / dooing → `D` / translate → `R` / bloocky → `K` / template → `P`
- [ ] obsidian-tasks → `o`、octo ＋ github-actions ＋ `gB` → `G`
- [ ] squix ＋ vi-sql → `Q`、shelter → `es`
- [ ] neovim-tips → `N`
- [ ] trouble の `cl` `cs` → `x` 配下、calendar-vim → `K` 配下、chezmoi → `sz` と統合
- [ ] snacks scratch → `bs` `bS`
- [ ] peeper-picker → `t` 配下
- [ ] A分類のトグルを `u` へ（gitsigns `tb` `tw` / tiny-glimmer 3件 / blink-indent `ti`）
- [ ] claudecode と codex の第2キーをツール別に分ける

### 5-4. 設計とは別のバグ

- [ ] claudecode の `keys.lua` が `<leader>as` を2回定義している（46行目 / 55行目）
- [ ] nvim-html-css の `cp` が登録されていない。要調査

### 5-5. 保留が解けてから

- [ ] 大文字待ちの列7件（convy / calcium / pomodoro / ports / aerial / codedocs / hlslens）

## 付録A. 判明している衝突（2026-08-23 時点）

| キー | 勝つ側 | 潰れる側 | 範囲 |
|---|---|---|---|
| `st` | Toggle masking (shelter) | **Squix: run SQL in TUI** | グローバル |
| `sS` | Select scratch buffer (snacks) | **Squix: connection status** | グローバル |
| `vs` | vi-sql: Open | **Vallow: switch** | グローバル |
| `tb` | gitsigns: blame トグル | Bloocky: toggle calendar | git 配下のバッファ |
| `md` | mq: Debug current file | Markdown render demo | `.mq` のみ |
| `gd` | github-actions: Dispatch workflow | tiny-glimmer | グローバル |
| `cd` | convy: Convert to decimal | crates.nvim | グローバル |
| `cf` | crates: show features | chezmoi.nvim | グローバル |
| `cs` | Trouble: Symbols | convy | グローバル |

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
