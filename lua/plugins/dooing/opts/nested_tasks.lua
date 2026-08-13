-- Nested tasks
local nested_tasks = {
  -- Enable nested subtasks
  enabled = true,

  -- Spaces per nesting level
  indent = 2,

  -- Keep nested structure when completing tasks
  retain_structure_on_complete = true,

  -- Move completed nested tasks to end of parent group
  move_completed_to_end = true,

  -- Inherit parent priorities and skip the priority prompt
  inherit_priority = false,
}

return nested_tasks
