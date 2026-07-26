### `^_` shows up at the end of files

Make sure that `conceal` feature of Vim is enabled. macOS built-in Vim doesn't so you need to install vim with homebrew or so on.
https://github.com/lambdalisue/fern.vim/issues/396#issuecomment-1073507080

### How to display dot (.) files

Execute `hidden:set` action or hit `!` to toggle.


### How to filter nodes

Execute `include` or `exclude` action or hit `fi` or `fe` to enter a pattern (Vim's regular expression) to filter nodes.

### How to get back from fern without performing actions (split window)

Use one of the following Vim's native mapping

| Mapping | Description |
| --- | --- |
| `<C-o>` | Get back to a previous cursor position |
| `<C-^>` (`<C-6>`) | Jump to an alternative buffer |

### How to get back from fern without performing actions (drawer style)

Use one of the following Vim's native mapping

| Mapping | Description |
| --- | --- |
| `<C-w>p` | Jump to the previous window |
| `:q` | Close the drawer (it automatically jumps to the previous window) |

Or use `-stay` option to show fern drawer like

```
:Fern -drawer -stay .
```
