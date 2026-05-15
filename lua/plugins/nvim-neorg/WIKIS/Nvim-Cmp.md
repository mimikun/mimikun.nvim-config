<div align="center">

# `core.integrations.nvim-cmp`

### Integrating Neorg with `nvim-cmp`





</div>

# Overview

This module works with the [`core.completion`](https://github.com/nvim-neorg/neorg/wiki/Completion) module to attempt to provide
intelligent completions. Note that integrations like this are second-class citizens and may not work in 100%
of scenarios. If they don't then please file a bug report!

After setting up `core.completion` with the `engine` set to `nvim-cmp`, make sure to also set up "neorg"
as a source in `nvim-cmp`:
```lua
sources = {
    { name = "neorg" },
},
```

# Configuration

This module provides no configuration options!


