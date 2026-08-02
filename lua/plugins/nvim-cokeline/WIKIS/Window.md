# Window

Tabpage objects contain window objects. The window object is simply a lua table with the following values:

```lua
Window = {
  number = integer,
  buffer = Buffer
}
```

## Properties

### number: integer

The window's internal id number, as reported by `vim.api.nvim_get_current_win()`.

### buffer: Buffer

The Buffer object representing the buffer that is shown in the window.

## Methods

```lua
--- Closes the window
function Window:close()

--- Focuses the window
function Window:focus()
```