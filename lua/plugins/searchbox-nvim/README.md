# Searchbox

## Configuration

If you want to change anything in the `UI` or add a "hook" you can use `.setup()`.

This is the default configuration.

```lua
--vim.keymap.set('n', '<leader>s', ':SearchBoxIncSearch<CR>')
--vim.keymap.set('x', '<leader>s', ':SearchBoxIncSearch visual_mode=true<CR>')
require('searchbox').setup({
  defaults = {
    reverse = false,
    exact = false,
    prompt = ' ',
    modifier = 'disabled',
    confirm = 'off',
    clear_matches = true,
    show_matches = false,
  },
  popup = {
    relative = 'win',
    position = {
      row = '5%',
      col = '95%',
    },
    size = 30,
    border = {
      style = 'rounded',
      text = {
        top = ' Search ',
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
  grep_options = {
    executable = 'grep',
    flags = '-rn',
    show_progress = 'popup',
    quickfix_window = true,
    quickfix_format = '%f:%l:%m,%f:%l%m,%f  %l%m'
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    on_done = function(value, search_type)
      -- code
    end
  }
})
```

* `defaults` is a "global config", allows you to set some properties for all inputs. So you don't have to declare them using the command api or the lua api.

* `popup` is passed directly to `nui.popup`. You can check the valid keys in their documentation: [popup.options](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup#options)

* `grep_options` are the settings for the grep input.

  * `executable` is the external program that will execute the search.
  * `flags` can be string or list of strings, it will be provided to the program as extra arguments before the search term.
  * `show_progress` display the number of matches found during search. It can have three possible values: popup, echo or disabled.
  * `quickfix_window` shows the quickfix window after the search done.
  * `quickfix_format` is the pattern that will be used to parse the output of the program. See [errorformat](https://neovim.io/doc/user/quickfix/#errorformat) for more details.

* `hooks` must be functions. They will be executed during the "lifecycle" of the input.

*before_mount* and *after_mount* receive the instance of the input, so you can do anything with it.

*on_done* it's executed after the search is finished. In the case of a successful search it gets the value submitted and the type of search as arguments. When doing a search and replace, it gets executed after the last substitution takes place. In case the search was cancelled, the first argument is `nil` and the second argument is the type of search.

### Custom keymaps

You can only modify the keymaps after the input is created, means you should do it in the `after_mount` hook.

These are the actions available in the input.

* `<Plug>(searchbox-close)`
* `<Plug>(searchbox-scroll-up)`
* `<Plug>(searchbox-scroll-down)`
* `<Plug>(searchbox-scroll-page-up)`
* `<Plug>(searchbox-scroll-page-down)`
* `<Plug>(searchbox-prev-match)`
* `<Plug>(searchbox-next-match)`
* `<Plug>(searchbox-last-search)`
* `<Plug>(searchbox-replace-step)`

Here is an example. If you wanted to "add support" for normal mode, you would do this.

```lua
after_mount = function(input)
  local opts = {buffer = input.bufnr}

  -- Esc goes to normal mode
  vim.keymap.set('i', '<Esc>', '<cmd>stopinsert<cr>', opts)

  -- Close the input in normal mode
  vim.keymap.set('n', '<Esc>', '<Plug>(searchbox-close)', opts)
  vim.keymap.set('n', '<C-c>', '<Plug>(searchbox-close)', opts)
end
```

## Grep

In Neovim to search in multiple files we have the `:grep` command. This will invoke a grep-like command using your shell, and when it is done it stores the output in a quickfix list. This means you can navigate between results using other built-in features.

What's the problem with `:grep`? It is synchronous. It blocks the editor while the grep program is running. That's pretty much it. The grep input in this plugin is just like `:grep` but is non-blocking. You can do things while the grep program is running in the background.

I write this to let you know some features and caveats the grep input has.

The first thing to know: there is no mechanism to detect what kind of grep-like program is available in your system. If you don't have `grep` installed in your system you can change the settings to use another program. Here is an example that uses [ripgrep](https://github.com/burntsushi/ripgrep) instead.

```lua
require('searchbox').setup({
  grep_options = {
    executable = 'rg',
    flags = {'--vimgrep', '-uu'},
    quickfix_format = '%f:%l:%c:%m',
  },
})
```

In addition to `grep_options.flags`, there are two more ways we can add extra arguments to the grep program. We have the search argument `modifier` and the search input itself.

For example you can provide an extra flag in Neovim's command-line, like this:

```vim
:SearchBoxGrep modifier="-H -I"
```

In this case we are adding two flags. And is worth noting whitespace is used as a separator. If you need to provide a whitespace as a value to a flag, you are out of luck. Imagine this: `modifier="--some-flag='need space'"`. That would not work as expected. Key/value pairs work as long as you don't need to provide a space in the value, this works: `modifier="--some-flag=thing"`.

You can also provide flags in the search input itself. If the first character of the search pattern is `-` then it will be split in half. Let's say you type this on the input.

```txt
╭ Grep ──────────────────────────╮
│ --include=*.lua -- some thing  │
╰────────────────────────────────╯
```

This will split in two parts using ` -- ` as a separator. Anything after the separator will be the search pattern. Here `some thing` will become the "search query." Notice you can use whitespace here with no problem. Anything that is before `--` will be treated as flags, so is exactly like the `modifier` argument.

If your search pattern starts with `-` but you don't use `--` then everything is a flag. Say we type this:

```txt
╭ Grep ──────────────────────────╮
│ -d some thing                  │
╰────────────────────────────────╯
```

Here what happens will depend on the grep program. Because remember, key/value flags can have two forms: `--key value` and `--key=value`. So, if `-d` happens to be a key/value flag then `some` will become its value, which may or may not be what you want. And this is why we have `--` as a separator, so the plugin can distinguish between flags and search query.

In case it needs to be said, if your search pattern does not begin with a `-`, everything will be treated as the search query.

If the search is taking too long and want to cancel it, use the command `:SearchBoxGrepKill`.

One more thing. If you like the idea of an asynchronous grep but don't care about the floating input, you can use the function `run_grep` in the lua api. You can make your own `:Grep` command.

```lua
vim.api.nvim_create_user_command('Grep', function(input)
  require('searchbox').run_grep(input.args)
end, {nargs = 1})
```

Or if you prefer vimscript.
