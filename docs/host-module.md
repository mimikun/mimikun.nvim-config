# config.host モジュール

ホスト名によるマシン別分岐を一箇所にまとめるためのヘルパーモジュール。
実体は `lua/config/host.lua`。

## 目的

マシンごとに設定を切り替えたいときに、ホスト名の取得・正規化（大文字小文字）を
呼び出し側で毎回書かずに済むようにする。

```lua
-- Before
local hostname = vim.uv.os_gethostname():lower()
if hostname == "azusa" then
  vim.g.clipboard = nil
end

-- After
if require("config.host").is("azusa") then
  vim.g.clipboard = nil
end
```

## API

| 名前 | 型 | 説明 |
| --- | --- | --- |
| `host.name` | `string` | 小文字化したホスト名。モジュールロード時に1回だけ解決してキャッシュ。 |
| `host.is(name)` | `fun(name: string): boolean` | 現在のホストが `name` と一致すれば `true`（大文字小文字を無視）。 |
| `host.any(names)` | `fun(names: string[]): boolean` | `names` のいずれかに一致すれば `true`（大文字小文字を無視）。 |

## 使い方

### 単一ホストの判定

```lua
local host = require("config.host")
if host.is("azusa") then
  vim.g.clipboard = nil
end
```

### 複数ホストの判定

```lua
local host = require("config.host")
if host.any({ "azusa", "corona" }) then
  vim.g.clipboard = nil
end
```

### lazy.nvim spec 内で使う

```lua
-- 特定ホストだけプラグインを無効化
return {
  "author/plugin.nvim",
  enabled = not require("config.host").is("azusa"),
}
```

## 注意点

- `azusa` マシンの実際のホスト名は `Azusa`（先頭大文字）。モジュールが両辺を
  小文字化して比較するため、**呼び出し側は常に小文字で名前を渡す**こと。
- `host.name` はロード時にキャッシュされるため、セッション中にホスト名が変わっても
  再評価されない（通常は問題にならない）。

## 実績

- `init.lua`: `azusa` のとき `vim.g.clipboard = nil` にして Neovim の
  クリップボード自動検出に任せる分岐で初採用。
