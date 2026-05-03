Due to [this open neovim bug](https://github.com/neovim/neovim/issues/21106), some extra steps must be performed in order to enable mouse support.

## Enabing mouse support for ToggleTerm

In order to enable mouse support for ToggleTerm and/or neovim's terminal. You must

    set mouse=""

This will make the mouse behave like a normal terminal.

## Enabing mouse support for terminal programs

But before launching a terminal program, an extra step needs to be done.

```sh
set mouse="a"        # Restore mouse support → run this in neovim, the rest goes on the terminal.
printf "\x1b[?1000h" # Set term code

# run your terminal program here

printf "\x1b[?1000l" # Unset term code
set mouse=""         # This gives us a normal mouse on the term
```

This will enable mouse support inside of the terminal program.

## Restoring nvim mouse support when leaving the term

    set mouse="a"


## Notes
This implementation provides 100% mouse support, including left mouse, right mouse, scroll wheeel, and middle click. To make it work, make sure you have this setted `TERM=xterm256color`. Other TERM  values may not work as expected.