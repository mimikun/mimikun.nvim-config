# Functions

## cokeline.mappings

* [pick(goal)](https://github.com/willothy/nvim-cokeline/wiki)
  Focus or close a buffer using pick letters.
* [by_step(goal, step)](https://github.com/willothy/nvim-cokeline/wiki)
  Focus or close a buffer using a relative offset (-1, 1, etc.)
* [by_index(goal, idx)](https://github.com/willothy/nvim-cokeline/wiki)
  Focus or close a buffer by its index.

## cokeline.utils

* [buf_delete(bufnr, wipe)](https://github.com/willothy/nvim-cokeline/wiki)
  Delete the given buffer while maintaining window layout.

## cokeline.hlgroups

* [get_hl(group_name)](https://github.com/willothy/nvim-cokeline/wiki)
  Memoized wrapper around `nvim_get_hl`
* [get_hl_attr(group_name, attr)](https://github.com/willothy/nvim-cokeline/wiki)
  Get a single attribute from a hlgroup. Memoized with same cache as `get_hl`.

## cokeline.buffers

* [is_visible(bufnr)](https://github.com/willothy/nvim-cokeline/wiki)
  Returns true if the buffer is visible.
* [get_current()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns the Buffer object for the current buffer.
* [get_buffer(bufnr)](https://github.com/willothy/nvim-cokeline/wiki)
  Returns the Buffer object for the given bufnr, if valid.
* [get_visible()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns a list of visible Buffer objects.
* [get_valid_buffers()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns a list of valid buffers.
* [move_buffer(buffer, target)](https://github.com/willothy/nvim-cokeline/wiki)
  Move a buffer to a different position.
* [release_taken_letter(bufnr)](https://github.com/willothy/nvim-cokeline/wiki)
  Release the pick letter for a Buffer object.

## cokeline.tabs

* [update_current(tabnr)](https://github.com/willothy/nvim-cokeline/wiki)
* [fetch_tabs()](https://github.com/willothy/nvim-cokeline/wiki)
  Update the list of tabpges.
* [get_tabs()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns a list of Tabpage objects.
* [get_tabpage(tabnr)](https://github.com/willothy/nvim-cokeline/wiki)
  Returns the Tabpage object for tabnr, if valid.

## cokeline.history

* [push(bufnr)](https://github.com/willothy/nvim-cokeline/wiki)
  Push an item into the history.
* [pop()](https://github.com/willothy/nvim-cokeline/wiki)
  Pop the last item off of the history.
* [list()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns the history items as a (copied) list.
* [iter()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns an iterator over the history items.
* [get(idx)](https://github.com/willothy/nvim-cokeline/wiki)
  Get the item at history index `idx`, if any.
* [last()](https://github.com/willothy/nvim-cokeline/wiki)
  Peek the last item in the history, without removing it.
* [contains(bufnr)](https://github.com/willothy/nvim-cokeline/wiki)
  Check if the history contains the given `bufnr`.
* [capacity()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns the configured capacity.
* [len()](https://github.com/willothy/nvim-cokeline/wiki)
  Returns the number of items in the history.
