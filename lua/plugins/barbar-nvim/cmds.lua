---@type table
local cmds = {
  -- TODO: it
  -- Move to previous/next
  "BufferPrevious",
  "BufferNext",
  -- Re-order to previous/next
  "BufferMovePrevious",
  "BufferMoveNext",
  -- Goto buffer in position...
  "BufferGoto",
  "BufferLast",
  -- Pin/unpin buffer
  "BufferPin",
  -- Goto pinned/unpinned buffer
  "BufferGotoPinned",
  "BufferGotoUnpinned",
  -- Close buffer
  "BufferClose",
  -- Wipeout buffer
  "BufferWipeout",
  -- Close commands
  "BufferCloseAllButCurrent",
  "BufferCloseAllButPinned",
  "BufferCloseAllButCurrentOrPinned",
  "BufferCloseBuffersLeft",
  "BufferCloseBuffersRight",
  -- Magic buffer-picking mode
  "BufferPick",
  "BufferPickDelete",
  -- Sort automatically by...
  "BufferOrderByBufferNumber",
  "BufferOrderByName",
  "BufferOrderByDirectory",
  "BufferOrderByLanguage",
  "BufferOrderByWindowNumber",
  -- Other:
  "BarbarEnable",
  "BarbarDisable",
}

return cmds
