---@type table
local opts = {
  -- A string representing all the keys that can be part of a permutation.
  -- Every character (key) used in the string will be used as part of a permutation.
  -- The shortest permutation is a permutation of a single character, and, depending on the content of your buffer, you might end up with 3-character (or more) permutations in worst situations.
  -- However, it is important to notice that if you decide to provide `keys`, you have to ensure to use enough characters in the string, otherwise you might get very long sequences and a not so pleasant experience.
  keys = "etovxqpdygfblzhckisuran",
  --keys = "asdghklqwertyuiopzxcvbnmfj",

  -- A string representing a key that will quit Hop mode without also feeding that key into Neovim to be treated as a normal key press.
  -- It is possible to quit hopping by pressing any key that is not present in
  -- |hop-config-keys|;
  -- however, when you do this, the key normal function is also performed.
  -- For example if, hopping in |visual-mode|, pressing <Esc> will quit hopping and also exit |visual-mode|.

  -- If the user presses `quit_key`, Hop will be quit without the key normal function being performed.
  -- For example if hopping in |visual-mode| with `quit_key` set to '<Esc>', pressing <Esc> will quit hopping without quitting |visual-mode|.

  -- If you don't want to use a `quit_key`, set `quit_key` to an empty string.
  quit_key = "<Esc>",

  -- Permutation methods allow to change the way permutations (i.e. hints sequence labels) are generated internally.
  -- There is currently only one possible option:

  -- Permutation algorithm based on tries and backtrack filling.

  -- This algorithm uses the full potential of |hop-config-keys| by using them all to saturate a trie, representing all the permutations.
  -- Once a layer is saturated, this algorithm will backtrack (from the end of the trie, deepest first) and create a new layer in the trie, ensuring that the first permutations will be shorter than the last ones.

  -- Because of the last, deepest trie insertion mechanism and trie saturation, this algorithm yields a much better distribution accross your buffer, and you should get 1-sequences and 2-sequences most of the time.
  -- Each dimension grows exponentially, so you get `keys_length²` 2-sequence keys, `keys_length³` 3-sequence keys, etc in the worst cases.
  perm_method = require("hop.perm").TrieBacktrackFilling,

  -- The default behavior for key sequence distribution in your buffer is to concentrate shorter sequences near the cursor, grouping 1-character sequences around.
  -- As hints get further from the cursor, the dimension of the sequences will grow, making the furthest sequences the longest ones to type.
  -- Set this option to `true` to reverse the density and concentrate the shortest sequences (1-character) around the furthest words and the longest sequences around the cursor.
  reverse_distribution = false,

  -- This Determines which hints get shorter key sequences.
  -- The default value has a more balanced distribution around the cursor but increasing it means that hints which are closer vertically will have a shorter key sequences.
  -- For instance, when `x_bias` is set to 100, hints located at the end of the line will have shorter key sequence compared to hints in the lines above or below.
  x_bias = 10,

  -- This Determines the method which hops uses to evaluate the distance between jump target and the cursor.
  -- We currently provide two |hop.hint.manh_distance| and |hop.hint.readwise_distance| distance methods in `hint` API.
  distance_method = require("hop.hint").manh_distance,

  -- Boolean value stating whether Hop should tease you when you do something you are not supposed to.
  -- If you find this setting annoying, feel free to turn it to `false`.
  teasing = true,

  -- Creates a virtual cursor in place of actual cursor when hop waits for user input to indicate the active window.
  --virtual_cursor = true
  virtual_cursor = false,

  -- Immediately jump without displaying hints if only one occurrence exists.
  jump_on_sole_occurrence = true,

  -- Use case-insensitive matching by default for commands requiring user input.
  case_insensitive = true,

  -- Create and set highlight autocommands to automatically apply highlights.
  -- You will want this if you use a theme that clears all highlights before applying its colorscheme.
  create_hl_autocmd = true,

  -- Apply Hop commands only to the current line.
  -- Trying to use this option along with |hop-config-multi_windows| is unsound.
  current_line_only = false,

  -- Whether or not dim the unmatched text to emphasize the hint chars.
  dim_unmatched = true,

  -- Highlight mode of the hint chars.
  -- Set this option to `combine` will preserve the background colors of original chars.
  -- Set this option to `replace` will remove the background colors of original chars.
  -- It's useful when the hint chars is not clear on search highlights.

  -- Display labels as uppercase.
  -- This option only affects the displayed labels;
  -- you still select them by typing the keys on your keyboard.
  uppercase_labels = false,

  -- Enable cross-windows support and hint all the windows listed in `windows_list`.
  -- This behavior allows you to jump around any position in any buffer currently visible in an editor.
  -- Although a powerful a feature, remember that enabling this will also generate many more sequence combinations, so you could get deeper sequences to type (most of the time it should be good if you have enough keys in |hop-config-keys|).
  multi_windows = false,

  -- A function returns a list-table of windows to jump to.
  -- When `multi_windows` is enabled, only the windows on the list will be hint.
  windows_list = function()
    return vim.api.nvim_tabpage_list_wins(0)
  end,

  -- Ignore injected languages when jumping to treesitter node.
  ignore_injections = false,

  -- Position of hint in match.
  -- See |hop.hint.HintPosition| for further details.
  ---@type HintPosition
  hint_position = require("hop.hint").HintPosition.BEGIN,

  -- Offset to apply to a jump location.
  -- If it is non-zero, the jump target will be offset horizontally from the selected jump position by `hint_offset` character(s).
  -- This option can be used for emulating the motion commands |t| and |T| where the cursor is positioned on/before the target position.
  ---@type WindowCell
  hint_offset = 0,

  -- How to show the hint char.
  -- "overlay": display over the specified column, without shifting the underlying text.
  -- "inline": display at the specified column, and shift the buffer text to the right as needed.
  ---@type HintType
  hint_type = require("hop.hint").HintType.OVERLAY,
  --hint_type = require("hop.hint").HintType.INLINE,

  -- Skip hinting windows with the excluded filetypes.
  -- Those windows to check filetypes are collected only when you enable `multi_windows` or execute `MW`-commands.
  -- This option is useful to skip the windows which are only for displaying something but not for editing.
  excluded_filetypes = {
    -- it
  },

  -- This option allows you to specify the match mappings to use when applying the hint.
  -- If you set a non-empty `match_mappings`, the hint will be used as a key to look up the pattern to search for.
  -- Currently supported mappings:
  -- fa: farsi characters
  -- zh: Basic characters for Chinese
  -- zh_sc: Simplified Chinese
  -- zh_tc: Traditional Chinese
  -- For example, if `match_mappings` is set to `{'zh', 'zh_sc'}`, the characters in 'zh' and 'zh_sc' can be mixed to match together.
  match_mappings = {
    -- it
  },

  -- List-table of extensions to enable (names).
  -- As described in |hop-extension|, extensions for which the name in that list must have a `register(opts)` function in their public API for Hop to correctly initialized them.
  extensions = {
    "hop-yank",
    "hop-treesitter",
  },

  display_prompt = true,
}

return opts
