# エージェント型 SDLC と仕様駆動開発

エージェント型 SDLC 上で回す Kiro 方式の仕様駆動開発。

## プロジェクトの前提

### パス
- ステアリング: `.kiro/steering/`
- 仕様: `.kiro/specs/`

### ステアリングと仕様の違い

**ステアリング**（`.kiro/steering/`）— プロジェクト全体の規則と背景で AI を方向づける
**仕様**（`.kiro/specs/`）— 個々の機能について開発プロセスを形式化する

### 進行中の仕様
- 進行中の仕様は `.kiro/specs/` を見る
- 進捗確認には `/kiro-spec-status [feature-name]` を使う

## 開発ガイドライン
- 思考は英語、応答は日本語で生成する。プロジェクトのファイルへ書き出す Markdown
  （`requirements.md`、`design.md`、`tasks.md`、`research.md`、検証レポートなど）は、
  その仕様に設定された対象言語で書くこと（`spec.json` の `language` を参照）。

## 最小ワークフロー
- フェーズ0（任意）: `/kiro-steering`、`/kiro-steering-custom`
- ディスカバリ: `/kiro-discovery "idea"` — 進め方を判定し、複数仕様のプロジェクトなら
  `brief.md` と `roadmap.md` を書き出す
- フェーズ1（仕様策定）:
  - 単一仕様: `/kiro-spec-quick {feature} [--auto]`、または段階的に:
    - `/kiro-spec-init "description"`
    - `/kiro-spec-requirements {feature}`
    - `/kiro-validate-gap {feature}`（任意: 既存コードベース向け）
    - `/kiro-spec-design {feature} [-y]`
    - `/kiro-validate-design {feature}`（任意: 設計レビュー）
    - `/kiro-spec-tasks {feature} [-y]`
  - 複数仕様: `/kiro-spec-batch` — `roadmap.md` の全仕様を依存関係の波ごとに並列生成する
- フェーズ2（実装）: `/kiro-impl {feature} [tasks]`
  - タスク番号なし: 自律モード（タスクごとに subagent ＋ 独立レビュー ＋ 最終検証）
  - タスク番号あり: 手動モード（選んだタスクをメインコンテキストで実行。
    完了前にレビュアを通す点は同じ）
  - `/kiro-validate-impl {feature}`（単独で再検証する場合）
- 進捗確認: `/kiro-spec-status {feature}`（いつでも使ってよい）

## スキル構成
スキルは `.claude/skills/kiro-*/SKILL.md` に置かれている。
- 各スキルは `SKILL.md` を持つディレクトリ
- スキルは会話のコンテキストを参照しながらインラインで動く
- 効率のため、並列調査を subagent へ委譲することがある
- テンプレートや例などのファイルをスキルのディレクトリに追加してよい
- `kiro-review` — レビュアの subagent が使う、タスク単位の敵対的レビュー手順
- `kiro-debug` — デバッガの subagent が使う、根本原因を先に取る debug 手順
- `kiro-verify-completion` — 成功・完了を主張する前に、新しい証拠を要求するゲート
- **現在のタスクにスキルが該当する見込みが1%でもあるなら、呼び出すこと。**
  簡単そうに見えるという理由でスキルを飛ばさない。

## 開発規則
- 3段階の承認ワークフロー: 要件 → 設計 → タスク → 実装
- 各フェーズで人間のレビューが必要。`-y` は意図的に早送りする場合のみ使う
- ステアリングを最新に保ち、`/kiro-spec-status` で整合を確認する
- ユーザーの指示に正確に従い、その範囲内では自律的に動くこと。必要な背景を自分で集め、
  依頼された作業をこの実行の中で最後までやり切る。質問するのは、不可欠な情報が
  欠けているか、指示が決定的に曖昧なときに限る。

## 動作確認の使い分け

- **「読み込めるか」= headless。**
  `nvim --headless "+Lazy! install <repo>" "+Lazy! load <repo>" +qa` は
  spec が壊れていないことの確認まで。`add-plugin` スキルが指定しているのもここまで。
- **「動くか」= `neowright` スキル。** UI 描画・キーマップ・タブライン・フロート窓・
  補完メニューが絡む確認で headless を使わない。

**理由**: headless は偽の失敗を出す。2026-08-02 の `nvim-cokeline` 導入時に2つ踏んだ。

- `nvim_replace_termcodes` は `<leader>` を展開しないので、`feedkeys` で
  マッピングに当たらない
- 描画時に更新されるプラグイン内部の状態（cokeline の可視バッファ一覧など）が
  headless では構築されず、正常な機能が動かないように見える

どちらもプラグインではなく検証環境の問題で、切り分けに往復を3回使った。
neowright に切り替えたら1回で通った。**速いと思った手段のほうが遅かった。**

同じ family の落とし穴がもう1つある。**headless nvim で `require` を先回りすると、
lazy の `config` 実行が "loop or previous error" で失敗する。**
master でも同じ結果になるので、**この症状を自分の変更のせいだと誤認しないこと**
（2026-07 の selene 対応で stash して比較確認済み）。

## ステアリングの設定
- `.kiro/steering/` 全体をプロジェクトメモリとして読み込む
- 既定のファイル: `product.md`、`tech.md`、`structure.md`
- カスタムファイルにも対応（`/kiro-steering-custom` で管理する）

## このリポジトリの道具

**どれもスクリプトが本体。ここにあるのは「存在すること」と「いつ使うか」だけ。**

| 道具 | 何をするか | いつ |
|---|---|---|
| `scripts/nvim-plugin-clone.sh` | プラグイン追加。`add/<plugin>` ブランチを作る | `/add-plugin`、または `task plugin-setup -- <git-url>` |
| `scripts/nvim-worktree.sh` | worktree + データ種まき + `.envrc` 生成 | `/nvim-worktree add <branch>` |
| `task ck` (`scripts/check-keys-spec.*`) | `keys.lua` の構造リンタ | keys.lua を触ったあと |
| `task cos` (`scripts/check-options-sync.*`) | nvim のオプション集合と `options.lua` の突き合わせ | **nvim をアップグレードしたあと** |

- `nvim-plugin-clone.sh` は `~/.config/nvim/lua/plugins` を**ハードコードしている**。
  worktree の中で使うときは `NVIM_PLUGINS_DIR` を明示する
- テンプレートは `~/NVIM_PLUGIN_TEMPLATES`（**別リポジトリ**）。
  ここを直さないと、生成されるファイルに同じ間違いが増え続ける
- **設定変更のコミットはユーザー自身が行う。** Claude は push しない

### worktree で並行編集するとき

`NVIM_APPNAME` で分離する（このリポジトリのランタイムは全て `vim.fn.stdpath()` ベース
なので効く）。`~/.config/nvim-<name>` に置き、`.envrc` + direnv で自動切替。

- **`mason` だけは symlink 共有**（12GB あるため）。
  **worktree 内で `:Mason` アンインストールすると本体側に波及する**
- `lazy` と `site`（treesitter パーサ）は実コピーで分離

## 規約

- **`keys.lua` の `desc` / `silent` / `noremap` はフラットに書く。**
  余分なテーブルリテラルに入れ子にすると lazy.nvim の `LazyKeysSpec` が**黙って無視する**
  （`maparg` で `desc=nil silent=false` になる）。`task ck` がこれを検出する
- **`options.lua` の分類ルール**: bool / number / 非空かつ非パスの string は設定を書く。
  空文字・パス・実行時読取専用（`columns` 等）・巨大なバージョン依存文字列（`statusline` 等）・
  非推奨の Vi 互換はコメントのまま残す
- **`formatters/` は conform 組み込み定義のベンダリング。触らない**

## ハマりどころ（コードを読んでも分からないもの）

- **selene のインライン `-- selene: allow(rule)` は、直後の1要素にしか効かない。**
  テーブル全体に効かせるには `local foo = {` の手前に置く
- **`\u{XXXX}` は LuaJIT / Neovim で正常に動く。** selene が警告するのは
  lua51 base が知らないだけで、コード側の修正は不要（インライン allow が正解）
- **`luajit -b` / `-bl` はこの環境で使えない**（jit モジュール未同梱）。
  構文チェックは `luajit -e 'loadfile(path)'`

## 生きている方針（未実行）

- **typos は conform から外してある。** `["*"] + --write-changes` で全ファイルに
  かけていたため、標準辞書の `edn -> end` 補正が Clojure の EDN を保存時に壊していた
- **nvim-lint 導入時に、typos を「検知のみ」で登録し直す**（修正はしない）。
  その際 `[default.extend-words] edn = "edn"` の許可リストを `--config` で渡す。
  プロジェクトローカルの `_typos.toml` とは**マージ**される（上書きではない・実測確認済み）
