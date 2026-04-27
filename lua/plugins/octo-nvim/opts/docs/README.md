## 🍞 Completion

### nvim-cmp

https://github.com/hrsh7th/nvim-cmp
https://github.com/petertriho/cmp-git
https://github.com/hrsh7th/cmp-emoji

### blink.cmp

https://github.com/Saghen/blink.cmp
https://github.com/Kaiser-Yang/blink-cmp-git
https://github.com/moyiz/blink-emoji.nvim


## 🙋 FAQ

### Why am I getting authentication error from gh? Part 2

It is possible that Octo is trying to authenticate against the origin listed in your repository's config (.git/config) which _could be_ an _ssh alias_ to _github.com_.
To properly let octo.nvim know about the ssh alias, you need to list it in the config per above.
Example:

```lua
require('octo').setup({
  ssh_aliases = {["<THE ALIAS YOU HAVE LISTED IN ~/.ssh/config>"] = "github.com"}
})
```

### How to enable autocompletion for issues/prs (`#`) and users (`@`)?

Add the following mappings for `octo` file type:

- `vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })`
- `vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })`

