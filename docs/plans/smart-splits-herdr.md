# smart-splits.nvim（Herdr 連携）導入プラン

## Context

Herdr のペインと Neovim のウィンドウを同じキーで行き来したい。候補は2つあった:

1. `lmilojevicc/herdr-splits.nvim` — smart-splits に着想を得た Herdr 専用実装
2. `mrjones2014/smart-splits.nvim` — 複数の多重化ツールに対応。**2026-06-25 に herdr backend を追加**
   （PR #467、最終更新 2026-07-28 の `fix: avoid empty herdr executable`）

方針は「2 を使いたい。ただし 1 と機能差がないか確認したい」。
このファイルは調査結果と、その差分を埋める導入手順を持つ。**現状どちらも未導入**
（`~/.config/nvim` に該当スペックなし）。

調査時点: 2026-08-08。

## 調査結果

### 2 が勝っている点（1 に無い）

| 機能 | smart-splits | herdr-splits |
|---|---|---|
| `swap_buf_left/down/up/right` | ある | **無い** |
| `move_cursor_previous()` | ある | **無い** |
| tmux / zellij / wezterm / kitty | ある | 無い（Herdr 専用） |
| ログ機構（`log_level`、ファイル出力） | ある | 無い |
| `ignored_events`（BufEnter 等の抑制） | ある | 無い |
| mux 抽象 API（`require('smart-splits.mux').get()`） | ある | 無い |

### 1 が勝っている点（**ここが判断材料**）

1. **zoom 認識** — `smart-splits/mux/herdr.lua` の `current_pane_is_zoomed()` は
   **ハードコードで `false` を返す**。よって `disable_multiplexer_nav_when_zoomed`
   （既定 `true`）は Herdr では事実上効かない。herdr-splits は
   `herdr pane layout --current` で zoom を判定し、`herdr pane zoom --off --current`
   で**自動 unzoom** する（`unzoom_on_nav = true`）。
2. **Herdr 側のリサイズキー** — 両者の `herdr-plugin.toml` を比較:
   - smart-splits: `left` / `down` / `up` / `right` の**ナビ4つだけ**
   - herdr-splits: `nav-*` 4つ **＋ `resize-*` 4つ**

   つまり smart-splits では、**シェルのペインに居るとき** `<M-h>` 等でリサイズできない
   （Neovim 内から Herdr ペインをリサイズするのは `resize_pane` 実装済みなので動く）。
3. **リサイズ量の粒度** — herdr-splits は `default_amount = 0.03`（Herdr 側は**比率**）と
   `neovim_amount = 3`（Neovim 側は**セル数**）を分離。smart-splits は `default_amount = 3`
   の1つを両方へ渡す。Herdr ペインのリサイズ感がやや粗い可能性。
4. **Herdr 側スクリプトの自動同期** — herdr-splits は `sync.lua` が lazy 側の HEAD と
   `herdr plugin list --json` の `resolved_commit` を比較し、ズレていれば
   `herdr plugin install --ref <sha>` で追従する。smart-splits は `herdr plugin link` を
   手で1回やる方式なので、**プラグイン更新時に Herdr 側スクリプトが古いまま残りうる**。
5. **`jq` 依存** — smart-splits の Herdr 連携は `jq` を要求（README 明記）。
   herdr-splits は health.lua に jq チェック無し（Neovim 側で JSON をパース）。
6. **フロート窓の細かい制御** — herdr-splits は `floating_zindex_max` /
   `ignore_previewwindows` と、snacks/neo-tree/aerial の「埋め込みフロート」を
   サイドバー扱いにする分岐を持つ。smart-splits は `float_win_behavior`（`previous` 等）
   のみでやや粗い。

### 差ではなかったもの（README の印象と違う）

- **count プレフィックス（`3<C-h>`）**: smart-splits も `vim.v.count1` を読む。両方対応。
- **`at_edge` の custom function**: smart-splits も対応。`wrap` / `stop` / `split` / 関数。
- **`at_edge = 'split'`**: smart-splits の herdr backend は `split_pane` 実装済み。
- **サイドバー無視**: 既定リストの中身が違うだけ（smart-splits の既定は `NvimTree` のみ）。

## 結論と方針

**smart-splits を採用する。** 上の差分のうち実害があるのは 1（zoom）と 2（シェル側の
リサイズキー）だけで、どちらも設定側で埋められる。残りは些細か、既定値の調整で済む。

### 導入手順

1. `/add-plugin https://github.com/mrjones2014/smart-splits.nvim` で vendoring
   （`add/smart-splits-nvim` ブランチ、worktree で作業）。
2. スペックを書く。ポイントだけ:
   - `multiplexer_integration = 'herdr'`（`nil` の自動判定に頼らず明示する）
   - `ignored_filetypes` を既定の `{'NvimTree'}` から、実際に使っているサイドバー
     （neo-tree / snacks_* / aerial / dbout など）へ広げる。herdr-splits の既定リストを
     そのまま流用してよい
   - `at_edge = 'wrap'`、`default_amount = 3`
   - キーマップは `<C-h/j/k/l>` = nav、`<M-h/j/k/l>` = resize
3. `herdr plugin link <vendored path>` を実行し、`~/.config/herdr/config.toml` に
   `plugin_action` の `smart-splits.nvim.{left,down,up,right}` を4つ登録 →
   `herdr server reload-config`。
4. **差分2の埋め合わせ**: config.toml に Herdr **ネイティブ**のリサイズキーを
   `alt+h/j/k/l` で別途割り当てる（`plugin_action` ではなく herdr 標準のペインリサイズ）。
   これでシェルペインでも同じ打鍵でリサイズできる。
5. `jq` の有無を確認（`command -v jq`）。無ければ入れる。
6. `SMART_SPLITS_HERDR_PASSTHROUGH_RE` を設定（lazygit 等に `<C-h>` を通す）。
   例: `^(lazygit|k9s|btop)$`。

### 検証（`neowright` スキルを使う。headless は不可）

Neovim のウィンドウ移動・フロート窓が絡むので、`CLAUDE.md` の規定どおり `neowright` で
実機確認する。確認項目:

- Neovim 内 4 方向の nav と resize
- Neovim の端 → Herdr の隣接ペインへ抜ける（`<C-l>` 等）
- Herdr のシェルペイン → Neovim ペインへ戻る
- 端での `wrap` 挙動、`3<C-h>` の count
- neo-tree / snacks picker を開いた状態で nav が吸われないこと
- **差分1の実挙動**: ペインを zoom した状態で `<C-h>` を打ち、何が起きるか書き留める。
  `current_pane_is_zoomed()` が `false` 固定なので、smart-splits は zoom を無視して
  `herdr pane focus` を投げる。Herdr 側が unzoom するのか、zoom のまま focus が動くのか、
  無反応かは**実機で見るまで分からない**。ここだけは事前に断定できない。

### 外れたら分かる1行

**zoom した状態でのナビが実用に耐えなければ**（無反応 / zoom が残って画面が壊れる）、
smart-splits の `mux/herdr.lua` に `current_pane_is_zoomed` を実装して upstream へ PR、
または当面 `disable_multiplexer_nav_when_zoomed` を諦めて運用する。
**それでも herdr-splits へ乗り換える理由にはならない** — 上流に投げれば全員が直る。
