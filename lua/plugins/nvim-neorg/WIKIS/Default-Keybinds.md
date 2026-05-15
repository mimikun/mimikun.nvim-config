<div align="center">

# :keyboard: Neorg Keybinds :keyboard:
A comprehensive list of all keys available in Neorg.

</div>

### Further Reading

To find out how to rebind the available keys consult the [`core.keybinds`](https://github.com/nvim-neorg/neorg/wiki/User-Keybinds) wiki entry.

## Preset `neorg` // All Files

### Normal Mode

<details>
<summary>

#### `<LocalLeader>nn` - create a new `.norg` file to take notes in

</summary>

- Maps to: `<Plug>(neorg.dirman.new-note)`
- Mnemonic: <code><strong>n</strong>ew <strong>n</strong>ote</code>

</details>

<details>
<summary>

#### `gO` - create a Table of Contents

</summary>

- Maps to: `<cmd>Neorg toc<CR>`
- Mnemonic: <code><strong>t</strong>able of <strong>c</strong>ontents</code>

</details>

## Preset `neorg` // Norg Only

### Insert Mode

<details>
<summary>

#### `<C-d>` - demote an object recursively

</summary>

- Maps to: `<Plug>(neorg.promo.demote)`

</details>

<details>
<summary>

#### `<C-t>` - promote an object recursively

</summary>

- Maps to: `<Plug>(neorg.promo.promote)`

</details>

<details>
<summary>

#### `<M-CR>` - create an iteration of e.g. a list item

</summary>

- Maps to: `<Plug>(neorg.itero.next-iteration)`

</details>

<details>
<summary>

#### `<M-d>` - insert a link to a date at the current cursor position

</summary>

- Maps to: `<Plug>(neorg.tempus.insert-date.insert-mode)`
- Mnemonic: <code><strong>d</strong>ate</code>

</details>

### Normal Mode

<details>
<summary>

#### `<,` - demote an object non-recursively

</summary>

- Maps to: `<Plug>(neorg.promo.demote)`

</details>

<details>
<summary>

#### `<<` - demote an object recursively

</summary>

- Maps to: `<Plug>(neorg.promo.demote.nested)`

</details>

<details>
<summary>

#### `<C-Space>` - switch the task under the cursor between a select few states

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-cycle)`

</details>

<details>
<summary>

#### `<CR>` - hop to the destination of the link under the cursor

</summary>

- Maps to: `<Plug>(neorg.esupports.hop.hop-link)`

</details>

<details>
<summary>

#### `<LocalLeader>cm` - magnifies a code block to a separate buffer.

</summary>

- Maps to: `<Plug>(neorg.looking-glass.magnify-code-block)`
- Mnemonic: <code><strong>c</strong>ode <strong>m</strong>agnify</code>

</details>

<details>
<summary>

#### `<LocalLeader>id` - insert a link to a date at the given position

</summary>

- Maps to: `<Plug>(neorg.tempus.insert-date)`
- Mnemonic: <code><strong>i</strong>nsert <strong>d</strong>ate</code>

</details>

<details>
<summary>

#### `<LocalLeader>li` - invert all items in a list

</summary>

Unlike `<LocalLeader>lt`, inverting a list will respect mixed list
items, instead of snapping all list types to a single one.
- Maps to: `<Plug>(neorg.pivot.list.invert)`
- Mnemonic: <code><strong>l</strong>ist <strong>i</strong>nvert</code>

</details>

<details>
<summary>

#### `<LocalLeader>lt` - toggle a list from ordered <-> unordered

</summary>

- Maps to: `<Plug>(neorg.pivot.list.toggle)`
- Mnemonic: <code><strong>l</strong>ist <strong>t</strong>oggle</code>

</details>

<details>
<summary>

#### `<LocalLeader>ta` - mark the task under the cursor as "ambiguous"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-ambiguous)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>a</strong>mbiguous</code>

</details>

<details>
<summary>

#### `<LocalLeader>tc` - mark the task under the cursor as "cancelled"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-cancelled)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>c</strong>ancelled</code>

</details>

<details>
<summary>

#### `<LocalLeader>td` - mark the task under the cursor as "done"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-done)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>d</strong>one</code>

</details>

<details>
<summary>

#### `<LocalLeader>th` - mark the task under the cursor as "on-hold"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-on-hold)`
- Mnemonic: <code>mark <strong>t</strong>ask as on <strong>h</strong>old</code>

</details>

<details>
<summary>

#### `<LocalLeader>ti` - mark the task under the cursor as "important"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-important)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>i</strong>mportant</code>

</details>

<details>
<summary>

#### `<LocalLeader>tp` - mark the task under the cursor as "pending"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-pending)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>p</strong>ending</code>

</details>

<details>
<summary>

#### `<LocalLeader>tr` - mark the task under the cursor as "recurring"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-recurring)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>r</strong>ecurring</code>

</details>

<details>
<summary>

#### `<LocalLeader>tu` - mark the task under the cursor as "undone"

</summary>

- Maps to: `<Plug>(neorg.qol.todo-items.todo.task-undone)`
- Mnemonic: <code>mark <strong>t</strong>ask as <strong>u</strong>ndone</code>

</details>

<details>
<summary>

#### `<M-CR>` - same as `<CR>`, except open the destination in a vertical split

</summary>

- Maps to: `<Plug>(neorg.esupports.hop.hop-link.vsplit)`

</details>

<details>
<summary>

#### `<M-t>` - same as `<CR>`, except open the destination in a new tab

</summary>

If destination is already open in an existing tab, just navigate to it
- Maps to: `<Plug>(neorg.esupports.hop.hop-link.tab-drop)`

</details>

<details>
<summary>

#### `>.` - promote an object non-recursively

</summary>

- Maps to: `<Plug>(neorg.promo.promote)`

</details>

<details>
<summary>

#### `>>` - promote an object recursively

</summary>

- Maps to: `<Plug>(neorg.promo.promote.nested)`

</details>

### Visual Mode

<details>
<summary>

#### `<` - demote objects in range

</summary>

- Maps to: `<Plug>(neorg.promo.demote.range)`

</details>

<details>
<summary>

#### `>` - promote objects in range

</summary>

- Maps to: `<Plug>(neorg.promo.promote.range)`

</details>

