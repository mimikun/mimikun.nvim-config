local history = {
  -- The directory in which the history will be stored at.
  -- NOTE: A subdirectory will be created called `project_nvim`, where the history file resides
  save_dir = vim.fn.stdpath("data"),

  -- The file name for the JSON project history
  save_file = "project_history.json",

  -- The maximum number of history entries to write in your history file
  size = 100,
}

return history
