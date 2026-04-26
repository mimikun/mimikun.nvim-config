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

