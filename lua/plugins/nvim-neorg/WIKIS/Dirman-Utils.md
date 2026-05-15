<div align="center">

# `core.dirman.utils`

### 





</div>

# Overview

This internal submodule implements some basic utility functions for [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman).
Currently the only exposed API function is `expand_path`, which takes a path like `$name/my/location` and
converts `$name` into the full path of the workspace called `name`.

# Configuration

This module provides no configuration options!


# Required By

- [`core.completion`](https://github.com/nvim-neorg/neorg/wiki/Completion) - A wrapper to interface with several different completion engines.
- [`core.dirman`](https://github.com/nvim-neorg/neorg/wiki/Dirman) - This module is be responsible for managing directories full of .norg files.
- [`core.esupports.hop`](https://github.com/nvim-neorg/neorg/wiki/Esupports-Hop) - "Hop" between Neorg links, following them with a single keypress.
- [`core.tangle`](https://github.com/nvim-neorg/neorg/wiki/Tangling) - An Advanced Code Block Exporter.
