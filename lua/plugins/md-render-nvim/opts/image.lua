---@type MdRender.Image.Config
local image = {
  -- Unset on purpose.
  -- A PlantUML fence is rendered by a local `plantuml` or `java -jar $PLANTUML_JAR` if there is one;
  -- naming a server here is what allows the source of a diagram to leave the machine, and nothing else turns that on.
  -- base URL of a PlantUML server, e.g. `"https://www.plantuml.com/plantuml"`
  ---@type string
  plantuml_server = nil,
}

return image
