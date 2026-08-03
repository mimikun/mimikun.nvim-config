# Buffer

Some of the configuration options can be functions that take a `Buffer` as a
single parameter. This is useful as it allows users to set the values of
components dynamically based on the buffer that component is being rendered
for.

```lua
Buffer = {
  index = integer,
  number = integer,
  type = string,
  is_focused = boolean,
  is_modified = boolean,
  is_readonly = boolean,
  path = string,
  unique_prefix = string,
  filename = string,
  filetype = string,
  pick_letter = char,
  devicon = { icon = string, color = string },
  diagnostics = {
    errors = integer,
    warnings = integer,
    infos = integer,
    hints = integer
  }
}
```

## Properties

### index: integer

The buffer's order in the bufferline (1 for the first buffer, 2 for the second one, etc.).

### number: integer

The buffer's internal number as reported by `:ls`

### is_focused: boolean

Whether the buffer is currently focused

### is_modified: boolean

### is_readonly: boolean

### is_first: boolean

The buffer is the first visible buffer in the tab bar.

### is_last: boolean

The buffer is the last visible buffer in the tab bar.

### is_hovered: boolean

The mouse is hovering over the buffer
This is a special variable in that it will only be true for the hovered *component* on render. This is to allow components to respond to hover events individually without managing component state. If you just need the hovered bufnr, you can use `require('cokeline.hover').hovered().bufnr`.

### type: string

The buffer's type as reported by `:echo &buftype`.

### filetype: string

The buffer's filetype as reported by `:echo &filetype`.

### path: string

The buffer's full path

### filename: string

The buffer's filename

### unique_prefix: string

A unique prefix used to distinguish buffers with the same filename stored in different directories. For example, if we have two files `bar/foo.md` and `baz/foo.md`, then the first will have `bar/` as its unique prefix and the second one will have `baz/`.

### pick_letter: char

The letter that is displayed when picking a buffer to either focus or close it.

### devicon

This needs the `kyazdani42/nvim-web-devicons` plugin to be installed.
The color is in hex format.

#### devicon.icon: string

An icon representing the buffer's filetype.

#### devicon.color = '#rrggbb',

The colors of the devicon in hexadecimal format (useful to be passed to a component's `fg` field (see the `Components` section).

### diagnostics

* diagnostics.errors: integer
* diagnostics.warnings: integer
* diagnostics.infos: integer
* diagnostics.hints: integer

The values in this table are the ones reported by Neovim's built in LSP interface. 

## Methods

```lua
---@param self Buffer
---Deletes the buffer
function Buffer:delete()

---@param self Buffer
---Focuses the buffer
function Buffer:focus()

---@param self Buffer
---@return number
---Returns the number of lines in the buffer
function Buffer:lines()

---@param self Buffer
---@return string[]
---Returns the buffer's lines
function Buffer:text()

---@param buf Buffer
---@return boolean
---Returns true if the buffer is valid
function Buffer:is_valid()
```
