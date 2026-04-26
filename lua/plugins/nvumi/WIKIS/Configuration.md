# Configuration

## Options

You can configure nvumi via the `opts` table when setting up the plugin. Here are the available options:

- **virtual_text**  
  Determines how evaluation results are displayed.  
  **Options:** `"inline"` (results appended at the end of the line) or `"newline"` (results displayed on a new line).

- **prefix**  
  A string that prefixes every evaluation result (e.g., `" 🚀 "`).

- **date_format**  
  Specifies the date format for any date calculations.  
  **Options:** `"iso"`, `"us"`, `"uk"`, or `"long"`.

- **keys**  
  Custom keybindings:
  - `run`: Run/refresh all calculations (default: `<CR>`)
  - `reset`: Clear the buffer and all variables (default: `R`)
  - `yank`: Yank the evaluation from the current line (default: `<leader>y`)
  - `yank_all`: Yank all evaluations from the buffer (default: `<leader>Y`)

## Custom Conversions

nvumi supports custom unit conversions to extend its natural language calculations. Each conversion definition must include:

- **id:** A unique identifier.
- **phrases:** A comma-separated list of unit aliases (case-insensitive).
- **base_unit:** The category the unit belongs to (e.g., `"speed"`, `"volume"`). Both source and target units must share the same base.
- **format:** A format string for displaying the result.
- **ratio:** The conversion ratio relative to the base unit.

### Example
```lua
{
  opts = {
    custom_conversions = {
      {
        id = "kmh",
        phrases = "kmh, kmph, klicks, kilometers per hour",
        base_unit = "speed",
        format = "km/h",
        ratio = 1,
      },
      {
        id = "mph",
        phrases = "mph, miles per hour",
        base_unit = "speed",
        format = "mph",
        ratio = 1.609344, -- 1 mph = 1.609344 km/h
      },
    },
  }
}
```
