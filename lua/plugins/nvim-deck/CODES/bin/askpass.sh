#!/bin/sh
nvim -u NONE --server $NVIM --headless --remote-expr "nvim_call_function('inputsecret', ['Enter passphrase: '])"
