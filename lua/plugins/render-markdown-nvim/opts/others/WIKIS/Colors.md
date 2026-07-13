# Colors

I've found that there is generally some confusion for how colors work in neovim.
In particular when it comes to plugin users wanting to modify some specific part
of the UI. While there is some background and complexity involved here, what's great
is once you have a handle of these concepts you'll always know what your options
are and what the impact will be.

The goal of this document is to explain these concepts from the ground up making
as few assumptions as possible of the reader's prior knowledge on this topic and
providing existing references when appropriate.

If you want to skip the background information and just get to what you can do then
go straight to [Customization](#customization).

If you find anything inaccurate please let me know!

## Highlight Groups

The first important topic to cover is how colors are defined. Rather than directly
using hex values like `#ff0000` or names like `red` and applying these to ranges
of text the colors are abstracted behind what is called a Highlight Group, see
`:h highlight-groups`.

A Highlight Group is a string that is mapped to a variety of display properties.
These properties include the hex codes / names for the foreground & background, as
well as whether the text should be bold, italicized, etc., see `:h nvim_set_hl()`
for a complete list of properties and `:h gui-colors` for an incomplete list of color
names. Highlight Groups can also be linked to other Highlight Groups, which simply
means use the value of this other one instead, this linking is really powerful and
will be covered in more detail later.

You can run the `:highlight` command to see all the Highlight Groups currently defined
in neovim along with their values. These definitions will come largely from your
color scheme as well as individual plugins.

The `:h treesitter-highlight` doc does an excellent job giving an end to end example
of how ranges of code end up assigned to specific Highlight Groups. The only additional
information I would add is that in the most common case parsers for languages and
highlights.scm being on your runtimepath is done by [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter),
and is not something you manage directly, though you definitely could.

Once we have ranges of text assigned to Highlight Groups we move on to the part that
makes color schemes work. The key part is that Highlight Group names are somewhat
standardized and refer to the same concept across languages, see `:h treesitter-highlight-groups`.
So the `@comment` Highlight Group will be used for code comments in python, rust,
etc. As a result if a color scheme implements all the Highlight Groups defined in
the treesitter document it should provide a consistent experience across all languages.
You can imagine if these Highlight Group names were languages specific the amount
of work required by color scheme authors would be much higher. As a result these
highlight.scm files end up being very important and key to the whole experience.

## Plugins

While we've covered Highlight Groups in the context of adding color to code they
are used for everything else as well. Plugins need to use Highlight Groups to add
color to the UI, there is no other mechanism.

Plugin authors will typically follow a practice of defining their own Highlight Groups
for most things that have color. However they will not define the hex values directly
as the UI would effectively ignore your preferences and use the same coloring for
everyone.

Instead they will create "default links" under some unique prefix. What this means
is they will create highlights by calling the following API:

```lua
vim.api.nvim_set_hl(0, 'MyPluginBackground', { link = 'Normal', default = true })
```

This `default` being true means if this Highlight Group already exists then don't
change it, keep its current value. In practice this means that individual color schemes
can implement specific behaviors for individual plugins if they want to and do not
like the result out of the box with their color scheme. Since they should be loaded
before other plugins their custom values will be kept. However if no value is defined
then link to this other Highlight Group, which is usually one of the standard set
and should be defined by all color schemes. The Highlight Groups defined for the
plugin should be clearly visible in the documentation, but that's up to the author.

This might sound overly complex, why not just use the link value `Normal` directly,
why wrap it? Well changing the value of the `Normal` Highlight Group to make one
plugin look nicer would be kind of absurd. This linking lets the impact of the change
be targeted, rather than impacting how everything looks.

However since there are no enforcement mechanisms plugins do not have to adopt this
approach and color schemes don't have to implement the entire standard set of Highlight
Groups. This can lead to inconsistent and less than ideal default, but usually works
well enough in practice.

## Customization

With that context built up we can now work on changing the color of something. Lets
say we want to change the color of the background used by a plugin.

Lets also say that value is something you can provide via its configuration, so the
default configuration is something like:

```lua
{
    'PluginAuthor/my-plugin.nvim',
    config = function() 
        require('my-plugin').setup({
            background = 'MyPluginBackground',
        })
    end,
}
```

And `MyPluginBackground` links to `Normal` by default.

Figuring out this information per plugin is not consistent. Ideally it's not hidden
and somewhere like the README has the default configuration and Highlight Groups
spelled out with descriptions, but this is not always the case. Also this approach
of links and configuration is somewhat common but by no means applies in all cases.

With this setup there are two ways to change the color:

### 1) Change Highlight Group Used

This requires the plugin to expose the Highlight Group as an option you can set.
If it does not then this option is not possible.

You'll need to find or create a Highlight Group with the color that you want to use
instead, use the `:highlight` command to help you find one. It is good to note that
if this is a common highlight group changing color schemes will change the color,
which could be a good or bad thing, up to you.

From there update the configuration, lets say we chose `Visual`:

```lua
{
    'PluginAuthor/my-plugin.nvim',
    config = function() 
        require('my-plugin').setup({
            background = 'Visual',
        })
    end,
}
```

### 2) Change Highlight Group Value

To do this use the `vim.api.nvim_set_hl` API to change the value associated with
`MyPluginBackground`. With this approach you don't modify the configuration but you
do need to run the logic at a specific point in time depending on whether the plugin
sets `default` to true when creating Highlight Groups:

- Yes: Before calling setup so your value gets picked up
- No: After calling setup so you override their value

You also have several types of values you can set:

#### 1) Hard Code

This involves setting a concrete hex value or color name for the Highlight Group.
This color will not change when the color scheme is changed.

```lua
{
    'PluginAuthor/my-plugin.nvim',
    config = function() 
        vim.api.nvim_set_hl(0, 'MyPluginBackground', { bg = '#ff0000' })
        -- Or: vim.api.nvim_set_hl(0, 'MyPluginBackground', { bg = 'red' })
        require('my-plugin').setup({})
        -- Move here if default is not set
    end,
}
```

#### 2) Link

This is similar to changing the Highlight Group in the configuration but works even
if there is no option provided. It is also functionally equivalent in that the color
will change based on the color scheme.

```lua
{
    'PluginAuthor/my-plugin.nvim',
    config = function() 
        vim.api.nvim_set_hl(0, 'MyPluginBackground', { link = 'Visual' })
        require('my-plugin').setup({})
        -- Move here if default is not set
    end,
}
```

#### 3) Underlying Link Value

This involves overriding the Highlight Group being linked to. This is not recommended
as it will likely have far reaching impact beyond a specific plugin but is given
as an option for completeness. This is also your only option if the Highlight Group
being used is not configurable and not created as a link, but instead a default Highlight
Group is used directly.

```lua
{
    'PluginAuthor/my-plugin.nvim',
    config = function() 
        -- Ideally you run this right after your color scheme is setup
        -- or use an override provided by the color scheme itself
        vim.api.nvim_set_hl(0, 'Normal', { bg = '#ff0000' })
        require('my-plugin').setup({})
        -- Non color scheme plugins should never set values for default
        -- Highlight Groups so the value of default does not matter
    end,
}
```
