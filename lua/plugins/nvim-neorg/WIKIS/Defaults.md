<div align="center">

# `core.defaults`

### 





</div>

# Overview

This file contains all of the most important modules that any user would want
to have a "just works" experience.

Individual entries can be disabled via the "disable" flag:
```lua
load = {
    ["core.defaults"] = {
        config = {
            disable = {
                -- module list goes here
                "core.autocommands",
                "core.itero",
            },
        },
    },
}
```

# Configuration

This module provides no configuration options!


