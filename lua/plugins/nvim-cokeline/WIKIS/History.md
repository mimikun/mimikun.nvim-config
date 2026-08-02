# History

The History keeps track of the buffers you access using a ringbuffer, and provides an API for accessing Buffer objects from the history.

You can access the history using `require("cokeline.history")`, or through the global `_G.cokeline.history`.

The History object provides these methods:

```lua
---Adds a Buffer object to the history
function History:push(bufnr: int)
end

---Removes and returns the oldest Buffer object in the history
function History:pop(): Buffer | nil
end

---Returns a list of Buffer objects in the history,
---ordered from oldest to newest
function History:list(): Buffer[]
end

---Returns an iterator of Buffer objects in the history,
---ordered from oldest to newest
function History:iter(): fun(): Buffer | nil
end

---Get a Buffer object by history index
function History:get(idx: int): Buffer | nil
end

---Get a Buffer object representing the last-accessed buffer (before the current one)
function History:last(): Buffer | nil
end

---Returns true if the history is empty
function History:is_empty(): boolean
end

---Returns the maximum number of buffers that can be stored in the history
function History:capacity(): int
end

---Returns true if the history contains the given buffer
function History:contains(bufnr: int): bool
end

---Returns the number of buffers in the history
function History:len(): int
end
```