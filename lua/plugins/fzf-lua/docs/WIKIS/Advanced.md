## Navigation

- [**API Basics: `fzf_exec`**](#fzf-exec-api)
  + [Lua table as contents](#fzf-exec-cont-tbl)
  + [Lua function as contents](#fzf-exec-cont-fnc)
  + [Pipe a shell command](#fzf-exec-cont-cmd)
  + [Pipe and transform a shell command](#fzf-exec-cont-cmd-trans)
  + [Supplying additional options](#fzf-exec-opts)
  + [Keybind handlers](#fzf-exec-acts)
  + [Action resume](#fzf-exec-act-resume)
  + [Action reload](#fzf-exec-act-reload)
  + [Action exec-silent](#fzf-exec-act-exec)
  + [Example: directory switcher](#fzf-exec-dir-switch)
- [**"Live" queries: `fzf_live`**](#fzf-live-api)
  + [Lua table as contents](#fzf-live-cont-tbl)
  + [Lua function as contents](#fzf-live-cont-fnc)
  + [Interactive shell command](#fzf-live-cont-cmd)
  + [Interactive shell command with transformation](#fzf-live-cont-cmd-trans)
  + [Example #1: "live" ripgrep](#fzf-live-live-rg)
  + [Example #2: "live" git-grep](#fzf-live-live-git)
- [**Customizing Grep Commands with `fn_transform_cmd`**](#fn_transform_cmd)
  + [Example: Custom glob parsing for git-grep](#fn_transform_cmd-example-git-grep)
- [**Preview overview**](#preview-overview)
  + [Fzf native preview](#preview-fzf-native)
  + [Neovim "builtin" preview](#preview-nvim-builtin)
- [**User examples**](#user-examples)
  + [Explore changes from a git branch](#user-examples-issue-471)
  + [Prioritize cwd when using `git_files`](#user-examples-issue-459)
  + [nvim-possession](#nvim-possession)


## <a id="fzf-exec-api">API Basics: `fzf_exec`</a>

Fzf-lua is highly customizable, almost anything can be changed and almost any
conceivable use-case is possible with varying effort/complexity.

Most simple customizations can be achieved using the `fzf_exec` function:
```lua
fzf_exec = function(contents, [opts])
```

* `contents`: contents of the fzf interface, depending on the
  argument type can behave differently:
  - `string`: piped shell command
  - `table` : array of strings (lines)
  - `function`: function with data callback
* `opts`: optional table containing all possible fzf-lua settings (`prompt`,
`winopts`, `fzf_opts`, `keymap`, etc), consult
[README.md#customization](https://github.com/ibhagwan/fzf-lua#customization)
for all possible options, partial list below:
  - `cwd`: working directory context for shell commands
  - `prompt`: fzf's prompt
  - `actions`: map of keybinds to function handlers
  - `fn_transform`: only called when content is of type `string`, a function
  that transforms each output line, can be used to add coloring, text
  manipulation, etc.
  - `silent_fail` [default: `true`]: when a shell command exist with an error
  code (e.g. a failed `rg` search), fzf will print `[Command failed: <command>]`
  to the info line, this can sometimes be confusing with fzf-lua as some
  commands are used inside a `neovim --headless` wrapper, set this to `false`
  to display the failed message
  - `debug` [default: `false`]: Boolean indicating if underlying fzf shell command should be `print`ed before execution.  (Can be viewed in `:messages`)

### <a id="fzf-exec-cont-tbl">Lua table as contents</a>

The most basic example is feeding an array of strings into fzf:
```lua
:lua require'fzf-lua'.fzf_exec({ "line1", "line2" })
```

### <a id="fzf-exec-cont-fnc">Lua function as contents</a>

For more complex use-cases one can also use a function with a data feed
callback, each call to `fzf_cb` below results in a line added to fzf.

> Don't forget to call `fzf_cb(nil)` to close the fzf named pipe, this
> signals EOF and terminates the fzf "loading" indicator.

```lua
require'fzf-lua'.fzf_exec(function(fzf_cb)
  for i=1,10 do
    fzf_cb(i)
  end
  fzf_cb() -- EOF
end)
```

If our function takes a long time to process you'd have a noticeable delay
before the fzf interface opens, fortunately, this is quite easy to solve using
lua coroutines:

```lua
require'fzf-lua'.fzf_exec(coroutine.wrap(function(fzf_cb)
  local co = coroutine.running()
  for i=1,1234567 do
    -- coroutine.resume only gets called once uv.write completes
    fzf_cb(i, function() coroutine.resume(co) end)
    -- wait here until 'coroutine.resume' is called which only happens
    -- once 'uv.write' completes (i.e. the line was written into fzf)
    -- this frees neovim to respond and open the UI
    coroutine.yield()
  end
  -- signal EOF to fzf and close the named pipe
  -- this also stops the fzf "loading" indicator
  fzf_cb()
end))
```

**Note:** that due to `coroutine.yield()`, any call inside the loop to
`vim.fn.xxx` or `vim.api.xxx` (and potentially neovim APIs) will fail with:
```
E5560: vimL function must not be called in a lua loop callback
```

However, we can use `vim.schedule` as a workaround to wrap the contents inside
our loop. The example below lists all buffers (prepended with their buffer
number):
```lua
require "fzf-lua".fzf_exec(coroutine.wrap(function(fzf_cb)
  local co = coroutine.running()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    vim.schedule(function()
      local name = vim.api.nvim_buf_get_name(b)
      name = #name > 0 and name or "[No Name]"
      fzf_cb(b .. ":" .. name, function() coroutine.resume(co) end)
    end)
    coroutine.yield()
  end
  fzf_cb()
end))
```

### <a id="fzf-exec-cont-cmd">Piped shell command</a>

Fzf's most common usage is piping a shell command, we do so by sending a
`string` argument as `contents`, below is the equivalent of running `ls | fzf`
in the shell:
```lua
:lua require'fzf-lua'.fzf_exec("ls")
```

### <a id="fzf-exec-cont-cmd-trans">Pipe and transform a shell command</a>

Sometimes we need to transform the output lines, for example, the below
prepends the current working directory and colors the command output purple:
```lua
require'fzf-lua'.fzf_exec("ls", {
  fn_transform = function(x)
    return vim.loop.cwd().."/"..require'fzf-lua'.utils.ansi_codes.magenta(x)
  end
})
```

We can also use fzf-lua's `make_entry` to add colorful icons to the output:
```lua
require 'fzf-lua'.fzf_exec("rg --files", {
  file_icons = true, -- Tells fzf-lua to load the file icon sets
                     -- can also be set to "mini" for "mini.icons"
  fn_transform = function(x)
    return FzfLua.make_entry.file(x, { file_icons = true, color_icons = true })
  end,
})
```

### <a id="fzf-exec-opts">Supplying additional options</a>

> For a full list of options consult
[README.md#customization](https://github.com/ibhagwan/fzf-lua#customization)

Any fzf-lua configuration option can be sent along the command:
```lua
:lua require'fzf-lua'.fzf_exec("ls", { prompt="LS> ", cwd="~/<folder>" })
```

Or:
```lua
:lua require'fzf-lua'.fzf_exec("ls", { winopts = { height=0.33, width=0.66 } })
```

### <a id="fzf-exec-acts">Keybind handlers</a>

Once items(s) are selected fzf-lua will run an action from the `actions` table
mapped to the pressed keybind (`default` gets called on `<CR>`):
```lua
require'fzf-lua'.fzf_exec("rg --files", {
  actions = {
    -- Use fzf-lua builtin actions or your own handler
    ['default'] = require'fzf-lua'.actions.file_edit,
    ['ctrl-y'] = function(selected, opts)
      print("selected item:", selected[1])
    end
  }
})
```

Alternatively, we can use fzf-lua default actions:
```lua
require'fzf-lua'.fzf_exec("rg --files", { actions = require'fzf-lua'.defaults.actions.files })
```

### <a id="fzf-exec-act-resume">Action resume</a>

Sometimes it is desirable to perform an action and resume immediately, an
example use case would be an action that deletes a file and then refreshes
the interface.

Although we can call `require'fzf-lua'.resume()` (`:FzfLua resume`) in our
action handler it is not optimal as it will "flash" the fzf window (close
followed by open), we can avoid that by supplying a table as our action
handler, this signals fzf-lua to not close the window and wait for a `resume`:
```lua
require'fzf-lua'.fzf_exec("ls", {
  actions = {
    ['ctrl-x'] = {
      function(selected)
        for _, f in ipairs(selected) do
          print("deleting:", f)
          -- uncomment to enable deletion
          -- vim.fn.delete(f)
        end
      end,
      require'fzf-lua'.actions.resume
    }
  }
})
```

### <a id="fzf-exec-act-reload">Action reload</a>

For better UX it is possible to use fzf's `reload` binds in fzf-lua's actions, using a
"reload" action  instead of `actions.resume` reloads the contents of fzf without restarting
the process, it provides for a smoother UI (no refresh) and the selected item remains in place.

To use "reload" actions, the following conditions must be met or **fzf-lua will automatically
convert the "reload" action to "actions.resume"**:
- fzf version >= `0.36` (skim is not supported)
- `contents` of type `string` (i.e. a shell command)

> **Note:** When the conditions above are met fzf-lua will try to automatically convert actions
> that are defined as `{ <function>, actions.resume }` to a "reload" action


To use a "reload" action define the `actions` as follows:
```lua
actions = {
    ["<bind1>"] = { fn = function(selected) end, reload = true }
    ["<bind2>"] = { fn = require'fzf-lua'.actions.file_edit, reload = true }
}
```

Thus the [action resume](#fzf-exec-act-resume) would be converted to:
```lua
require'fzf-lua'.fzf_exec("ls", {
  actions = {
    ['ctrl-x'] = {
      fn = function(selected)
        for _, f in ipairs(selected) do
          print("deleting:", f)
          -- uncomment to enable deletion
          -- vim.fn.delete(f)
        end
      end,
      reload = true,
    }
  }
})
```

### <a id="fzf-exec-act-exec">Action exec-silent</a>

Similarly to [action reload](#fzf-exec-act-reload) it is also possible to use fzf's
`exec-silent` binds in fzf-lua's actions.

> Unlike "reload" actions this works with any fzf version **but not with skim**.

Use the action `exec_silent` property to enable:
```lua
require'fzf-lua'.fzf_exec("ls", {
  actions = {
    ['ctrl-y'] = {
      fn = function(selected)
        print("exec:", selected[1])
      end,
      exec_silent = true,
    }
  }
})
```

### <a id="fzf-exec-dir-switch">Example: directory switcher</a>

Tying it all together, let's create a colored directory switcher, our provider
should recursively search all subdirectories using `fd` and `cd` into the
selected directory:
```lua
_G.fzf_dirs = function(opts)
  local fzf_lua = require'fzf-lua'
  opts = opts or {}
  opts.prompt = "Directories> "
  opts.fn_transform = function(x)
    return fzf_lua.utils.ansi_codes.magenta(x)
  end
  opts.actions = {
    ['default'] = function(selected)
      vim.cmd("cd " .. selected[1])
    end
  }
  fzf_lua.fzf_exec("fd --type d", opts)
end

-- map our provider to a user command ':Directories'
vim.cmd([[command! -nargs=* Directories lua _G.fzf_dirs()]])

-- or to a keybind, both below are (sort of) equal
vim.keymap.set('n', '<C-k>', _G.fzf_dirs)
vim.keymap.set('n', '<C-k>', '<cmd>lua _G.fzf_dirs()<CR>')

-- We can also send call options directly
:lua _G.fzf_dirs({ cwd = <other directory> })
```

## <a id="fzf-live-api">"Live" queries: `fzf_live`</a>

With `fzf_exec`, fzf contents is populated once and the query prompt is used
to fuzzy match on top of the results, but what if we wanted to change the
contents based on the typed query?

`fzf-live` utilizes fzf's `change:reload` mechanism (or skim's "interactive"
mode) to generate dynamic contents that changes with each keystrokes:

> You can read more about the way this works in
> [fzf#1750](https://github.com/junegunn/fzf/issues/1750) and in
> [Using fzf as interative Ripgrep launcher](https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-interative-ripgrep-launcher=)

```lua
fzf_live = function(contents, [opts])
```
* `contents`: must be of type `function(query)` and return a value of type:
  - `string`: reload with shell command output
  - `table` : reload from table
  - `function`: reload from function
* `opts`: optional settings, see [`fzf_exec`](#fzf-exec-api) for more info,
  important for this mode are:
  - `query` [default: `nil`]: initial query
  - `exec_empty_query` [default: `false`]: determines if the contents function is
  called with empty queries or only once the user starts typing, set to `true`
  when it's desirable to call `contents` when opening the interface (without
  supplying `opts.query`)
  - `silent_fail` [default: `true`]: when a shell command exist with an error
  code (e.g. a failed `rg` search), fzf will print `[Command failed: <command>]`
  to the info line, this can sometimes be confusing with fzf-lua as some
  commands are used inside a `neovim --headless` wrapper, set this to `false`
  to display the failed message
  - `stderr_to_stdout` [default: `true`]: by default fzf is finicky about
  displaying error messages that are sent to `stderr`, set to `true` this
  option appends `2>&1` to the shell command so error messages are treated
  as entries by fzf making sure a clear error message is displayed.

The `contents` argument is non-optional with the signature:
```lua
function(query) ... end
```
The function is then called each time fzf contents needs to be reloaded which
happens with every user keystroke (also when opening the interface with no
query if `exec_empty_query` is set).

The way the contents is reloaded differs based on the value type returned by
calling `contents()`, see the examples below for more details.


### <a id="fzf-live-cont-tbl">Lua table as contents</a>

Similar to `fzf_exec`, when returning a `table` each item corresponds to an fzf
line. In the below example fzf will be populated with X number of lines based
on the number the user types:
```lua
require 'fzf-lua'.fzf_live(
  function(args)
    local q = args[1]
    if not tonumber(q) then
      return { "Invalid number: " .. tostring(q) }
    end
    local lines = {}
    for i = 1, tonumber(q) do
      table.insert(lines, tostring(i))
    end
    return lines
  end,
  {
    prompt = 'Live> ',
    exec_empty_query = true,
  }
)
```

### <a id="fzf-live-cont-fnc">Lua function as contents</a>

In the above example, if you tried typing `12345678` you'd notice the UI
becomes less responsive the larger the number becomes, that's because the
table has to be filled with items **before** fzf-lua starts feeding fzf,
instead we can use a `function` argument that utilizes a lua `coroutine`
behind the scenes making sure the UI is free to respond in between inserts:

```lua
require'fzf-lua'.fzf_live(
  function(args)
    local q = args[1]
    return coroutine.wrap(function(fzf_cb)
      local co = coroutine.running()
      if tonumber(q) then
        for i=1,q do
          fzf_cb(i, function() coroutine.resume(co) end)
          coroutine.yield()
        end
      else
        fzf_cb("Invalid number: " .. q, function() coroutine.resume(co) end)
        coroutine.yield()
      end
      -- signal EOF to close the named pipe
      -- and stop fzf's loading indicator
      fzf_cb()
    end)
  end,
  {
    prompt = 'Live> ',
    exec_empty_query = true,
  }
)
```

Below is an example of using neovim API inside a reload function:
> Admittedly this is a useless example but I couldn't think of anything better
> that required both "live" content and the user of an API
```lua
require 'fzf-lua'.fzf_live(
  function(args)
    local q = args[1]
    return coroutine.wrap(function(fzf_cb)
      local co = coroutine.running()
      if tonumber(q) then
        for i = 1, q do
          vim.schedule(function()
            local bufs = vim.api.nvim_list_bufs()
            coroutine.resume(co, bufs)
          end)
          local bufs = coroutine.yield()
          for _, b in ipairs(bufs) do
            vim.schedule(function()
              local name = vim.api.nvim_buf_get_name(b)
              name = #name > 0 and name or "[No Name]"
              fzf_cb(string.format("%s. [%d] %s", i, b, name),
                function() coroutine.resume(co) end)
            end)
            coroutine.yield()
          end
        end
      end
      fzf_cb() -- EOF
    end)
  end,
  { prompt = 'Live> ' }
)
```

### <a id="fzf-live-cont-cmd">Interactive shell command</a>

If you've used `fzf.vim` or `telescope.nvim` you're probably familiar with the
concept of "live grep", where instead of feeding all lines of a project into
fzf, `rg` process is restarted with every keystroke, although fzf is very
performant the latter will be much more optimized when dealing with a large
code base.

`fzf_live` makes it super easy to run the equivalent of "live grep":
> Note you will not see any results until you start typing unless you supplied
> `query` or `exec_empty_query` as options.
```lua
:lua require'fzf-lua'.fzf_live("rg --column --line-number --no-heading --color=always --smart-case")
```

By default the query is appended (with a space) after the command string, if
you wish to have the query somewhere before EOL use `<query>` as placeholder,
the example below redirects stderr to `/dev/null` to prevent fzf from
displaying the `rg` error messages:

```lua
:lua require'fzf-lua'.fzf_live("rg --column --color=always -- <query> 2>/dev/null")
```

### <a id="fzf-live-cont-cmd-trans">Interactive shell command with transformation</a>

Similar to `fzf_exec` we can supply `fn_transform` to modify the command
output, the exmaple below utilizes fzf-lua's `make_entry` to add colored file
icons to the output:
```lua
require'fzf-lua'.fzf_live("rg --column --color=always -- <query>", {
  file_icons = true, -- Tells fzf-lua to load the file icon sets
                     -- can also be set to "mini" for "mini.icons"
  fn_transform = function(x)
    return FzfLua.make_entry.file(x, {file_icons=true, color_icons=true})
  end,
})
```

Note that the above command will fail when the query creates an invalid shell
command, for example when typing `'` or `"` the generated command will have an
"unmatched" quote and would fail. For finer control over how the new command
is formed use a `function` that returns a `string` representing the new
command:
```lua
require'fzf-lua'.fzf_live(
  function(args)
    return "rg --column --color=always -- " .. vim.fn.shellescape(args[1] or '')
  end,
  {
    fn_transform = function(x)
      return FzfLua.make_entry.file(x, {file_icons=true, color_icons=true})
    end,
    exec_empty_query = true,
    file_icons = true,
  }
)
```

> I'll leave it up to the reader to get creative with this as you can do all
> kinds of useful commands, for example `live_grep_glob` searches for ` --` in
> the query, any argument found past the separator is then reconstructed into
> the command as `--iglob=...` flags.


### <a id="fzf-live-live-rg">Example #1: "live" ripgrep</a>

Tying it all together let's create our own version of "live grep" with file
icons and git indicators:
```lua
_G.live_grep = function(opts)
  opts = opts or {}
  opts.prompt = "rg> "
  opts.file_icons = true
  opts.color_icons = true
  -- setup default actions for edit, quickfix, etc
  opts.actions = FzfLua.defaults.actions.files
  -- see preview overview for more info on previewers
  opts.previewer = "builtin"
  opts.fn_transform = function(x)
    return FzfLua.make_entry.file(x, opts)
  end
  return FzfLua.fzf_live(function(args)
    return "rg --column --color=always -- " .. vim.fn.shellescape(args[1] or '')
  end, opts)
end

-- We can use our new function on any folder or
-- with any other fzf-lua options ('winopts', etc)
_G.live_grep({ cwd = "<my folder>" })
```

### <a id="fzf-live-live-git">Example #2: "live" git-grep</a>

Another useful example would be an interactive `git grep` interface that
searches across the entire git history, this way we can find deleted code
which no longer exists in the working tree:
> See [fzf#ADVANCED](https://github.com/junegunn/fzf/blob/master/ADVANCED.md)
> to understand the breakdown of the delimiter and preview parameters
```lua
require'fzf-lua'.fzf_live(
  "git rev-list --all | xargs git grep --line-number --column --color=always <query>",
  {
    fzf_opts = {
      ['--delimiter'] = ':',
      ['--preview-window'] = 'nohidden,down,60%,border-top,+{3}+3/3,~3',
    },
    preview = "git show {1}:{2} | " ..
      "bat --style=default --color=always --file-name={2} --highlight-line={3}",
  }
)
```

## <a id="fn_transform_cmd">Customizing Grep Commands with `fn_transform_cmd`</a>

The `fn_transform_cmd` option allows for full customization of the grep command executed by fzf-lua.
This enables advanced use cases such as adjusting the command structure, modifying or augmenting arguments, or dynamically transforming input based on the raw query string.

The function receives the following arguments:

```lua
fn_transform_cmd = function(query, cmd, opts)
  return cmd, query
end
```

- `query`: the raw search string typed by the user, before any parsing or escaping
- `cmd`: the command string defined by options
- `opts`: the full options table passed into the picker

It should return:

- a new command string that will be executed
- a search query string

> [!WARNING]
> This function runs in a headless Neovim subprocess.
> Avoid using `require()` or relying on local Lua variables or closures from the main Neovim process—these will not be available and may cause hangs or errors.

### <a id="fn_transform_cmd-example-git-grep">Example: Custom glob parsing for git-grep</a>

This example demonstrates how to extend `git grep` to support glob patterns via the query string.
It parses the user's input to extract both the search query and any glob patterns separated by `--`, and transforms them into proper `git` pathspecs (including support for `:(exclude)`).

```lua
require("fzf-lua").live_grep({
  cmd = "git grep --ignore-case --extended-regexp --line-number --column --color=always --untracked",
  fn_transform_cmd = function(query, cmd, _)
    -- Extract search query and glob string separated by '--'
    local search_query, glob_str = query:match("(.-)%s-%-%-(.*)")

    if not glob_str then
      return -- Fallback to original command if no glob string
    end

    -- Convert glob string into git-compatible pathspecs
    local pathspecs = {}
    for pattern in glob_str:gmatch("%S+") do
      if pattern:sub(1, 1) == "!" then
        -- Convert '!pattern' to git's exclude pathspec
        table.insert(pathspecs, string.format("':(exclude)%s'", pattern:sub(2)))
      else
        table.insert(pathspecs, string.format("'%s'", pattern))
      end
    end

    -- Compose the final git grep command
    local new_cmd = string.format("%s %s %s", cmd, vim.fn.shellescape(search_query), table.concat(pathspecs, " "))
    return new_cmd, search_query
  end
})
```

User input example:

```
myFunction -- *.lua !*test*
```

This input would be transformed into a `git grep` command that searches for `myFunction` only in files matching `*.lua` and excluding `*test*`.

## <a id="preview-overview">Preview overview</a>

Fzf-lua supports two types of previewers, fzf native and "builtin", fzf native
previewer as its name suggests utilizes fzf's own preview window via the
`--preview` flag which runs a shell command for each item and previews the
output in the preview window.

The "builtin" previewer uses a neovim buffer inside floating window created
with the `nvim_open_win` API.

Both previewers are fundamentally different, fzf native uses fzf keybinds and
neovim previewer (you guessed it) uses neovim style binds hence the different
mappings in `defaults.keymap.builtin` and `default.keymap.fzf`.

### <a id="preview-fzf-native">Fzf native preview</a>

If you're familiar with fzf using the native previewer is pretty straight
forward and similar to the way you'd setup fzf in the shell.

Pretty much anything that's possible with fzf can be achieved with fzf-lua,
see [fzf#ADVANCED](https://github.com/junegunn/fzf/blob/master/ADVANCED.md)
for more info on how to use the preview option.

The example below lists files in the current directory and uses `cat` for
preview:

> Note that when supplying a preview command through `fzf_opts` (as opposed to
> `opts.preview`) we need to shell escape the command

```lua
-- both examples are equal
require'fzf-lua'.fzf_exec("rg --files", {
  preview = "cat {}",
  fzf_opts = { ['--preview-window'] = 'nohidden,down,50%' },
})
require'fzf-lua'.fzf_exec("rg --files", {
  fzf_opts = {
    ['--preview'] = "cat {}",
    ['--preview-window'] = 'nohidden,down,50%',
  },
})
```

What if we wanted to have a different shell command depending on the selected
item? The example below uses a lua function returning a shell command  to build
a previewer that previews media files using [`chafa`](https://github.com/hpjansson/chafa)
and all other files using `bat`: 

```lua
require'fzf-lua'.fzf_exec("rg --files", {
  fzf_opts = {
    ['--preview-window'] = 'nohidden,down,50%',
    ['--preview'] = {
      type = "cmd",
      fn = function(items)
        local ext = vim.fn.fnamemodify(items[1], ':e')
        if vim.tbl_contains({ "png", "jpg", "jpeg" }, ext) then
            return "chafa " .. items[1]
        end
        return string.format("bat --style=default --color=always %s", items[1])
      end
    }
  },
})
```

It's also possible to populate fzf's previewer with contents generated by a
lua function, the below example populates the preview with the filename but
you can creative with it (retrieve unsaved buffer contents using the neovim API, etc):

```lua
require'fzf-lua'.fzf_exec("rg --files", {
  fzf_opts = {
    ['--preview-window'] = 'nohidden,down,50%',
    ['--preview'] = function(items)
      local contents = {}
      vim.tbl_map(function(x)
          table.insert(contents, "selected item: " .. x)
      end, items)
      return contents
    end
  },
})
```

By default, `{}` is used as fzf's **FIELD INDEX EXPRESSION** which sends the current
line item in the function arguments but we can use different expressions using the
`field_index` key:

> Display prompt input in the previewer

```lua
require("fzf-lua").fzf_exec("ls", {
  preview = { field_index = "{q}", fn = function(s) return "q: "..s[1] end }
})
```

> Display all selected items (requires `fzf_opts["--multi"]`)

```lua
require("fzf-lua").fzf_exec("ls", {
  preview = { field_index = "{+}", fn = function(s) return table.concat(s, "\n") end }
})
```

### <a id="preview-nvim-builtin">Neovim "builtin" preview</a>

Neovim's "builtin" previewer (which is used by default) is a neovim buffer
inside a floating window, it's very versatile as almost anything is possible
with a bit of lua.

The builtin previewer comes with pre-configured builtin previewers that you can
use if your entires follow a specific format, the most common previewer, known as
"builtin" is capable of displaying neovim buffers, text files and even media
files (using `ueberzug` or `viu`), using any of the pre-configured previewers
is as easy as supplying the `previewer` option, the list of available
previewer names can be found under `defaults.previewers`, see 
[README.md#customization](https://github.com/ibhagwan/fzf-lua#customization)
for the full list.

The example below uses the "builtin" previewer to display files in the current
directory:
```lua
:lua require'fzf-lua'.fzf_exec("rg --files", { previewer = "builtin" })
```

Another example, live `rg` matches with lines and columns:
```lua
:lua require'fzf-lua'.fzf_live("rg --column --color=always", { previewer = "builtin" })
```

Anything else can be achieved by using the previewer API, below is a minimal example
how to extend the "buffer or file" previewer for custom entry parsing:
```lua
local fzf_lua = require("fzf-lua")
local builtin = require("fzf-lua.previewer.builtin")

-- Inherit from the "buffer_or_file" previewer
local MyPreviewer = builtin.buffer_or_file:extend()

function MyPreviewer:new(o, opts, fzf_win)
  MyPreviewer.super.new(self, o, opts, fzf_win)
  setmetatable(self, MyPreviewer)
  return self
end

function MyPreviewer:parse_entry(entry_str)
  -- Assume an arbitrary entry in the format of 'file:line'
  local path, line = entry_str:match("([^:]+):?(.*)")
  return {
    path = path,
    line = tonumber(line) or 1,
    col = 1,
  }
end

fzf_lua.fzf_exec("rg --files", {
  previewer = MyPreviewer,
  prompt = "Select file> ",
})
```

We can also populate the preview buffer with whatever content we wish by
overwriting the `populate_preview_buf` function:
```lua
local fzf_lua = require("fzf-lua")
local builtin = require("fzf-lua.previewer.builtin")

-- Inherit from "base" instead of "buffer_or_file"
local MyPreviewer = builtin.base:extend()

function MyPreviewer:new(o, opts, fzf_win)
  MyPreviewer.super.new(self, o, opts, fzf_win)
  setmetatable(self, MyPreviewer)
  return self
end

function MyPreviewer:populate_preview_buf(entry_str)
  local tmpbuf = self:get_tmp_buffer()
  vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, {
    string.format("SELECTED FILE: %s", entry_str)
  })
  self:set_preview_buf(tmpbuf)
  self.win:update_preview_scrollbar()
end

-- Disable line numbering and word wrap
function MyPreviewer:gen_winopts()
  local new_winopts = {
    wrap    = false,
    number  = false
  }
  return vim.tbl_extend("force", self.winopts, new_winopts)
end

fzf_lua.fzf_exec("rg --files", {
  previewer = MyPreviewer,
  prompt = "Select file> ",
})
```

## <a id="user-examples">User Examples</a>

### <a id="user-examples-issue-471">Explore changes from a git branch</a>

Credit to @pure-bliss who came up with the idea, described in more detail in
[#471](https://github.com/ibhagwan/fzf-lua/issues/471).

A user command, `:ListFilesFromBranch` that autocompletes branch names from
the current repo, opening the interface lists all files from a specific branch
with a preview showing the file on the specified branch (powered by
[`dandavison/delta`](https://github.com/dandavison/delta)), pressing `ctrl-v`
on a file will open a diff using
[`vim-fugitve`](https://github.com/tpope/vim-fugitive)'s `:Gvsplit`:

```lua
local list_files_from_branch_action = function(action, selected, o, args)
	local file = require("fzf-lua").path.entry_to_file(selected[1], o)
	local cmd = string.format("%s %s:%s", action, args, file.path)
	vim.cmd(cmd)
end
vim.api.nvim_create_user_command("ListFilesFromBranch", function(opts)
	require("fzf-lua").fzf_exec("git ls-tree -r --name-only " .. opts.args, {
		prompt = opts.args .. " >",
		actions = {
			["default"] = function(selected, o)
				list_files_from_branch_action("tab Gsplit", selected, o, opts.args)
			end,
			["ctrl-t"] = function(selected, o)
				list_files_from_branch_action("tab Gsplit", selected, o, opts.args)
			end,
			["ctrl-s"] = function(selected, o)
				list_files_from_branch_action("Gsplit", selected, o, opts.args)
			end,
			["ctrl-v"] = function(selected, o)
				list_files_from_branch_action("Gvsplit", selected, o, opts.args)
			end,
		},
		previewer = false,
		preview = {
			type = "cmd",
			fn = function(items)
				local file = require("fzf-lua").path.entry_to_file(items[1])
				return string.format("git show %s:%s | delta", opts.args, file.path)
			end,
		},
	})
end, {
	nargs = 1,
	force = true,
	complete = function()
		local branches = vim.fn.systemlist("git branch --sort=-committerdate --format='%(refname:short)'")
		if vim.v.shell_error == 0 then
			return vim.tbl_map(function(x)
				return x:match("[^%s%*]+"):gsub("^remotes/", "")
			end, branches)
		end
	end,
})
```

### <a id="user-examples-issue-459">Prioritize cwd when using `git_files`</a>

Credit to @acro5piano for the original idea, described in more detail in
[#459](https://github.com/ibhagwan/fzf-lua/issues/459).


When working on a large codebase it can be desirable to prioritize the current
working directory when opening `git_files`, this can be done by pre-filling
the query prompt with the current working directory therefore "boosting" the
results prefixed by `cwd`:


```lua
-- The reason I added  'opts' as a parameter is so you can
-- call this function with your own parameters / customizations
-- for example: 'git_files_cwd_aware({ cwd = <another git repo> })'
function M.git_files_cwd_aware(opts)
  opts = opts or {}
  local fzf_lua = require('fzf-lua')
  local path = require('fzf-lua.path')
  -- git_root() will warn us if we're not inside a git repo
  -- so we don't have to add another warning here, if
  -- you want to avoid the error message change it to:
  -- local git_root = fzf_lua.path.git_root(opts, true)
  local git_root = path.git_root(opts)
  if not git_root then return end
  local relative = path.relative_to(vim.loop.cwd(), git_root)
  opts.fzf_opts = { ['--query'] = git_root ~= relative and relative or nil }
  return fzf_lua.git_files(opts)
end
```

[<img src="https://user-images.githubusercontent.com/10719495/175505611-a594394c-3bcf-49bd-9f12-6f78d307f16e.gif" width="800">](https://user-images.githubusercontent.com/10719495/175505611-a594394c-3bcf-49bd-9f12-6f78d307f16e.gif)


### <a id="nvim-possession">nvim-possession</a>
[nvim-possession](https://github.com/gennaro-tedesco/nvim-possession) is a minimally invasive session manager built on top of `fzf-lua`: it includes a more elaborate example to populate the in-built previewer with a generic function of the current fzf entry:

```lua
---@param file string (the selected fzf entry)
M.session_files = function(file)
  local lines = {}
  local cwd, cwd_pat = "", "^cd%s*"
  local buf_pat = "^badd%s*%+%d+%s*"
  for line in io.lines(file) do
    if string.find(line, cwd_pat) then
      cwd = line:gsub("%p", "%%%1")
    end
    if string.find(line, buf_pat) then
      lines[#lines + 1] = line
    end
  end
  local buffers = {}
  for k, v in pairs(lines) do
    buffers[k] = v:gsub(buf_pat, ""):gsub(cwd:gsub("cd%s*", ""), ""):gsub("^/?%.?/", "")
  end
  return buffers
end

-- populate the session previewer with the aforementioned callback
M.session_previewer.populate_preview_buf = function(self, entry_str)
  local tmpbuf = self:get_tmp_buffer()
  local files = M.session_files(entry_str)

  vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, files)
  self:set_preview_buf(tmpbuf)
  self.win:update_preview_scrollbar()
end
```

[<img src="https://user-images.githubusercontent.com/15387611/215354679-fe5d2654-304c-4c0a-911a-675081291176.gif" width="800">](https://user-images.githubusercontent.com/15387611/215354679-fe5d2654-304c-4c0a-911a-675081291176.gif)

