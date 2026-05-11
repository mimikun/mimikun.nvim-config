# Usage

To enter Multicursor mode, use one of the above commands.

## Multi cursor mode

> [!IMPORTANT]
> Keys that aren't mapped **do not affect other selections** .

<details>
  <summary>Click to see mappings.</summary>

| Key | Description |
|---|---|
| `<Esc>` | Clear the selections and go back to normal mode |
| `<C-c>` | Clear the selections and go back to normal mode |
| `i` | Enters insert mode |
| `a` | Enters append mode |
| `e` | Enters extend mode |
| `c` | Deletes the text inside selections and starts insert mode |
| `n` | `[count]` Finds the next match after the main selection |
| `N` | `[count]` Finds the previous match before the main selection |
| `<C-a>` | Creates selections for all the matches |
| `q` | `[count]` Skips the current selection and finds the next one |
| `Q` | `[count]` Skips the current selection and finds the previous one |
| `]` | `[count]` Swaps the main selection with next selection |
| `[` | `[count]` Swaps the main selection with previous selection |
| `}` | `[count]` Deletes the main selection and goes to next |
| `{` | `[count]` Deletes the main selection and goes to previous |
| `<C-n>` | Creates a selection for the char under the cursor |
| `j` | `[count]` Creates a selection on the char below the cursor |
| `J` | `[count]` Skips the current selection and Creates a selection on the char below |
| `k` | `[count]` Creates a selection on the char above the cursor |
| `K` | `[count]` Skips the current selection and Creates a selection on the char above |
| `r` | Replaces the text inside selections with content of `unnamed register` |
| `p` | Puts the text inside `unnamed register` before selections |
| `P` | Puts the text inside `unnamed register` after selections |
| `y` | Yanks the text inside selections to `unnamed register` |
| `Y` | Yanks the text from the start of selection till the end of the line to `unnamed register` |
| `yy` | Yanks the line of selection to `unnamed register` |
| `gu` | changes selections case to lowercase |
| `gU` | changes selections case to UPPERCASE |
| `z` | Aligns selections by adding space before selections |
| `Z` | Aligns selections by adding space at the start of the line |
| `d` | Deletes the text inside selections |
| `D` | `count` Deletes the text from the start of selections till the end of the line |
| `dd` | `count` Deletes line of selections |
| `@` | Executes a macro at the start of selections |
| `.` | Repeats last change at the start of selections |
| `,` | Clears All Selections except the main one |
| `:` | Prompts for a normal command and Executes it at the start of selections |
| `u` | Undo changes |
| `<C-r>` | Redo changes |

</details>

## Insert, Append and Change mode:

<details>
  <summary>Click to see mappings.</summary>

| Key | Description |
|---|---|
| `<Esc>`   | Returns to multicursor normal mode |
| `<C-c>`   | Returns to multicursor normal mode |
| `<BS>`    | Deletes the char before the selections |
| `<Del>`   | Deletes the char under the selections |
| `<Left>`  | Moves the selections one char Left |
| `<Up>`    | Moves the selections one line Up |
| `<Right>` | Moves the selections one char Right |
| `<Down>`  | Moves the selections one line Down |
| `<C-Left>`  | Moves the selections one word Left |
| `<C-Right>` | Moves the selections one word Right |
| `<Home>`  | Moves the selections to start of line |
| `<End>`   | Moves the selections to end of line |
| `<CR>`    | Insert one line below the selections |
| `<C-j>`   | Insert one line below the selections |
| `<C-v>`   | Pastes the text from system clipboard |
| `<C-r>`   | Insert the contents of a register |
| `<C-w>`   | Deletes one word before the selections |
| `<C-BS>`  | Deletes one word before the selections |
| `<C-u>`   | Deletes from the start of selections till the start of line |

</details>

## Extend mode

Once you enter the Extend mode, you can expand or shrink your selections using Vim motions or Treesitter nodes.
At first, the left side of the selections stays put, and selections get extended from the right side.
But you can change which side of selections stay put by pressing `o`.

<details>
  <summary>Click to see mappings.</summary>

| Key | Description |
|---|---|
| `<Esc>`   | Returns to multicursor normal mode |
| `c` | Prompts user for a motion and performs it |
| `o` | Toggles the anchor side |
| `O` | Toggles the anchor side |
| `w` | `[count]` word forward |
| `e` | `[count]` forward to end of word |
| `b` | `[count]` word backward |
| `h` | `[count]` char left |
| `j` | `[count]` char down |
| `k` | `[count]` char up |
| `l` | `[count]` char right |
| `t` | Extends the selection to the parent of the selected node |
| `r` | Shrinks the selection to the first child of the selected node |
| `y` | Shrinks the selection to the last child of the selected node |
| `u` | Undo Last selections extend or shrink |
| `$` | `[count]` to end of line |
| `^` | To the first non-blank character of the line |

</details>

## Recipes

### Custom mappings

Create custom mapping for editing selections.

```lua
 require('multicursors').setup {
    local N = require("multicursors.normal_mode")
    normal_keys = {
        -- to change default lhs of key mapping change the key
        [','] = {
            -- assigning nil to method exits from multi cursor mode
            -- assigning false to method removes the binding
            method = N.clear_others,
            -- you can pass :map-arguments here
            opts = { desc = 'Clear others' },
        },
        ['<C-/>'] = {
            method = function()
                require('multicursors.utils').call_on_selections(function(selection)
                    vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
                    local line_count = selection.end_row - selection.row + 1
                    vim.cmd('normal ' .. line_count .. 'gcc')
                end)
            end,
            opts = { desc = 'comment selections' },
        },
    },
}
```

### Status Line module

Disable the hint window and show Multicursor mode in your status line.

```lua
 require('multicursors').setup {
    hint_config = false,
}

local function is_active()
    local ok, hydra = pcall(require, 'hydra.statusline')
    return ok and hydra.is_active()
end

local function get_name()
    local ok, hydra = pcall(require, 'hydra.statusline')
    if ok then
        return hydra.get_name()
    end
    return ''
end

--- for lualine add this component
lualine_b = {
    { get_name, cond = is_active },
 }
```

### Vertical hints
A configuration like this can be used to show hints in a vertical window similar to helix.

```lua
 require('multicursors').setup {
    hint_config = {
        float_opts = {
            border = 'rounded',
        },
        position = 'bottom-right',
    },
    generate_hints = {
        normal = true,
        insert = true,
        extend = true,
        config = {
            column_count = 1,
        },
    },
}
```

