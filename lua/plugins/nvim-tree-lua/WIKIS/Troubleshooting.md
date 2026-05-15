# "Clean Room" Replication

Other plugins or automation may be interfering with nvim-tree.

It can be very useful to attempt to replicate an issue with a minimal configuration with nvim-tree only, using defaults.

1. Download [nvt-min.lua](https://raw.githubusercontent.com/nvim-tree/nvim-tree.lua/master/.github/ISSUE_TEMPLATE/nvt-min.lua) to `/tmp`
1. Run neovim with `nvim -nu /tmp/nvt-min.lua`
1. Add nvim-tree configuration to `setup` to replicate the issue
1. Add other plugins and automation as needed to replicate

When raising a bug, please include the contents of your modified `nvt-min.lua`

# Troublesome Plugins

You may experience an issue with your full configuration and plugins that cannot be reproduced in a clean room.

You can use binary search method to find the culprit quickly: disable half of your plugins and rerun reproduction steps. If you can reproduce still it means that one of active plugins causes the issue. Then disable half of remaining plugins and try again.

# Diagnostic Logging

You may enable diagnostic logging to nvim's log standard-path. See `:help nvim-tree.log` and `:help standard-path`.

This is usually `${XDG_STATE_HOME}/nvim/nvim-tree.log` on Linux, and `~\AppData\Local\Temp\nvim` on Windows. Use `:echo stdpath("log")` to confirm the location on your system.

# Performance Issues

If you are experiencing performance issues please enable profiling.

It is advisable to enable git logging at the same time, as that can be a source of performance problems.

```lua
log = {
  enable = true,
  truncate = true,
  types = {
    all = false,
    config = false,
    copy_paste = false,
    dev = false,
    diagnostics = true,
    git = true,
    profile = true,
    watcher = true,
  },
},
```

Please attach `${XDG_STATE_HOME}/nvim/nvim-tree.log` if you raise an issue.

# Performance Tips

## Fish

If you are using fish as an editor shell (which might be fixed in the future), try set `shell=/bin/bash` in your vim config. Alternatively, you can [prevent fish from loading interactive configuration in a non-interactive shell](https://github.com/nvim-tree/nvim-tree.lua/issues/549#issuecomment-1127394585).

## Git Timeouts

Huge git repositories may timeout after the default `git.timeout` of 400ms.

You will see "5 git jobs have timed out after git.timeout 400ms, disabling git integration." and `[git] job timed out` in the logs.

Manually run and time the git command (see the logs) in your shell e.g. `time git --no-optional-locks status --porcelain=v1 --ignored=matching -u` to see how long git itself takes. The last metric (total elapsed) is the key.

Increase the timeout as needed: `:help nvim-tree.git.timeout`

## Git fsmonitor Daemon

MacOS and some Windows users may enable git's file system monitor daemon to greatly improve performance. See [Improve Git monorepo performance with a file system monitor](https://github.blog/2022-06-29-improve-git-monorepo-performance-with-a-file-system-monitor/).

Unfortunately this is not available for Linux.

Enable for your repo:

```sh
git config core.fsmonitor true
git config core.untrackedcache true
```

## Ignore Large Directories

There may be a directory in your tree with a huge number of files that are frequently created, updated and deleted. A common example is `node_modules`.

Filesystem watchers and git will choke on such directories, resulting in seconds long operations.

Ignore these e.g.:

```lua
filesystem_watchers = {
  ignore_dirs = {
    "node_modules",
  },
},
```

# Icons Not Correctly Shown

Your terminal emulator must be configured to use the [patched font](https://www.nerdfonts.com/) such as "Hack Nerd Font".

You might find that the icons are the incorrect size or cut off. There are sometimes multiple variants of hack fonts; experiment with each e.g. `Hack Nerd Font` vs `Hack Nerd Font Mono`

## Linux

The patched font can be configured as the default monospace font, which terminal emulators, browsers etc. will likely use. See [Font configuration](https://wiki.archlinux.org/title/Font_configuration) for further information.

Example `~/.config/fontconfig/fonts.conf`

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <alias>
        <family>monospace</family>
        <prefer>
            <family>Hack Nerd Font</family>
        </prefer>
    </alias>
</fontconfig>
```

You can validate this configuration:
```sh
:; fc-match monospace
Hack Regular Nerd Font Complete.ttf: "Hack Nerd Font" "Regular"
```

# `fs.inotify.max_user_watches` exceeded

## Linux

You have reached the user maximum total number of [inotify](https://en.wikipedia.org/wiki/Inotify) filesystem watcher handles.

_Get This Limit_

```sh
cat /proc/sys/fs/inotify/max_user_watches
```

_Set A Higher Limit_

Create a file (as root) `/etc/sysctl.d/fs.conf`

```
fs.inotify.max_user_watches = 1048576
# you may also need to increase the max number of instances
fs.inotify.max_user_instances = 1024
```

Apply the new limit:

```sh
sudo sysctl -p --system
```

On some distributions the limit may need to be placed in `/etc/sysctl.conf` instead of `/etc/sysctl.d`
