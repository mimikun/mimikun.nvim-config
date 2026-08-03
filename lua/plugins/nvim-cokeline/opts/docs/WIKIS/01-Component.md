# Component<Cx>

You can configure what each buffer in your bufferline will be composed of by passing a list of components to the setup function.

Components have the following structure:

```lua
Component = {
  text = string | function(Cx) -> string,

  fg = "#rrggbb" | "HlGroup" | function(cx: Cx) -> "#rrggbb" | "HlGroup",
  bg = "#rrggbb" | "HlGroup" | function(cx: Cx) -> "#rrggbb" | "HlGroup",
  style = "attr1,attr2,..." | function(cx: Cx) -> "attr1,attr2,...",

  highlight = nil | "#rrggbb" | "HlGroup" | function(cx: Cx) -> "#rrggbb" | "HlGroup",

  delete_buffer_on_left_click = boolean,

  on_click = nil | function(id, clicks, buttons, modifiers, cx)

  on_mouse_enter = nil | function(cx, mouse_col)

  on_mouse_leave = nil | function(cx)

  truncation = {
    priority = integer,
    direction = "left" | "middle" | "right",
  },
}
```

Depending on the location of the component Cx is a Buffer or TabPage object, or in the case of `rhs` components, just a table with an `is_hovered property`.

For example, let's imagine we want to construct a very minimal bufferline where the only things we're displaying for each buffer are its index, its filename and a close button.

Then in our setup function we'd have:

```lua
require('cokeline').setup({
  -- ...

  components = {
    {
      text = function(buffer) return ' ' .. buffer.index end,
    },
    {
      text = function(buffer) return ' ' .. buffer.filename .. ' ' end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = ' ',
    }
  }
}
```

in this case every buffer would be composed of four components: the first displaying a space followed by the buffer index, the second one the filename padded by a space on each side, then a close button that allows us to :bdelete the buffer by left-clicking on it, and finally an extra space.

This way of dividing each buffer into distinct components, combined with the ability to define every component's text and color depending on some property of the buffer we're rendering, allows for great customizability.

the `text` key is the only one that has to be set, all the others are optional
and can be omitted.

The `truncation` table controls what happens when a buffer is too long to be
displayed in its entirety.

More specifically, if a buffer's width (given by the sum of the widths of all
its components) is bigger than the `rendering.max_buffer_width` config option,
the buffer will be truncated.

The default behaviour is truncate the buffer by dropping components from right
to left, with the text of the last component that's included also being
shortened from right to left. This can be modified by changing the values of
the `truncation.priority` and `truncation.direction` keys.

The `truncation.priority` controls the order in which components are dropped:
the first component to be dropped will be the one with the lowest priority. If
that's still not enough to bring the width of the buffer within the
`rendering.max_buffer_width` limit, the component with the second lowest
priority will be dropped, and so on. Note that a higher priority means a
smaller integer value: a component with a priority of 5 will be dropped
_after_ a component with a priority of 6, even though 6 > 5.

The `truncation.direction` key simply controls from which direction a component
is shortened. For example, you might want to set the `truncation.direction` of
a component displaying a filename to `'middle'` or `'left'`, so that if
the filename has to be shortened you'll still be able to see its extension,
like in the following example (where it's set to `'left'`):
