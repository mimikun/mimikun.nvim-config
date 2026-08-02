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

## ステアリングの設定
- `.kiro/steering/` 全体をプロジェクトメモリとして読み込む
- 既定のファイル: `product.md`、`tech.md`、`structure.md`
- カスタムファイルにも対応（`/kiro-steering-custom` で管理する）
