-- Useful type definitions go here.

---@alias obsidian.CommandArgs vim.api.keyset.create_user_command.command_args

---@class obsidian.InsertTemplateContext
---The table passed to user substitution functions when inserting templates into a buffer.
---
---@field type "insert_template"
---@field template_name string|obsidian.Path The name or path of the template being used.
---@field templates_dir obsidian.Path|? The folder containing the template file.
---@field location [integer, integer, integer, integer] `{ buf, win, row, col }` location from which the request was made.
---@field partial_note? obsidian.Note An optional note with fields to copy from.

---@class obsidian.CloneTemplateContext
---The table passed to user substitution functions when cloning template files to create new notes.
---
---@field type "clone_template"
---@field template_name string|obsidian.Path The name or path of the template being used.
---@field templates_dir obsidian.Path|? The folder containing the template file.
---@field destination_path obsidian.Path The path the cloned template will be written to.
---@field partial_note obsidian.Note The note being written.

---@alias obsidian.TemplateContext obsidian.InsertTemplateContext | obsidian.CloneTemplateContext
---The table passed to user substitution functions. Use `ctx.type` to distinguish between the different kinds.
---@alias obsidian.config.NewNotesLocation "current_dir" | "notes_subdir"
