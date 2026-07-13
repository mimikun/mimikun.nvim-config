Output temp.gif

Set FontSize 20
Set FontFamily "JetBrainsMono Nerd Font"
Set Width WIDTH
Set Height HEIGHT
Set Padding 0

# Setup
Hide
Type "nvim -u demo/minit.lua FILENAME" Enter
Show

Set TypingSpeed 0.1
Sleep 100ms
Enter

Type "o"
Type "## Table" Enter 2
Type "| `Left` | *Right* | **Center** |" Enter
Type "| :----- | ------: | :--------: |" Enter
Type "| ~~Strike~~ | [File](test/data.txt) | Value |" Enter
Type "| `Some Code` |No Space| [Website](https://test.com/) |" Enter 2
Escape Sleep 3s

Type "i"
Type "## Callout" Enter 2
Type "> [!NOTE]" Enter
Type ">" Enter
Type "> With nested code" Enter
Type ">" Enter
Type "> ```python" Enter
Type "> def main() -> None:" Enter
Type ">     print('Hello, World!)" Enter
Type ">" Enter
Type "> main()" Enter
Type "> ```" Enter
Escape Sleep 3s

Up 10
Type "A My Own Note Title" Escape
Type "G" Sleep 3s

Type "o"
Type "## List" Enter 2
Type "- Level 1" Enter
Type "  - Level 2" Enter
Type "    - Level 3" Enter
Escape Sleep 3s

Type "o"
Type "## Checkbox" Enter 2
Type "- [x] Checked" Enter
Type "- [ ] Unchecked" Enter
Escape Sleep 3s

Up@0.5s 32

# Close without editing
Escape
Hide
Type ":q!"
Enter
Sleep 100ms
