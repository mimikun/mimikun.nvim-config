local user_dictionary = vim.fs.joinpath(vim.fn.stdpath("data"), "skkelua", "jisyo")

---@type skkelua.ConfigOptions
local opts = {
  -- かなに変換できなかった入力をそのまま残すかどうか。
  ---@type boolean | false
  acceptIllegalResult = false,

  -- 変換候補の builtin LSP 補完。|skkelua-completion| 参照。
  ---@type skkelua.CompletionOptions
  completion = require("plugins.skkelua-nvim.opts.completion"),

  -- 補完候補ランクの保存先ファイル。
  completionRankFile = "",
  databasePath = "",

  -- デバッグログを出力します。
  ---@type boolean | false
  debug = false,

  -- 変換中の <CR> で確定のみ行い改行しないかどうか。
  ---@type boolean | false
  eggLikeNewline = true,

  -- グローバル辞書のリスト。要素はパス文字列、または
  -- {パス, エンコーディング} のペア。エンコーディング省略時は自動判定。
  -- normalize 後は [string, string][]
  ---@type (string | [string, string])[]
  globalDictionaries = {
    -- エンコーディング自動判定
    "~/.skk/SKK-JISYO.L",

    -- 明示指定
    {
      "~/.skk/SKK-JISYO.geo",
      "euc-jp",
    },
  },

  --	かなテーブルファイルのリスト。
  ---@type (string | [string, string])[]
  globalKanaTableFiles = {},

  --	キャンセル時に一気に未入力状態へ戻るかどうか。
  ---@type boolean | false
  immediatelyCancel = true,

  --	ユーザー辞書を変換のたびに読み書きするかどうか。
  ---@type boolean | false
  immediatelyDictionaryRW = true,

  --	送り仮名が「っ」の段階で即変換するかどうか。
  ---@type boolean | false
  immediatelyOkuriConvert = true,

  --	モードインジケータの設定。|skkelua-indicator| 参照。
  ---@type skkelua.IndicatorOptions
  indicator = require("plugins.skkelua-nvim.opts.indicator"),

  --	使用するかなテーブル名。
  kanaTable = "rom",

  --	無効化しても入力モードを保持するかどうか。
  ---@type boolean | false
  keepMode = false,

  --	insert モードを抜けても skkelua の状態を保持するかどうか。
  ---@type boolean | false
  keepState = false,

  --	大文字入力時の変換先カスタマイズ。
  ---@type table<string, string>
  lowercaseMap = {},

  --[[
--デフォルトから増減させる例:
local keys = vim.tbl_filter(function(k)
	return k ~= "<C-g>" and k ~= "<C-j>"
end, require("skkelua").get_default_mapped_keys())
vim.list_extend(keys, { "<C-p>", "<C-n>" })
require("skkelua").config({ mappedKeys = keys })
]]
  -- 有効化時にバッファローカルにマップするキーのリスト。
  -- nil なら get_default_mapped_keys() の結果を使います。
  ---@type string[]?
  mappedKeys = nil,

  -- 変換入力中のマーカー。
  markerHenkan = "▽",

  -- 候補選択中のマーカー。
  markerHenkanSelect = "▼",

  -- カタカナ変換等の結果をユーザー辞書に登録するかどうか。
  ---@type boolean | false
  registerConvertResult = true,

  --	候補選択ポップアップのキー (7 文字)。
  selectCandidateKeys = "asdfjkl",

  --	変換ポイントで undo を切るかどうか。
  setUndoPoint = true,

  --	インライン候補表示の個数。超えるとポップアップ表示になります。
  showCandidatesCount = 4,

  -- skkserv の接続設定。
  skkServerHost = "127.0.0.1",
  skkServerPort = 1178,
  skkServerReqEnc = "euc-jp",
  skkServerResEnc = "euc-jp",

  -- 辞書ソースのリスト。|skkelua-sources| 参照。
  sources = {
    "skk_dictionary",
  },

  -- ユーザー辞書のパス。
  userDictionary = user_dictionary,
}

return opts
