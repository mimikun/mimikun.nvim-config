## Relevant Changes

- Due to [Discussion #5](https://github.com/DrKJeff16/project.nvim/discussions/5) I have decided to rename the module from `project_nvim` to `project`
- I renamed `lua/project_nvim/project.lua` to `lua/project/api.lua` to avoid confusion and to extend that file like an API

---

This very simple guide should be of use if you're migrating from the OG `project.nvim`.

> [!TIP]
> The process should be simple, really.
> In your setup, just modify your `require('project_nvim')` statements accordingly.

## lazy.nvim

```lua
-- ORIGINAL PLUGIN
{
  'ahkmedhalf/project.nvim',
  -- ...
  config = function()
    require('project_nvim').setup(...)
  end,
}

-- THIS PLUGIN
{
  'DrKJeff16/project.nvim',
  -- ...
  opts = {
    -- ...
  },
}
```

> [!TIP]
> If you'd rather stick to using the `config` field:
>
> ```lua
> {
>   'DrKJeff16/project.nvim',
>   config = function()
>     require('project').setup(...)
>   end,
> }
> ```

---

<div align="center">

[**<== Previous Entry**](https://github.com/DrKJeff16/project.nvim/wiki/Keymaps) | [**Index**](https://github.com/DrKJeff16/project.nvim/wiki) | [**Next Entry ==>**](https://github.com/DrKJeff16/project.nvim/wiki/Tips-And-Tricks)

</div>