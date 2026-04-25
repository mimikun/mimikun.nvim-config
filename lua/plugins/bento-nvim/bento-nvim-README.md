### Options

#### General Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `main_keymap` | string | `";"` | Primary key for menu toggle and expand |
| `lock_char` | string | `"🔒"` | Character displayed before locked buffer names |
| `max_open_buffers` | number/nil | `nil` | Maximum number of buffers to keep open (`nil` = unlimited) |
| `buffer_deletion_metric` | string | `"frecency_access"` | Metric used to decide which buffer to delete when limit is reached (see below) |
| `buffer_notify_on_delete` | boolean | `true` | Whether to create a notification via `vim.notify` when a buffer is deleted by the plugin |
| `ordering_metric` | string/nil | `"access"` | Buffer ordering: `nil` (insertion order), `"access"` (by last access time, most recent first), `"edit"` (by last edit time, most recent first), `"filename"` (alphabetical by filename), or `"directory"` (alphabetical by full path). |
| `locked_first` | boolean | `false` | If true, locked buffers are always sorted to the top of the list. |
| `default_action` | string | `"open"` | Default action mode when menu expands |
| `map_last_accessed` | boolean | `false` | If true, maps a key based on filename to the last accessed buffer (like all other buffers). If false it is only mapped to main_keymap. |
| `highlights` | table | See below | Highlight groups for all UI elements |
| `actions` | table | Built-in actions | Action definitions (see Actions section) |

#### UI Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ui.mode` | string | `"floating"` | UI mode: `"floating"` (sidebar window) or `"tabline"` (horizontal tabline) |

#### Floating UI Options (`ui.floating`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `position` | string | `"middle-right"` | Menu position: `"top-left"`, `"top-right"`, `"middle-left"`, `"middle-right"`, `"bottom-left"`, `"bottom-right"` |
| `offset_x` | number | `0` | Horizontal offset from position |
| `offset_y` | number | `0` | Vertical offset from position |
| `dash_char` | string | `"─"` | Character for collapsed state lines |
| `border` | string | `"none"` | Border style for the floating window: `"rounded"`, `"single"`, `"double"`, etc. (see :h winborder) |
| `label_padding` | number | `1` | Padding on left/right of labels |
| `minimal_menu` | string/nil | `nil` | Collapsed menu style: `nil` (hidden), `"dashed"` (dash lines), `"filename"` (names only), `"full"` (names + labels) |
| `max_rendered_buffers` | number/nil | `nil` | Maximum buffers to display per page. Pagination is also automatically enabled when buffers exceed available screen height. Uses `min(max_rendered_buffers, available_height)` when set. Navigate pages with `[` and `]` keys. A centered indicator (`● ○ ○`) shows current page. |

#### Tabline UI Options (`ui.tabline`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `left_page_symbol` | string | `"❮"` | Symbol shown at left edge when previous buffers exist (pagination) |
| `right_page_symbol` | string | `"❯"` | Symbol shown at right edge when more buffers exist (pagination) |
| `separator_symbol` | string | `"|"` | Separator character between buffer components |

### Buffer Deletion Metrics

When `max_open_buffers` is set to a positive value, bento will automatically delete buffers to stay within the limit. The `buffer_deletion_metric` option controls how buffers are prioritized for deletion:

| Metric | Description |
|--------|-------------|
| `"recency_access"` | Delete the buffer that was **accessed** (entered/viewed) least recently. Uses Neovim's built-in `lastused` tracking. |
| `"recency_edit"` | Delete the buffer that was **edited** least recently. Buffers you haven't modified in a while are deleted first. |
| `"frecency_access"` | Delete the buffer with the lowest **access frecency**. This is the default. Frecency combines frequency and recency - buffers you access often and recently score higher and are kept. |
| `"frecency_edit"` | Delete the buffer with the lowest **edit frecency**. Buffers you edit frequently and recently score higher and are kept. |

**Recency** metrics simply look at when the last event occurred. **Frecency** metrics use a decay-based algorithm that considers the entire history of events, giving higher scores to buffers that are both frequently and recently used.

