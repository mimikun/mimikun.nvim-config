## Key bindings

### Normal mode

**Note:** your terminal may prevent capturing some of the default bindings
listed below. See `:h vimwiki-local-mappings` for suggestions for alternative
bindings if you encounter a problem.

#### Basic key bindings

- `<Leader>ww` -- Open default wiki index file.
- `<Leader>wt` -- Open default wiki index file in a new tab.
- `<Leader>ws` -- Select and open wiki index file.
- `<Leader>wd` -- Delete wiki file you are in.
- `<Leader>wr` -- Rename wiki file you are in.
- `<Enter>` -- Follow/Create wiki link.
- `<Shift-Enter>` -- Split and follow/create wiki link.
- `<Ctrl-Enter>` -- Vertical split and follow/create wiki link.
- `<Backspace>` -- Go back to parent(previous) wiki link.
- `<Tab>` -- Find next wiki link.
- `<Shift-Tab>` -- Find previous wiki link.

#### Advanced key bindings

Refer to the complete documentation at `:h vimwiki-mappings` to see many
more bindings.

## Commands

- `:Vimwiki2HTML` -- Convert current wiki link to HTML.
- `:VimwikiAll2HTML` -- Convert all your wiki links to HTML.
- `:help vimwiki-commands` -- List all commands.
- `:help vimwiki` -- General vimwiki help docs.

## Changing Wiki Syntax

VimWiki currently ships with 3 syntaxes: VimWiki (default), Markdown
(markdown), and MediaWiki (media).  Of these, the native VimWiki syntax is
best supported, followed by Markdown.  No promises are made for MediaWiki.

**NOTE:** Only the default syntax ships with a built-in HTML converter. For
Markdown or MediaWiki see `:h vimwiki-option-custom_wiki2html`. Some examples
and 3rd party tools are available
[here](https://vimwiki.github.io/vimwikiwiki/Related%20Tools.html#Related%20Tools-External%20Tools).

If you would prefer to use either Markdown or MediaWiki syntaxes, set the
following option in your `.vimrc`:

```vim

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]

```

This option will treat all markdown files in your system as part of vimwiki
(check `set filetype?`). Add

```vim
let g:vimwiki_global_ext = 0
```

to your `.vimrc` to restrict Vimwiki's operation to only those paths listed in
`g:vimwiki_list`.  Other markdown files wouldn't be treated as wiki pages.
See [g:vimwiki_global_ext](https://github.com/vimwiki/vimwiki/blob/619f04f89861c58e5a6415a4f83847752928252d/doc/vimwiki.txt#L2631).

if you want to turn off support for other extension(for example, disabling
accidently creating new wiki and link for normal markdown files), set the
following option in your `.vimrc` before packadd vimwiki: 

```vim
let g:vimwiki_ext2syntax = {}
```

See [g:vimiki_ext2syntax](https://github.com/vimwiki/vimwiki/blob/619f04f89861c58e5a6415a4f83847752928252d/doc/vimwiki.txt#L2652)

