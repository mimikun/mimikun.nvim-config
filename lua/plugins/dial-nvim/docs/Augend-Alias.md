## Augend-Alias

Some augend rules are defined as alias. It can be used directly without using `new` function.

```lua
require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
  },
}
```

|Alias Name                                |Explanation                                      |Examples                            |
|------------------------------------------|-------------------------------------------------|------------------------------------|
|`augend.integer.alias.decimal`            |decimal natural number                           |`0`, `1`, ..., `9`, `10`, `11`, ... |
|`augend.integer.alias.decimal_int`        |decimal integer (including negative number)      |`0`, `314`, `-1592`, ...            |
|`augend.integer.alias.hex`                |hex natural number                               |`0x00`, `0x3f3f`, ...               |
|`augend.integer.alias.octal`              |octal natural number                             |`0o00`, `0o11`, `0o24`, ...         |
|`augend.integer.alias.binary`             |binary natural number                            |`0b0101`, `0b11001111`, ...         |
|`augend.date.alias["%Y/%m/%d"]`           |Date in the format `%Y/%m/%d` (`0` padding)      |`2021/01/23`, ...                   |
|`augend.date.alias["%m/%d/%Y"]`           |Date in the format `%m/%d/%Y` (`0` padding)      |`23/01/2021`, ...                   |
|`augend.date.alias["%d/%m/%Y"]`           |Date in the format `%d/%m/%Y` (`0` padding)      |`01/23/2021`, ...                   |
|`augend.date.alias["%m/%d/%y"]`           |Date in the format `%m/%d/%y` (`0` padding)      |`01/23/21`, ...                     |
|`augend.date.alias["%d/%m/%y"]`           |Date in the format `%d/%m/%y` (`0` padding)      |`23/01/21`, ...                     |
|`augend.date.alias["%m/%d"]`              |Date in the format `%m/%d` (`0` padding)         |`01/04`, `02/28`, `12/25`, ...      |
|`augend.date.alias["%-m/%-d"]`            |Date in the format `%-m/%-d` (no paddings)       |`1/4`, `2/28`, `12/25`, ...         |
|`augend.date.alias["%Y-%m-%d"]`           |Date in the format `%Y-%m-%d` (`0` padding)      |`2021-01-04`, ...                   |
|`augend.date.alias["%d.%m.%Y"]`           |Date in the format `%d.%m.%Y` (`0` padding)      |`23.01.2021`, ...                   |
|`augend.date.alias["%d.%m.%y"]`           |Date in the format `%d.%m.%y` (`0` padding)      |`23.01.21`, ...                     |
|`augend.date.alias["%d.%m."]`             |Date in the format `%d.%m.` (`0` padding)        |`04.01.`, `28.02.`, `25.12.`, ...   |
|`augend.date.alias["%-d.%-m."]`           |Date in the format `%-d.%-m.` (no paddings)      |`4.1.`, `28.2.`, `25.12.`, ...      |
|`augend.date.alias["%Y年%-m月%-d日"]`     |Date in the format `%Y年%-m月%-d日` (no paddings)|`2021年1月4日`, ...                 |
|`augend.date.alias["%Y年%-m月%-d日(%ja)"]`|Date in the format `%Y年%-m月%-d日(%ja)`         |`2021年1月4日(月)`, ...             |
|`augend.date.alias["%H:%M:%S"]`           |Time in the format `%H:%M:%S`                    |`14:30:00`, ...                     |
|`augend.date.alias["%H:%M"]`              |Time in the format `%H:%M`                       |`14:30`, ...                        |
|`augend.constant.alias.de_weekday`        |German weekday                                   |`Mo`, `Di`, ..., `Sa`, `So`         |
|`augend.constant.alias.de_weekday_full`   |German full weekday                              |`Montag`, `Dienstag`, ..., `Sonntag`|
|`augend.constant.alias.en_weekday`        |English weekday                                  |`Mon`, `Tue`, ..., `Sat`, `Sun`     |
|`augend.constant.alias.en_weekday_full`   |English full weekday                             |`Monday`, `Tuesday`, ..., `Sunday`  |
|`augend.constant.alias.ja_weekday`        |Japanese weekday                                 |`月`, `火`, ..., `土`, `日`         |
|`augend.constant.alias.ja_weekday_full`   |Japanese full weekday                            |`月曜日`, `火曜日`, ..., `日曜日`   |
|`augend.constant.alias.bool`              |elements in boolean algebra (`true` and `false`) |`true`, `false`                     |
|`augend.constant.alias.Bool`              |elements in boolean algebra (`True` and `False`) |`True`, `False`                     |
|`augend.constant.alias.alpha`             |Lowercase alphabet letter (word)                 |`a`, `b`, `c`, ..., `z`             |
|`augend.constant.alias.Alpha`             |Uppercase alphabet letter (word)                 |`A`, `B`, `C`, ..., `Z`             |
|`augend.semver.alias.semver`              |Semantic version                                 |`0.3.0`, `1.22.1`, `3.9.1`, ...     |


If you don't specify any settings, the following augends is set as the value of the `default` group.

* `augend.integer.alias.decimal`
* `augend.integer.alias.hex`
* `augend.date.alias["%Y/%m/%d"]`
* `augend.date.alias["%Y-%m-%d"]`
* `augend.date.alias["%m/%d"]`
* `augend.date.alias["%H:%M"]`
* `augend.constant.alias.ja_weekday_full`

---
## List-of-Augends

For simplicity, we define the variable `augend` as follows.

```lua
local augend = require("dial.augend")
```

### `integer`

`n`-based integer (`2 <= n <= 36`). You can use this rule with `augend.integer.new{ ...opts }`.

```lua
require("dial.config").augends:register_group{
  default = {
    -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
    augend.integer.new{
      radix = 16,
      prefix = "0x",
      natural = true,
      case = "upper",
    },
  },
}
```

---
## `date`

Date and time.

```lua
require("dial.config").augends:register_group{
  default = {
    -- date with format `yyyy/mm/dd`
    augend.date.new{
        pattern = "%Y/%m/%d",
        default_kind = "day",
        -- if true, it does not match dates which does not exist, such as 2022/05/32
        only_valid = true,
        -- if true, it only matches dates with word boundary
        word = false,
    },
  },
}
```

In the `pattern` argument, you can use the following escape sequences:

|Sequence|Meaning                                                                    |
|-----|------------------------------------------------------------------------------|
|`%Y` |4-digit year. (e.g. `2022`)                                                   |
|`%y` |Last 2 digits of year. The upper 2 digits are interpreted as `20`. (e.g. `22`)|
|`%m` |2-digit month. (e.g. `09`)                                                    |
|`%d` |2-digit day. (e.g. `28`)                                                      |
|`%H` |2-digit hour, expressed in 24 hours. (e.g. `15`)                              |
|`%I` |2-digit hour, expressed in 12 hours. (e.g. `03`)                              |
|`%M` |2-digit minute. (e.g. `05`)                                                   |
|`%S` |2-digit second. (e.g. `08`)                                                   |
|`%-y`|1- or 2-digit year. (e.g. `9` represents 2009)                                |
|`%-m`|1- or 2-digit month. (e.g. `9`)                                               |
|`%-d`|1- or 2-digit day. (e.g. `28`)                                                |
|`%-H`|1- or 2-digit hour, expressed in 24 hours. (e.g. `15`)                        |
|`%-I`|1- or 2-digit hour, expressed in 12 hours. (e.g. `3`)                         |
|`%-M`|1- or 2-digit minute. (e.g. `5`)                                              |
|`%-S`|1- or 2-digit second. (e.g. `8`)                                              |
|`%a` |English weekdays (`Sun`, `Mon`, ..., `Sat`)                                   |
|`%A` |English full weekdays (`Sunday`, `Monday`, ..., `Saturday`)                   |
|`%b` |English month names (`Jan`, ..., `Dec`)                                       |
|`%B` |English month full names (`January`, ..., `December`)                         |
|`%p` |`AM` or `PM`.                                                                 |
|`%J` |Japanese weekdays (`日`, `月`, ..., `土`)                                     |

