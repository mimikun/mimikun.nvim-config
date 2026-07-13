# Fonts

## Preface

I am no expert on font rendering and some of the details below are likely oversimplified.
If you find anything to be inaccurate or misleading please let me know!

The goal is to provide a quick reference to all neovim users, though more likely
newer ones, to solve issues related to missing or bad looking icons in terminals.
If you just want to unblock yourself and already know all you want to about fonts
and rendering then focus on the [Troubleshooting](#troubleshooting) section. Otherwise
I encourage you to checkout some of the other sections as well.

> [!NOTE]
> I use the word terminal to mean terminal emulator, the latter is more correct
> but also no one uses a terminal so the distinction seem unnecessary.

This is an early version and will be updated based on feedback.

## Troubleshooting

In order to use the tables below you need to know 3 pieces of information:

1. What problem you are facing with icons:
    - Missing �: Icons are either clearly wrong or missing so rendered as a �.
    - Too Small: Icons are smaller than you want and are hard to see.
    - Too Large: Icons are larger than you want and look squished.
2. The terminal you are using:
    - [Alacritty](https://alacritty.org/)
    - [Ghostty](https://ghostty.org/)
    - [kitty](https://sw.kovidgoyal.net/kitty/)
    - [WezTerm](https://wezfurlong.org/wezterm/index.html)
3. The type of font your terminal is using:
    - Nerd Normal: Standard Nerd Font, the name ends with "Nerd Font". For example
      "JetBrainsMono Nerd Font".
    - Nerd Mono: Monospaced symbol variant of a Nerd Font, the name ends with
      "Nerd Font Mono". For example "JetBrainsMono Nerd Font Mono". Notice the second
      "Mono", that is the important part.
    - Base: Any font that is not a Nerd Font. Probably the case if you have not
      configured a font for your terminal.

If your situation is not covered by these please reach out!

Once you know all that, you can get to the solution. Use the table associated with
your problem and go from there. Examples:

- Missing � + Alacritty + Nerd Normal = ✅ [Font -> Nerd](#font-nerd)
- Too Large + kitty     + Nerd Mono   = ✅ [Font -> Base](#font-base)
- Too Small + WezTerm   + Base        = ✅ [Wez Glyphs](#wez-glyphs) Grow

This process can be iterative where after making a change you still do not like
the output. Continue from the top each time and make sure to update your situation
based on any changes you've made.

### Problems

#### Missing �

| Terminal / Font | Base                          | Nerd Normal                    | Nerd Mono                      |
| --------------- | ----------------------------- | ------------------------------ | ------------------------------ |
| Alacritty       | ✅ [Font -> Nerd](#font-nerd) | ✅ [Font -> Nerd](#font-nerd)  | ✅ [Font -> Nerd](#font-nerd)  |
| Ghostty         | ❓ [Always Find](#always-find)| ❓ [Always Find](#always-find) | ❓ [Always Find](#always-find) |
| kitty           | ❓ [Always Find](#always-find)| ❓ [Always Find](#always-find) | ❓ [Always Find](#always-find) |
| WezTerm         | ❓ [Always Find](#always-find)| ❓ [Always Find](#always-find) | ❓ [Always Find](#always-find) |

- ✅ = Potential Fix
- ❌ = No Fix
- ❓ = Impossible

#### Too Small

| Terminal / Font | Base                                      | Nerd Normal                   | Nerd Mono                        |
| --------------- | ----------------------------------------- | ----------------------------- | -------------------------------- |
| Alacritty       | ❓ [Never Find](#never-find)              | ❌ [Size Limit](#size-limit)  | ✅ [Font Variant](#font-variant) |
| Ghostty         | ✅ [Ghostty Symbols](#ghostty-symbols)    | ✅ [Font -> Base](#font-base) | ✅ [Font -> Base](#font-base)    |
| kitty           | ✅ [Kitty Symbols](#kitty-symbols) Normal | ✅ [Font -> Base](#font-base) | ✅ [Font -> Base](#font-base)    |
| WezTerm         | ✅ [Wez Glyphs](#wez-glyphs) Grow         | ✅ [Font -> Base](#font-base) | ✅ [Font -> Base](#font-base)    |

- ✅ = Potential Fix
- ❌ = No Fix
- ❓ = Impossible

#### Too Large

| Terminal / Font | Base                                    | Nerd Normal                      | Nerd Mono                     |
| --------------- | --------------------------------------- | -------------------------------- | ----------------------------- |
| Alacritty       | ❓ [Never Find](#never-find)            | ✅ [Font Variant](#font-variant) | ❌ [Size Limit](#size-limit)  |
| Ghostty         | ✅ [Ghostty Symbols](#ghostty-symbols)  | ✅ [Font -> Base](#font-base)    | ✅ [Font -> Base](#font-base) |
| kitty           | ✅ [Kitty Symbols](#kitty-symbols) Mono | ✅ [Font -> Base](#font-base)    | ✅ [Font -> Base](#font-base) |
| WezTerm         | ✅ [Wez Glyphs](#wez-glyphs) Shrink     | ✅ [Font -> Base](#font-base)    | ✅ [Font -> Base](#font-base) |

- ✅ = Potential Fix
- ❌ = No Fix
- ❓ = Impossible

### Solutions

#### Always Find

<details>

<summary>Show Details</summary>

Situation:

- Terminal: does support [Font Fallback](#font-fallback)
- Font: N/A
- Problem: icons are missing

This is unexpected since any icons not supported by your font should be handled
by the fallback which searches through system and bundled fonts to see if any can
render the icon. If you encounter this let me know!

</details>

#### Font Base

<details>

<summary>Show Details</summary>

Situation:

- Terminal: does support [Font Fallback](#font-fallback)
- Font: some Nerd Font
- Problem: icons render but don't look great

Using a Nerd Font when the terminal supports font fallback is unnecessary since
the fallback should handle all icons without a Nerd Font. It is also discouraged,
see [Patched Nerd Fonts](#patched-nerd-fonts).

Before working on anything related to how icons look the first thing to do is change
the terminal font to any Base Font. This means any font so long as it is not a Nerd
Font, give Comic Sans a try. You can install a new font if you want as long as it
is not a Nerd Font. The name should not contain "Nerd Font".

The goal is to have the terminal resolve icons for you using the fallback mechanism
rather than using icons that are part of your main font. This will give more control
over changing how icons are displayed as well.

This will likely change how the icons look and could fix the problem on its own.

</details>

#### Font Nerd

<details>

<summary>Show Details</summary>

Situation:

- Terminal: does not support [Font Fallback](#font-fallback)
- Font: N/A
- Problem: icons are missing

Missing icons mean that they are missing from the font you are using. The fix is
to find a font that supports them and set that as your terminal's font.

If you're not using a Nerd Font then you'll need to start using one. If you're already
using a Nerd Font then you'll need to try other ones since it is not the case that
all Nerd Fonts contain all icons. To install a Nerd Font:

1. Download a Nerd Font: A popular one is `JetBrainsMono Nerd Font` but any of them
   should work, pick the one you like. You can do this using:
    - [homebrew](https://formulae.brew.sh/cask/font-jetbrains-mono-nerd-font)
    - Your favorite package manager, instructions vary, please Google / LLM
    - [website](https://www.nerdfonts.com/font-downloads)
2. Install the Nerd Font: This depends on your OS and could involve moving a file
   to a directory, running some command, or is handled by your package manager like
   with `homebrew`. You need the font to be visible, Google / LLM should help here.
3. Set the Nerd Font in your Terminal: How to set the font depends on the terminal,
   could be under a settings panel, or a configuration file. A search for "<terminal>
   font config" should get you there.
    - After installing the font you'll have multiple variants available, such as
      `JetBrainsMono Nerd Font` and `JetBrainsMono Nerd Font Mono`. Any of these
      is fine to use, try both, the former tends to be more common.

</details>

#### Font Variant

<details>

<summary>Show Details</summary>

Situation:

- Terminal: does not support [Font Fallback](#font-fallback)
- Font: some Nerd Font
- Problem: icon size

Different Nerd Font variants have different sized icons:

- Normal: has larger icons, example "JetBrainsMono Nerd Font"
- Mono: has smaller icons, example "JetBrainsMono Nerd Font Mono"

It is likely when you installed your Nerd Font it came with both variants
so the fix is to swap the variant your terminal is using.

- Normal -> Mono: icons should get smaller
- Mono -> Normal: icons should get larger

If your font did not come with the other variant for some reason, you'll
need to find and download it, or use a new Nerd Font.

</details>

#### Ghostty Symbols

<details>

<summary>Show Details</summary>

By adjusting the fallback font used for symbols you can adjust the size at which
they are rendered to some extent. From what I've found the best result comes from
using `Symbols Nerd Font Mono` as the fallback for your base font, example config:

```
font-family = Monaspace Neon
font-family = Symbols Nerd Font Mono
```

I have not found a way to get larger symbols than this. Once you've set this up
you can tune the size using the [adjust-icon-height](https://ghostty.org/docs/config/reference#adjust-icon-height)
option to reduce the size.

</details>

#### Kitty Symbols

<details>

<summary>Show Details</summary>

Set the font for the `symbol_map` described [here](https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font)
to either a Normal Nerd Font or a Mono Nerd Font as specified.

</details>

#### Never Find

<details>

<summary>Show Details</summary>

Situation:

- Terminal: does not support [Font Fallback](#font-fallback)
- Font: some Base Font
- Problem: icons render but don't look great

This is an unexpected situation since non Nerd Fonts should be missing all the niche
icons and result in some default being rendered, such as �. If you encounter this
let me know!

</details>

#### Size Limit

<details>

<summary>Show Details</summary>

When a Nerd Font is created from a Base Font the author typically creates multiple
variants. We've labelled these as Nerd Normal and Nerd Mono, below is a comparison.

|            | Nerd Normal | Nerd Mono |
| ---------- | ----------- | --------- |
| Icon Width | Double      | Single    |
| Icon Size  | Larger      | Smaller   |
| Monospaced | ❌          | ✅        |

Some terminals can use the larger icons from Nerd Normal when there is space.

A consequence of the above is that if you're using the Normal variant you cannot
get bigger icons. Similarly if you're using the Mono variant you cannot get smaller
icons. If you find an exception or there is a way around this let me know!

- I found that for `SymbolsNerdFont` this is not the case and the Mono variant is
  larger than the Normal variant, but this seems like an exception?

</details>

#### Wez Glyphs

<details>

<summary>Show Details</summary>

There are 2 levers we can pull to Grow or Shrink icons:

1. Overflow
    - Controlled by: [allow_square_glyphs_to_overflow_width](https://wezfurlong.org/wezterm/config/lua/config/allow_square_glyphs_to_overflow_width.html)
    - Whether icons are allowed to expand outside of their cells
2. Scaling
    - Controlled by: [font_with_fallback scale](https://wezfurlong.org/wezterm/config/lua/wezterm/font_with_fallback.html#manual-fallback-scaling)
    - A factor by which icons are transformed before being displayed

To Grow icons enable overflow:

```lua
config.allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace'
```

- This is the default value so this is more of a sanity check that you did not disable
  this option, you can also set it explicitly if you like.

To Shrink icons disable overflow:

```lua
config.allow_square_glyphs_to_overflow_width = 'Never'
```

At this point update the config, save, and check the size of the icons to see if
you like the result. If you do, then you're done.

Otherwise try scaling, replace the `<scale>` placeholder with:

- Grow: a value > 1.0, start with 1.1 and adjust from there
- Shrink: a value < 1.0, start with 0.9 and adjust from there

```lua
config.font = wezterm.font_with_fallback({
    { family = '<your_current_font>' },
    { family = 'Symbols Nerd Font Mono', scale = <scale> },
})
```

</details>

## Background

So you downloaded neovim and picked up a few plugins, nice! Then you open up your
new file tree from [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
or take a look at your status line from [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
or try an awesome markdown renderer :) and you notice the dreaded �, what's going
on?

Well, like many people, up until now you only needed your terminal to display letters,
numbers, and basic symbols you find on your keyboard. So your font, which likely
only implements these basic characters wasn't a problem. Now you want to display
complex icons / glyphs which leads to this problem. When your font doesn't implement
a particular icon your terminal (WezTerm, kitty, Alacritty, iTerm2, etc.) won't
know how to display it. As a last resort it will pickup some default icon that it
can render, like �, and show that to you. At this point might have some questions,
it's a good time to browse the [FAQs](#faqs) before moving on.

## Patched Nerd Fonts

Patched Nerd Fonts are generated by taking some existing font, like `JetBrains Mono`,
and filling all the "gaps" with a set of common icons. This creates a new font in
this case named `JetBrainsMono Nerd Font` These will typically come with multiple
variants of the font, like a version with single width icons (by default icons are
double width) named `JetBrainsMono Nerd Font Mono`. A useful discussion about the
variants [here](https://github.com/ryanoasis/nerd-fonts/discussions/969). You can
also create your own for any font using the patch script provided at the bottom
of their [website](https://www.nerdfonts.com/).

Having the font include all of the icons is convenient for terminals since they
can avoid doing anything clever like [Font Fallback](#font-fallback) which avoids
a lot of complexity and effort. Instead user's configure a font and that font either
has the icon or it doesn't.

While this is a convenient solution, if you can avoid using Patched Nerd Fonts it
will generally lead to a better experience. You can avoid this if your terminal
supports a feature like font fallback, a way to resolve missing icons by using multiple
fonts and putting them together. If your terminal does not support such a feature
and you do not want to or cannot change to one that does then Patched Nerd Fonts
are really your only solution to getting icons. This is why they are important and
will continue to be necessary, they are a good solution to a very real problem.

The reasons to avoid Patched Nerd Fonts when possible are:

- Since the icons won't change every time you change fonts you only need to worry
  about getting them to look how you want once.
- Changing your font no longer requires finding or creating a patched version
- You can rely on the base font directly from the author, rather than a generated
  version which is updated, maintained, and distributed entirely separately
- More control over icon rendering, i.e. WezTerm's font scale feature is set per
  font family so the Symbol font can be scaled separate from the text font. If they
  all came from the same font they would be scaled together.

## Font Fallback

Font fallback is a mechanism terminals can build which allows them to use multiple
fonts when rendering icons. The fonts can include all the ones installed on your
system as well as ones bundled with the terminal by the author.

The complexity of joining glyphs from separate fonts and making it look cohesive
is not trivial and likely why not all terminals support this. Once the work is done
you end up with a robust and consistent font rendering experience.

When you configure a font for these terminals all you're really doing is specifying
one as the first to check. By doing this all the characters supported by that will
be used with any gaps filled on the fly.

By bundling a few catch all fonts to handle icons these terminals can avoid ever
needing to display a default like � ever. This allows users to avoid doing anything
special to get icons, they just kind of work. These bundled fonts typically include:

- `SymbolsNerdFontMono`: the opposite of a "normal" font in that it only contains
  the niche icons and no standard letters / numbers
- `Noto Color Emoji`: support for emojis

The specific bundled fonts and the behavior of the fallback will depend on the terminal's
implementation. There are some unique symbols that may require downloading additional
fonts to your system like:

- [FlogSymbols](https://github.com/rbong/flog-symbols)

Below is an incomplete table of terminals that do and do not implement font fallback:

| Terminal  | Font Fallback |
| --------- | ------------- |
| Alacritty | ❌            |
| Ghostty   | ✅            |
| kitty     | ✅            |
| WezTerm   | ✅            |

## FAQs

### Why doesn't my font have all the icons?

This is a very niche problem that most fonts don't need to solve. These missing
icons are most likely what are referred to as [Nerd Font Icons](https://www.nerdfonts.com/cheat-sheet),
and there are over 10,000 of them.

The idea of every font shipping with implementations for all of them is crazy if
you think about it. Who out there using Comic Sans in Word is trying to inline
the GitHub logo as text? If font authors went through the trouble of making unique
icons it would be an insane amount of work for a small portion of users. If they
shared the same icons and kept the font part unique all fonts would get much bigger.
Maybe not much of a problem now but still wasteful and extra effort.

GUI applications do not come with the same set of limitations as a terminal. They
can render an image no problem. Terminals on the other hand are largely a grid
where we can paint some pixels in each cell. We've essentially taken some UTF-8
encodings and mapped them to cool looking icons using the power of fonts.

### But I didn't add any icons?

Well maybe not directly, but some plugin you're using probably did. Somewhere in
the code for the plugin you'll find the UTF-8 encoded character that represents
the icon your font is missing.

### Why do we need fancy icons, this is a terminal?

You're technically correct, we do it for the aesthetic :P I'll add that icons, when
used effectively, can give you a lot of information at a glance. With file trees
for instance they will tell you what's a folder and the type of each file, once
you know what you're looking at. It's likely a bit of both and it's reasonable to
want things to look nice in an environment you spend hours a day in.

The purist may disagree, and the purist is free to use something else or write it
themselves.

### Can I use different font sizes for different parts of the screen?

No, this is not possible in any terminal that I am aware of. I'm not really sure
where the fundamental limitation is. Terminals have been grids since their inception,
but in theory this is not mandatory. Though I do not believe there are any ANSI
sequences that exist that would allow text size information to be communicated to
the terminal. Maybe one day ANSI sequences will be added, terminals will be updated,
and clients like neovim will add support, or maybe there's more challenges involved,
or maybe it's not that important. In any case for now this doesn't exist.

> [!NOTE]
> Kitty might soon add support for this, very cool!
> https://github.com/kovidgoyal/kitty/issues/8226
