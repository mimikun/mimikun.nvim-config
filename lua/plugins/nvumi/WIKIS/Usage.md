# Usage

## Opening nvumi

To launch the nvumi scratch buffer, run the following command in Neovim:
```vim
:Nvumi
```
This opens a dedicated scratch buffer where you can type natural language expressions.

## Evaluating Expressions

- **Live Evaluation:**  
  nvumi automatically evaluates non-empty lines as you type.

- **Manual Refresh:**  
  Press `<CR>` (Enter) in normal mode to re-evaluate all non-empty lines in the buffer.

- **Resetting the Buffer:**  
  Press `<R>` in normal mode to clear the scratch buffer and reset all stored variables.

## Variable Assignment

nvumi allows you to store evaluated expressions in variables.

- **Assign a Variable:**  
  Write a line in the format:
  ```text
  variable_name = expression
  ```
  **Example:**
  ```text
  x = 20 inches in cm
  ```
  This assigns the result of `20 inches in cm` to `x`.

- **Use the Variable:**  
  Reference the variable in subsequent expressions:
  ```text
  x * 3
  ```

## Yanking Results

- **Yank Current Line:**  
  In normal mode, press `<leader>y` to copy the result of the current line to the clipboard.

- **Yank All Results:**  
  Press `<leader>Y` to copy all evaluation results from the buffer.
```
