<div align="center">

# `core.tangle`

### From Code Blocks to Files

The `core.tangle` module exports code blocks within a `.norg` file straight to a file of your choice.



</div>

# Overview

The goal of this module is to allow users to spit out the contents of code blocks into
many different files. This is the primary component required for a literate configuration in Neorg,
where the configuration is annotated and described in a `.norg` document, and the actual code itself
is thrown out into a file that can then be normally consumed by e.g. an application.

The `tangle` module currently provides a single command:
- `:Neorg tangle current-file` - performs all possible tangling operations on the current file

### Usage Tutorial

By default, *zero* code blocks are tangled. You must provide where you'd like to tangle each code
block manually (global configuration will be discussed later). To do so, add a `#tangle
<output-file>` tag above the code block you'd wish to export, where <output-file> is relative to the
current file. For example:

```norg
#tangle init.lua
@code lua
print("Hello World!")
@end
```
The above snippet will *only* tangle that single code block to the desired output file: `init.lua`.

> [!WARNING]
> Due to a bug in the norg treesitter parser, `#tangle ./init.lua` or `#tangle folder/init.lua` will not work
> As a result, we recommend specifying files destinations in metadata

#### Global Tangling for Single Files
Apart from tangling a single or a set of code blocks, you can declare a global output file in the document's metadata:
```norg
@document.meta
tangle: ./init.lua
@end
```

This will tangle all `lua` code blocks to `init.lua`, *unless* the code block has an explicit `#tangle` tag associated with it, in which case
the `#tangle` tag takes precedence.

#### Global Tangling for Multiple Files
Apart from a single filepath, you can provide many in an array:
```norg
@document.meta
tangle: [
    ./init.lua
    ./output.hs
]
@end
```

The above snippet tells the Neorg tangling engine to tangle all `lua` code blocks to `./init.lua` and all `haskell` code blocks to `./output.hs`.
As always if any of the code blocks have a `#tangle` tag then that takes precedence.

If you want to be more verbose, or you're tangling to a file without an extension (perhaps you're
writing a shell script that has a shebang) you can also do this:
```norg
@document.meta
tangle: {
    lua: ./init.lua
    python: ./output
}
@end
```

#### Ignoring Code Blocks
Sometimes when tangling you may want to omit some code blocks. For this you may use the `#tangle.none` tag:
```norg
#tangle.none
@code lua
print("I won't be tangled!")
@end
```

#### Global Tangling with Extra Options
But wait, it doesn't stop there! You can supply a string to `tangle`, an array to `tangle`, but also an object!
It looks like this:
```norg
@document.meta
tangle: {
    languages: {
        lua: ./output.lua
        haskell: my-haskell-file
    }
    delimiter: heading
    scope: all
}
@end
```

The `language` option determines which filetype should go into which file.
It's a simple language-filepath mapping, but it's especially useful when the output file's language type cannot be inferred from the name or shebang.
It is also possible to use the name `_` as a catchall to direct output for all files not otherwise listed.

The `delimiter` option determines how to delimit code blocks that export to the same file.
The following variations are allowed:

* `heading` -- Try to determine the filetype of the code block and insert any headings from the original document as a comment in the tangled output.
  If filetype detection fails, `newline` will be used instead.
* `file-content` -- Try to determine the filetype of the codeblock and insert the Neorg file content as a delimiter.
  If filetype detection fails, `none` will be used instead.
* `newline` -- Use an extra newline between tangled blocks.
* `none` -- Do not add any delimiter. This implies that the code blocks are inserted into the tangle target as-is.

The `scope` option is discussed below.

#### Tangling Scopes
What you've seen so far is the tangler operating in `all` mode. This means it captures all code blocks of a certain type unless that code block is tagged
with `#tangle.none`. There are two other types: `tagged` and `main`.

##### The `tagged` Scope
When in this mode, the tangler will only tangle code blocks that have been `tagged` with a `#tangle` tag.
Note that you don't have to always provide a filetype, and that:
```norg
#tangle
@code lua
@end
```
Will use the global output file for that language as defined in the metadata. I.e., if I do:
```norg
@document.meta
tangle: {
    languages: {
        lua: ./output.lua
    }
    scope: tagged
}
@end

@code lua
print("Hello")
@end

#tangle
@code lua
print("Sup")
@end

#tangle other-file.lua
@code lua
print("Ayo")
@end
```
The first code block will not be touched, the second code block will be tangled to `./output.lua` and the third code block will be tangled to `other-file.lua`. You
can probably see that this system can get expressive pretty quick.

##### The `main` scope
This mode is the opposite of the `tagged` one in that it will only tangle code blocks to files that are defined in the document metadata. I.e. in this case:
```norg
@document.meta
tangle: {
    languages: {
        lua: ./output.lua
    }
    scope: main
}
@end

@code lua
print("Hello")
@end

#tangle
@code lua
print("Sup")
@end

#tangle other-file.lua
@code lua
print("Ayo")
@end
```
The first code block will be tangled to `./output.lua`, the second code block will also be tangled to `./output.lua` and the third code block will be ignored.

# Configuration

* <details open>
  
  <summary><h6><code>indent_errors</h6></code> (string)</summary>
  
  <div>
  
  When text in a code block is less indented than the block itself, Neorg will not tangle that
  block to a file. Instead it can either print or vim.notify error. By default, vim.notify is
  loud and is more likely to create a press enter message.
  - "notify" - Throw a normal looking error
  - "print" - print the error
  
  </div>
  
  ```lua
  "notify"
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>report_on_empty</h6></code> (boolean)</summary>
  
  <div>
  
  Notify when there is nothing to tangle (INFO) or when the content is empty (WARN).
  
  </div>
  
  ```lua
  true
  ```
  
  </details>

* <details open>
  
  <summary><h6><code>tangle_on_write</h6></code> (boolean)</summary>
  
  <div>
  
  Tangle all code blocks in the current norg file on file write.
  
  </div>
  
  ```lua
  false
  ```
  
  </details>


# Dependencies

- [`core.dirman.utils`](https://github.com/nvim-neorg/neorg/wiki/Dirman-Utils) - A set of utilities for the `core.dirman` module.
- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.neorgcmd`](https://github.com/nvim-neorg/neorg/wiki/Neorgcmd-Module) - This module deals with handling everything related to the `:Neorg` command.

