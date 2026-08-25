# 📦 Extras

`markview.nvim` comes with a few *extra* QOL modules to make certain tasks easier.

You can find these in the [lua/markview/extras/](https://github.com/OXY2DEV/markview.nvim/tree/main/lua/markview/extras) directory.

---

## 📦 Checkbox toggle

Allows toggling/changing `checkboxes` in the current line or the selected range of lines.

An interactive mode is also provided if you want to visually change the state.

Features,

### 📚 Usage

Load the module first,

```lua
require("markview.extras.checkboxes").setup({
    --- Default checkbox state(used when adding checkboxes).
    ---@type string
    default = "X",

    --- Changes how checkboxes are removed.
    ---@type
    ---| "disable" Disables the checkbox.
    ---| "checkbox" Removes the checkbox.
    ---| "list_item" Removes the list item markers too.
    remove_style = "disable",

    --- Various checkbox states.
    ---
    --- States are in sets to quickly change between them
    --- when there are a lot of states.
    ---@type string[][]
    states = {
        { " ", "/", "X" },
        { "<", ">" },
        { "?", "!", "*" },
        { '"' },
        { "l", "b", "i" },
        { "S", "I" },
        { "p", "c" },
        { "f", "k", "w" },
        { "u", "d" }
    }
})
```

### 📚 Commands

You can run the `:Checkbox` command to use this module.

```vim
:Checkbox toggle
```

It supports the following sub-commands,

- `toggle`
  Toggles checkbox state. Supports visual mode too!

- `change`
  Changes the state of the checkbox.
  Parameters,
  - `x`, offset in the X-axis.
  - `y`, offset in the Y-axis.

```txt
If the current state is [/], you can visualise
the states on the X & Y axis like so.

   ↑      { [u], [d] },
 ← O → X  { [ ], [/], [X] },
   ↓      { [<], [>] }
   Y

If you did `:Checkbox change -1 -1` you will get [u]
as the items support negative index.
```

---

## 🔖 Heading level changer

Allows changing heading levels. Supports both `ATX headings` & `Setext headings`.
>[!NOTE]
> As this is *tree-sitter* based it doesn't support `visual mode`.

### 📚 Usage

```lua
require("markview.extras.headings").setup();
```

### 📚 Commands

You will get access to the `:Headings` command.

```vim
:Headings increase
```

It has the following sub-commands,

- `increase`
  Increases heading level by 1.

- `decrease`
  Decreases heading level by 1.

---

## 💻 Code block editor

A simple code block editor. It allows editing code blocks in a floating window.

If you have LSP for the language then this will enable them.

It will work for nested code blocks too!

### 📚 Usage

```lua
require("markview.extras.editor").setup();
```

### 📚 Commands

You will get access to the `:Editor` command.

```vim
:Editor edit
```

It has the following sub-commands,

- `create`
  Create a code block under the cursor.

- `edit`
  Edits the code block under the cursor.

---
