# Rule Basics

At its core, a rule consists of two things: a **pair definition** and an optional **declaration of filetypes** where the rule is in effect. A pair definition has an opening part and a closing part. Each of these parts can be as simple as a single character like a pair of parenthesis, or multiple characters like Markdown code fences. Defining a rule is straightforward:

```lua
Rule(begin_pair, end_pair, filetypes)
```

Where `begin_pair` is the opening part of the pair and `end_pair` is the closing part. `filetypes` may be specified in multiple ways:

```lua
Rule("(", ")")                      -- Enabled for all filetypes
Rule("(", ")", "markdown")          -- As a string
Rule("(", ")", {"markdown", "vim"}) -- As a table
```

Additionally, it is possible to specify filetypes where the rule should **not** be enabled by prefixing it with a `-` character:

```lua
Rule("(", ")", "-markdown") -- All filetypes *except* markdown
```

# Controlling rule behavior 

By default, rules are very simple and will always complete a pair the moment the opening part is typed. This is fine and in some cases desirable, but the rules API allows you to control the manner and context in which pairs are completed; this is done by attaching **conditions** (predicates) to **events** and adding **modifiers** to the rule. `Rule` objects expose a variety of methods to add these predicates and modifiers to the rule.

## Method Overview

These methods allow control over if, when, and how rules perform completion of pairs. Each method returns the `Rule` object so that they may be chained together to easily define complex rules.

| method                            | usage                                                          |
| --------------------------------- | -------------------------------------------------------------- |
| with_pair(cond)                   | add condition to check during pair event                       |
| with_move(cond)                   | add condition to check during move right event                 |
| with_cr(cond)                     | add condition to check during line break event                 |
| with_del(cond)                    | add condition to check during delete pair event                |
| only_cr(cond)                     | enable _only_ the line break event; disable everything else    |
| use_regex(bool, "<key>")          | interpret `begin_pair` as regex; optionally set trigger key    |
| use_key("<key>")                  | set trigger key                                                |
| replace_endpair(func, check_pair) | define ending part with a function; optionally add `with_pair` |
| set_end_pair_length(number)       | override offset used to position the cursor between the pair when `replace_endpair` is used |
| replace_map_cr(func)              | change the mapping for used for `<CR>` during the line break event |
| end_wise(cond)                    | make the rule an end-wise rule                                 |

### Aiding understanding: "When" instead of "With"

It may be helpful to think of the `with_<event>` functions as reading more like
`when_<event>` instead, as the condition is checked **when** `<event>` happens
(or wants to happen). This naming scheme more accurately describes how the
`Rule` is affected and reads more intuitively when reading a rule definition.

For example, given a rule definition `Rule("(", ")")`, each method has a certain
effect on how and when the ending part of the pair, the closing parenthesis, is
completed. The ending part is only completed **when** associated
conditions are met upon typing the opening part of the pair.

## Conditions

nvim-autopairs comes with a variety of common predicates ready to use simply by including:

```lua
local cond = require('nvim-autopairs.conds')
```

| function                        | Usage                                                   |
|---------------------------------|---------------------------------------------------------|
| none()                          | always false                                            |
| done()                          | always true                                             |
| before_text(text)               | `text` exists before opening part                       |
| after_text(text)                | `text` exists after opening part                        |
| before_regex(regex, length)     | `regex` matches before opening part                     |
| after_regex(regex, length)      | `regex` matches after opening part                      |
| not_before_text(text)           | `text` is not before opening part                       |
| not_after_text(text)            | `text` is not after opening part                        |
| not_before_regex(regex, length) | `regex` doesn't match before opening part               |
| not_after_regex(regex, length)  | `regex` doesn't match after opening part                |
| not_inside_quote()              | not currently within quotation marks                    |
| is_inside_quote()               | currently within quotation marks                        |
| not_filetypes({table})          | current filetype is not inside table                    |
| is_bracket_in_quote()           | check the next char is quote and cursor is inside quote |

**N.B.** While `cond.not_filetypes` is available, it's better to use the minus syntax on the desired filetype in the initial rule declaration, since then the rule is completely removed from the buffer.

### Treesitter Conditions

Predicates based on the state of the Treesitter graph can be used by including: 

```lua
local ts_conds = require('nvim-autopairs.ts-conds')
```

| function                     | Usage                         |
|------------------------------|-------------------------------|
| is_ts_node({node_table})     | check current treesitter node |
| is_not_ts_node({node_table}) | check not in treesitter node  |

# Method Explanations

This section explains each method in more detail: their signatures and how they modify the rule's behavior are all outlined here.

## The `with_*` methods

Calling these methods on a `Rule` will add predicate functions to their
corresponding event, which determines whether the effect of the event actually
takes place. There are no predicates if you don't define any, and so any events
without predicates behave as if they had a single predicate that always returns
true.

The predicate functions will receive an `opts` table with the following fields:
- `rule` the `Rule` object
- `bufnr` the buffer number
- `col` the current column (1-indexed)
- `ts_node` the current treesitter node (if treesitter is enabled)
- `text` the current line, with typed char inserted
- `line` the current line, before substitutions
- `char` the typed char
- `prev_char` the text just before cursor (with length `== #rule.start_pair`)
- `next_char` the text just after cursor (with length `== #rule.start_pair` if rule is not regex, else end of line)

A `Rule` may have more than one predicate defined for a given event, and the
order that they are defined will be the order that they are checked. However,
the **first** non-`nil` value returned by a predicate is used and the remaining
predicates (if any) are **not** executed. In other words, predicates defined
earlier have priority over predicates defined later.

### `with_pair(cond, pos)`

After typing the opening part, the ending part will only be
added if `cond(opts)` returned true. `with_pair` may be called more than once, and by
default, each predicate is appended to a list. When the "pair" event fires, the
_first_ predicate to return non-nil is used as the condition result. Specifying
`pos` allows explicit control over the order of the predicates.

### `with_move(cond)`

If `cond(opts)` is true, the cursor is simply moved right when typing the ending part
of the pair and the next character is also the ending part, e.g. `foo|"` => `foo"|` when
typing `"`. If `cond(opts)` returns false, the ending part is inserted as normal
instead.

### `with_cr(cond)`

If `cond(opts)` is true, then move the ending part of the pair to a new line below the
cursor after pressing `<CR>` while the cursor is between the pair (think curly
braces opening a block). Otherwise `<CR>` behaves as normal. For example:

    {|}

Typing `<CR>` produces the following when `cond` is true:

    {
        |
    }

### `with_del(cond)`

If `cond(opts)` is true, when the cursor is between the pair, pressing `<BS>` to
delete the opening part of the pair will delete the ending part as well.

## The `use_*` methods

The `use_*` functions alter how auto-pairing is triggered. Normally, the first
argument to `Rule` is taken literally as the opening part of the pair and as
soon as it is typed the "pair" event fires.

### `use_key(key)`

The pair is only completed when `key` is pressed, instead of the moment that the
opening part is typed. This is particularly useful in `use_regex`.

### `use_regex(bool, key)`

Causes the opening part to be interpreted as a lua pattern that triggers
insertion of the ending part when matched. If `key` is specified, then it acts
as an implicit `use_key`.

## Shorthand methods

These methods exist as convenient shortcuts for defining certain behaviors.

### `end_wise(func)`

This method is used to make "end-wise" rules, which is terminology that should
be familiar to users of other auto-pair plugins, e.g. Lexima. Specifically, this
method makes it so that the ending part of the pair will be completed _only upon
pressing `<CR>` after the opening part_, in which case the "newline" event is
fired as usual.

This behavior is useful for languages with statement constructs like Lua and
Bash. For example, defining the following `Rule`:

```lua
Rule('then', 'end'):end_wise(function(opts))
    -- Add any context checks here, e.g. line starts with "if"
    return string.match(opts.line, '^%s*if') ~= nil
end)
```

And then pressing `<CR>` at the following cursor position:

    if foo == bar then|

Would be completed as this (assuming some kind of automatic indent is enabled):

    if foo == bar then
        |
    end

### `only_cr(cond)`

This shortcut method disables the "pair", "del", and "move" events by setting
a single predicate for each that is always false. Additionally, the effect
of any `use_key` modifiers are removed as well. If `cond` is specified,
a "newline" predicate is set as if `with_cr` were called.

This method is convenient for defining _simple_ end-wise rules. As an example,
a default rule is defined with `only_cr` for Markdown code blocks with an
explicit language; the closing triple-backtick is not completed until you press
`<CR>` after specifying the language:

    ```lua  <-- <CR> pressed here
    |
    ```

## Advanced methods

These methods allow you to define more complex and dynamic rules. When
combined with `with_*` and `use_*` methods, it is possible to create very
powerful auto-pairs.

### `replace_endpair(func, check_pair)`

Facilitates the creation of dynamic ending parts. When the "pair" event fires
and the ending part is to be completed, `func` is called with a single `opts`
argument and should return a string. The returned string will be sent to
`nvim_feedkeys` to insert the ending part of the pair.

The `opts` parameter is a table that provides context for the current pair
completion, and can be useful for determining what to return. Note that because
`nvim_feedkeys` is used, arbitrary Vim functionality can be leveraged, such as
including `<Esc>` to be able to send normal mode commands.

#### Optional `check_pair` parameter

The `check_pair` parameter is optional, and can either be a boolean or function.
If `check_pair` is a function, it is passed as-is to `with_pair` to create
a "pair" predicate. If `check_pair` is true, then an implicit
`with_pair(cond.after_text(rule.end_pair))` predicate is added, where
`rule.end_pair` is the second argument to the `Rule` constructor. If
`check_pair` is false, an "always false" `with_pair` predicate is added.

As an example, these two rule definitions are equivalent:

```lua
-- This...
Rule("(", ")")
  :use_key("<C-h>")
  :replace_endpair(function() return "<BS><Del>" end, true)

-- ...is shorthand for this
Rule("(", "")
  :use_key("<C-h>")
  :with_pair(cond.after_text(")")) -- check that text after cursor is `)`
  :replace_endpair(function() return "<BS><Del>" end)
```

### `set_end_pair_length(len)`

When completing the ending part of a pair, the cursor necessarily moves backward
so that is in between the opening part and the closing part. In order to do
this, the `Rule` must know the length of the ending part, which by default is
trivially determined. However, if you would like to override where the cursor is placed
after completion, i.e. using `replace_endpair`, you can explicitly set the ending part length with this method.

### `replace_map_cr(func)`

This method allows you to set a custom mapping for the "newline" (`<CR>`) event
that will be used instead of the normal behavior. This can be helpful for
enforcing certain styles or or adding additional edits. `func` is called with
a single `opts` argument and should return a string specifying the mapping for
`<CR>`. The default mapping is: `<C-g>u<CR><C-c>O`.