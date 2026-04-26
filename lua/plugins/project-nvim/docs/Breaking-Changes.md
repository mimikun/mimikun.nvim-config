## 2025/09/25

The `:ProjectDelete` command has been reworked. If no args are given to the user command, the following popup will appear:

![Popup](https://github.com/user-attachments/assets/5f2a1310-3cd4-4474-9b70-8f9f241dd90d)

Otherwise, it's all the same.

---

## 2025/09/24

[`a5c0904`](https://github.com/DrKJeff16/project.nvim/commit/a5c09047d7068d504dc200d1ece73f93da7e8b48) `:ProjectRecents` has been dropped.

For some God forsaken reason using `:ProjectRecents` would somehow loop the program, freezing Neovim entirely.
I tried looking through all sorts of logs to no avail.

It was only the User Command itself, by the way. None of the underlying components that I could identify were responsible.

_I'm bewildered, to say the least._

_Since this is a SERIOUS issue, I had no other choice but to delete that user command_.
**Either way, recent projects will still show up when running `:checkhealth project`**.

---

## 2025/09/22

The `setup()` option for enabling logging has been reworked:

```lua
-- BEFORE
require('project').setup({
  logging = true,
})

-- AFTER
require('project').setup({
  log = {
    enabled = true,
  },
})
```

---

## 2025/09/21

Due to issue [#18](https://github.com/DrKJeff16/project.nvim/issues/18) `fzf-lua` integration is now enabled in `setup()`.

> [!TIP]
> See `:h Project.Config.FzfLua` for more info.

---

<div align="center">

~**<== Previous Entry**~ | [**Index**](https://github.com/DrKJeff16/project.nvim/wiki) | [**Next Entry ==>**](https://github.com/DrKJeff16/project.nvim/wiki/Keymaps)

</div>