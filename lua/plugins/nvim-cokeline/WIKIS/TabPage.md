# TabPage

Some of the configuration options can be functions that take a `TabPage` as a
single parameter. This is useful as it allows users to set the values of
components dynamically based on the buffer that component is being rendered
for.

```lua
TabPage = {
  number = integer,
  windows = Window[],
  focused = Window,
  is_active = boolean,
  is_first = boolean,
  is_last = boolean
}
```

## Properties

### number: integer

The tabpage number

### windows: Window[]

The Window objects representing the tabpage's windows.

### focused: Window

The currently focused window in the tabpage

### is_active: boolean

Whether the tabpage is the current tabpage

### is_first: boolean

Whether the tabpage is first in the list of tabpages (the smallest tabnr returned from `vim.api.nvim_list_tabpages()`).

### is_last: boolean

Whether the tabpage is last in the list of tabpages (the largest tabnr returned from `vim.api.nvim_list_tabpages()`).

## Methods

### TabPage:focus()

Focuses the tabpage. Equivalent to `vim.api.nvim_set_current_tabpage(TabPage.number)`.

### TabPage:close()

Closes the tabpage, as long as it is not the last one open.


