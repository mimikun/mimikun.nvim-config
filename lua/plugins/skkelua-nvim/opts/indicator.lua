--	モードインジケータの設定。|skkelua-indicator| 参照。
---@type skkelua.IndicatorOptions
local indicator = {
  -- false で無効化
  ---@type boolean
  enabled = true,

  ---@type string
  eijiText = "英字",

  -- 表示テキストのカスタマイズ
  ---@type string
  hiraText = "ひら",

  ---@type string
  kataText = "カタ",

  ---@type string
  hankataText = "半ｶﾀ",

  ---@type string
  zenkakuText = "全英",

  ---@type string
  abbrevText = "abbr",

  ---@type string
  eijiHlName = "SkkeluaIndicatorEiji",

  ---@type string
  hiraHlName = "SkkeluaIndicatorHira",

  ---@type string
  kataHlName = "SkkeluaIndicatorKata",

  ---@type string
  hankataHlName = "SkkeluaIndicatorHankata",

  ---@type string
  zenkakuHlName = "SkkeluaIndicatorZenkaku",

  ---@type string
  abbrevHlName = "SkkeluaIndicatorAbbrev",

  -- 枠線 (nvim_open_win の border)
  ---@type string | string[] | fun(args: { mode: string }): any
  border = nil,

  -- nil なら border に応じて自動 (border なし: 1 / あり: 0)
  ---@type integer
  row = nil,

  ---@type integer
  col = 1,

  ---@type integer
  zindex = nil,

  -- skkelua が有効な間だけ表示
  ---@type boolean | false
  alwaysShown = true,

  -- 0 で自動フェードアウトなし
  ---@type integer
  fadeOutMs = 3000,

  ---@type string[]
  ignoreFt = {},

  ---@field bufFilter? fun(buf: integer): boolean
  bufFilter = nil,

  ---@field useDefaultHighlight boolean
  useDefaultHighlight = true,
}

return indicator
