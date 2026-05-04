The default `parse_before/natural` was created primarily for proper translation of multi-line natural language.
For example, `natural` is better suited for reading [LICENSE](https://github.com/uga-rosa/translate.nvim/blob/main/LICENSE), but `trim` may be better suited for reading source code comments.

If you wish to respect the line breaks in the original text, use `trim` or `no_handle`.

```
require("translate").setup({
    default = {
        command = "translate_shell",
        output = "floating",
        parse_before = "trim",
    },
})
```
