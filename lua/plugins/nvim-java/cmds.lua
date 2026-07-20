---@type table
local cmds = {
  -- Build
  "JavaBuildBuildWorkspace",
  "JavaBuildCleanWorkspace",
  -- Runner
  "JavaRunnerRunMain",
  "JavaRunnerStopMain",
  "JavaRunnerToggleLogs",
  -- DAP
  "JavaDapConfig",
  -- Test
  "JavaTestRunCurrentClass",
  "JavaTestDebugCurrentClass",
  "JavaTestRunCurrentMethod",
  "JavaTestDebugCurrentMethod",
  "JavaTestRunAllTests",
  "JavaTestDebugAllTests",
  "JavaTestViewLastReport",
  -- Profiles
  "JavaProfile",
  -- Refactor
  "JavaRefactorExtractVariable",
  "JavaRefactorExtractVariableAllOccurrence",
  "JavaRefactorExtractConstant",
  "JavaRefactorExtractMethod",
  "JavaRefactorExtractField",
  -- Settings
  "JavaSettingsChangeRuntime",
}

return cmds
