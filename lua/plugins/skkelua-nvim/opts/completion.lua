-- 変換候補の builtin LSP 補完。|skkelua-completion| 参照。
---@type skkelua.CompletionOptions
local completion = {
  --  変換候補を builtin LSP 補完として表示するかどうか
  ---@type boolean | false
  enabled = true,

  -- 候補の選択 (フォーカス) と同時に本文へ挿入するかどうか
  -- 候補にフォーカスした時点で本文へ挿入する
  ---@type boolean | false
  insertOnSelect = true,

  -- 送り仮名確定でも自動変換せず、第一候補を自動選択する
  -- 送り仮名確定時に自動変換せず、補完メニューでの選択に委ねるかどうか
  ---@type boolean | false
  deferOkuri = true,
}

return completion
