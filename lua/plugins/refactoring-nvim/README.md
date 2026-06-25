## Installation

```lua
{
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "lewis6991/async.nvim",
  },
  lazy = false,
},
```

</details>

## Configuration

The default configuration can be found at [./lua/refactoring/config.lua](./lua/refactoring/config.lua), any field can be overridden:

- globally: `require("refactoring").setup({...})`
- for a single call: `require("refactoring").inline_var({...})`
- for a given buffer: `vim.b.refactor_config = {...}`

### Keymaps

No keymaps are created by default. These are the suggested keymaps:

<details>
<summary>Option 1: a dedicated keymap for each refactoring operation</summary>

```lua
local keymap = vim.keymap

keymap.set({ "n", "x" }, "<leader>re", function()
  return require("refactoring").extract_func()
end, { desc = "Extract Function", expr = true })
-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>ree", function()
  return require("refactoring").extract_func() .. "_"
end, { desc = "Extract Function (line)", expr = true })

keymap.set({ "n", "x" }, "<leader>rE", function()
  return require("refactoring").extract_func_to_file()
end, { desc = "Extract Function To File", expr = true })

keymap.set({ "n", "x" }, "<leader>rv", function()
  return require("refactoring").extract_var()
end, { desc = "Extract Variable", expr = true })

-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>rvv", function()
  return require("refactoring").extract_var() .. "_"
end, { desc = "Extract Variable (line)", expr = true })

keymap.set({ "n", "x" }, "<leader>ri", function()
  return require("refactoring").inline_var()
end, { desc = "Inline Variable", expr = true })
keymap.set({ "n", "x" }, "<leader>rI", function()
  return require("refactoring").inline_func()
end, { desc = "Inline function", expr = true })

keymap.set({ "n", "x" }, "<leader>rs", function()
  return require("refactoring").select_refactor()
end, { desc = "Select refactor" })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
keymap.set( "n" , "<leader>pv", function()
  return require("refactoring.debug").print_var { output_location = "below" } .. "iw"
end, { desc = "Debug print var below", expr = true })
keymap.set( "x" , "<leader>pv", function()
  return require("refactoring.debug").print_var { output_location = "below" }
end, { desc = "Debug print var below", expr = true })

-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
keymap.set( "n" , "<leader>pV", function()
  return require("refactoring.debug").print_var { output_location = "above" } .. "iw"
end, { desc = "Debug print var above", expr = true })
keymap.set( "x", "<leader>pV", function()
  return require("refactoring.debug").print_var { output_location = "above" }
end, { desc = "Debug print var above", expr = true })

keymap.set({ "x", "n" }, "<leader>pe", function()
  return require("refactoring.debug").print_exp { output_location = "below" }
end, { desc = "Debug print exp below", expr = true })
-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>pee", function()
  return require("refactoring.debug").print_exp { output_location = "below" } .. "_"
end, { desc = "Debug print exp below", expr = true })

keymap.set({ "x", "n" }, "<leader>pE", function()
  return require("refactoring.debug").print_exp { output_location = "above" }
end, { desc = "Debug print exp above", expr = true })
-- `_` is the default textobject for "current line"
keymap.set("n", "<leader>pEE", function()
  return require("refactoring.debug").print_exp { output_location = "above" } .. "_"
end, { desc = "Debug print exp above", expr = true })

keymap.set("n", "<leader>pP", function()
  return require("refactoring.debug").print_loc { output_location = "above" }
end, { desc = "Debug print location", expr = true })
keymap.set("n", "<leader>pp", function()
  return require("refactoring.debug").print_loc { output_location = "below" }
end, { desc = "Debug print location", expr = true })

keymap.set({ "x", "n" }, "<leader>pc", function()
  -- `ag` is a custom textobject that selects the whole buffer. It's provided by plugins like `mini.ai` (requires manual configuration using `MiniExtra.gen_ai_spec.buffer()`).
  -- return require("refactoring.debug").cleanup { restore_view = true } .. "ag"

  -- this keymap doesn't select any textobject by default, so you need to provide one each time you use it.
  return require("refactoring.debug").cleanup { restore_view = true }
end, { desc = "Debug print clean", expr = true, remap = true })
```

</details>

<details>
<summary>Option 2: single keymap to select refactor</summary>

```lua
local keymap = vim.keymap

keymap.set({ "n", "x" }, "<leader>rs", function()
  -- this keymap doesn't select any textobject by default, so you may need to provide one each time you use it.
  require("refactoring").select_refactor()
end, { desc = "Select refactor" })
```

</details>

### User commands

The `:Refactor` command can be used to run any refactor. It supports previewing changes and offers completions for available refactors. For refactors that require additional input, extra arguments to the `:Refactor` command will be used as input.

## Supported languages

- C
- C#
- C++
- Go
- Java
- JavaScript/Typescript/Jsx/Tsx
- Lua
- Php
- Powershell
- Python
- Ruby
- Vimscript

## Adding/improving support for a language

To add/improve support for a language, first do it on your local config and daily drive it for a while. To do so:

1. Create the required tree-sitter queries for the language in your config directory (`~/.config/nvim/queries/<lang>/<query_name>.scm`). You can find the name of the queries required for each feature in [Features](#features) and the structure of the queries in `./queries/`. The query files should start with `;; extends` (see `:h treesitter-query-modeline-extends`).
2. Add code generation functions required by the feature to your global config. You can see the code generation functions required by each feature in `./lua/refactoring/config.lua`
3. After daily driving your changes for a while, open a PR to the `refactoring.nvim` repo.

> [!NOTE]
> The goal of the plugin is to keep the Lua logic as generic and language agnostic as possible. That's why all of the input language specific information comes from LSP servers and tree-sitter queries. The better the tree-sitter queries are, the better the support for a given language will be.
