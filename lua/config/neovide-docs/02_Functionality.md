### Functionality

#### Refresh Rate

```lua
vim.g.neovide_refresh_rate = 60
```

Setting `g:neovide_refresh_rate` to a positive integer will set the refresh rate of the app. 
This is limited by the refresh rate of your physical hardware, but can be lowered to increase battery life.

This setting is only effective when not using vsync, for example by passing `--no-vsync` on the commandline.

#### Idle Refresh Rate

```lua
vim.g.neovide_refresh_rate_idle = 5
```

**Available since 0.10.**

Setting `g:neovide_refresh_rate_idle` to a positive integer will set the refresh rate of the app when it is not in focus.

This might not have an effect on every platform (e.g. Wayland).

#### No Idle

```lua
vim.g.neovide_no_idle = true
```

Setting `g:neovide_no_idle` to a boolean value will force neovide to redraw all the time.
This can be a quick hack if animations appear to stop too early.

#### Confirm Quit

```lua
vim.g.neovide_confirm_quit = true
```

If set to `true`, quitting while having unsaved changes will require confirmation. 
Enabled by default.

#### Detach On Quit

Possible values are `always_quit`, `always_detach`, or `prompt`. 
Set to `prompt` by default.

```lua
vim.g.neovide_detach_on_quit = 'always_quit'
```

This option changes the closing behavior of Neovide when it's used to connect to a remote Neovim instance. 
It does this by switching between detaching from the remote instance and quitting Neovim entirely.

#### Fullscreen

```lua
vim.g.neovide_fullscreen = true
```

Setting `g:neovide_fullscreen` to a boolean value will set whether the app should take up the entire screen. 
This uses the so called "windowed fullscreen" mode that is sometimes used in games which want quick window switching.

#### Simple Fullscreen (MacOS only)

```lua
vim.g.neovide_macos_simple_fullscreen = true
```

**Available since 0.15.1.**

Setting `neovide_macos_simple_fullscreen` will hide the dock and menu bar for MacOS.

This won’t work if the window was already in the native fullscreen.

#### Remember Previous Window Size

```lua
vim.g.neovide_remember_window_size = true
```

Setting `g:neovide_remember_window_size` to a boolean value will determine whether the window size from the previous session or the default size will be used on startup. 
The commandline option `--size` will take priority over this value.

#### Profiler

```lua
vim.g.neovide_profiler = false
```

Setting this to `v:true` enables the profiler, which shows a frametime graph in the upper left corner.

#### Cursor hack

```lua
vim.g.neovide_cursor_hack = true
```

Prevents the cursor from flickering to the command line when it shouldn't. 
This will be disabled by default when Neovim properly sends the UI busy events and the hack is no longer needed. 
NOTE: In some cases the hack itself is buggy and prevents the cursor from moving to the command line when it should. 
In that case you can try to disable it, especially if you are not using cursor animations and the flickering does not bother as much.

#### Highlight Matching Pair (macOS only)

```lua
vim.g.neovide_highlight_matching_pair = true
```

**Available since 0.16.0.**

When enabled, Neovide highlights the matching pair using the system find indicator. 
The default is `false`.

#### Window Proxy Icon (macOS only)

```lua
vim.g.neovide_proxy_icon = true
```

When set to `true` Neovide exposes the current file as a native macOS window proxy icon in the title bar and reflects the current buffer's modified state through the standard document-edited indicator.

Note: recommended setup is `--frame full` with titles enabled for a cleaner look.

