# Logs

Neo-tree has logging, but by default it does not write to a file and all events below info are dropped. If you are trying to track down a problem, you may want to enable log to file and change the log level to debug or trace:

```lua
      require("neo-tree").setup({
        log_level = "trace",
        log_to_file = true,
      })
```

After `log_to_file` has been enabled, you can view that log file with this command:
```
:lua require("neo-tree").show_logs()
```
Which will open the log file in a new tab.

**NOTE**: There is no log rotation in place, so you don't want to leave these settings turned on long term. I would recommend deleting the file or clearing it periodically if you leave it turned on long term.