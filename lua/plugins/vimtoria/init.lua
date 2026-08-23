---@type LazySpec
local spec = {
  "miraihack/Vimtoria",
  --lazy = false,
  cmd = require("plugins.vimtoria.cmds"),
  event = require("plugins.vimtoria.events"),
  config = function()
    -- 表示言語
    -- ja: 日本語
    -- en: 英語
    ---@type string | "ja" | "en"
    vim.g.vimtoria_lang = "ja"

    -- 設定すると起動時の国選択画面を飛ばしてこの国で始める(3文字の国タグ)
    --vim.g.vimtoria_player_country = "GBR"

    -- 0 にすると地図上の各国概況ポップアップを初期状態で隠す(v切替)
    ---@type number | 1 | 0
    vim.g.vimtoria_popup = 1

    -- セーブファイルのパス
    ---@type string
    vim.g.vimtoria_save_file = "~/.vimtoria_save.json"

    -- 1 にするとランダムイベントの自動発生を止める
    ---@type number | 0 | 1
    vim.g.vimtoria_disable_events = 0

    -- 1 にすると歴史イベントを止める(鎖国は解かれなくなる)
    ---@type number | 0 | 1
    vim.g.vimtoria_disable_history = 0
  end,
  --cond = false,
  --enabled = false,
}

return spec
