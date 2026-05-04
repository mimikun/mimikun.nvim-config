# 💻 Dev documentations

Mostly for extending plugin functionalities.

## 📑 States

Plugin states are stored in `require("helpview").states`.

```lua
--- Table containing various plugin states.
---@class helpview.state
---
--- List of attached buffers.
---@field attached_buffers integer[]
---
--- Buffer local states.
---@field buffer_states { [integer]: { enable: boolean, hybrid_mode: boolean? } }
---
--- Source buffer for hybrid mode.
---@field splitview_source? integer
--- Preview buffer for hybrid mode.
---@field splitview_buffer? integer
--- Preview window for hybrid mode.
---@field splitview_window? integer
helpview.state = {
    attached_buffers = {},
    buffer_states = {},

    splitview_buffer = nil,
    splitview_source = nil,
    splitview_window = nil
};
```

>[!WARNING]
> `splitview_buffer` might not be `nil` even after closing splitview as there's no point in creating a new buffer every time.

## 🚀 Internal functions

>[!TIP]
> The sub-command implementation can be found in `require("helpview").commands`.

Commonly used functions can be found inside `require("helpview").actions`. These are,

- `__exec_callback`,
  Safely executes a given callback.

  Usage: `helpview.actions.__exec_callback(callback, ...)`
  + `callback`, callback name.
  + `...` arguments.

- `__is_attached`,
  Checks if `helpview` is attached to a buffer or not.

  Usage: `helpview.actions.__is_attached(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

  Return: `boolean`

- `__is_enabled`,
  Checks if `helpview` is enabled on a buffer or not.

  Usage: `helpview.actions.__is_enabled(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

  Return: `boolean`

- `__splitview_setup`
  Sets up the buffer & window for `splitview`.

  Usage: `helpview.actions.__splitview_setup()`

>[!WARNING]
> **Anti-pattern:** Prevents users from forcefully closing the splitview window.

------

- `attach`
  Attaches `helpview` to a buffer.

  Usage: `helpview.actions.attach(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

- `detach`
  Detaches `helpview` to a buffer.

  Usage: `helpview.actions.detach(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

------

- `enable`
  Enables previews for the given buffer.

  Usage: `helpview.actions.enable(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

- `disable`
  Disables previews for the given buffer.

  Usage: `helpview.actions.disable(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

------

- `hybridEnable`
  Enables *hybrid mode* for the given buffer.

  Usage: `helpview.actions.hybridEnable(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

- `hybridDisable`
  Disables *hybrid mode* for the given buffer.

  Usage: `helpview.actions.hybridDisable(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

------

- `splitOpen`
  Opens splitview for the given buffer.

  Usage: `helpview.actions.splitOpen(buffer)`
  + `buffer`, buffer ID(defaults to current buffer).

- `splitClose`
  Closes any open splitview window.

## ✨ Manual previews

You can manually show previews via these functions,

- `helpview.render(buffer)`
  Renders preview on `buffer`(defaults to current buffer).

- `helpview.clear(buffer)`
  Clears previews of `buffer`(defaults to current buffer).

------

- `helpview.clean()`
  Detaches `helpview` from any invalid buffer.

------

Also available in vimdoc, `:h helpview.nvim-dev`.

