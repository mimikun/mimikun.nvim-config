---@type DropConfig
local opts = {
  -- when auto, it will choose a theme based on the date
  ---@type DropTheme|string
  theme = "auto",
  ---@type ({theme: string}|DropDate|{from:DropDate, to:DropDate}|{holiday:"us_thanksgiving"|"easter"})[]
  themes = {
    -- 37. **new_year** - 🎆 🎉 🍾 🥂 ⏰ 🕛 🎈 🌟 ✨ 🎊 🥳 💫 📅 2️⃣ 0️⃣ 2️⃣ 4️⃣
    { theme = "new_year", month = 1, day = 1 },
    -- 57. **valentines_day** - ❤️ 💖 💘 💝 💕 💓 💞 💟 💌 🌹 🍫 💐 💍 🍷 🕯️
    { theme = "valentines_day", month = 2, day = 14 },
    -- 49. **st_patricks_day** - 🍀 🌈 💚 🇮🇪 🎩 🥔 🍺 🍻 🥃 🍖 💰 🌟 🍵 🐍 🪄
    --{ theme = "st_patricks_day", month = 3, day = 17 },
    -- 20. **easter** - 🐣 🐥 🐤 🥚 🌸 🍫 🐇 🌷 🌼 🍃 🦋 🍬 🌈 🎀 💒
    --{ theme = "easter", holiday = "easter" },
    -- 01. **april_fools** - 🤡, 🎭, 🃏, 🎉, 😂, 🙃, 🎈, 🎁, 🤣, 😜
    { theme = "april_fools", month = 4, day = 1 },
    -- 56. **us_independence_day** - 🇺🇸 🎆 🗽 🦅 🌭 🍔 ⭐ 🎉 🥳 🍻 🥁 🎵 🎶 🚀 💥v
    --{ theme = "us_independence_day", month = 7, day = 4 },
    -- 26. **halloween** - 🎃, 👻, 🦇, 🕷️, 🕸️, 🦉, 🔮, 💀, 👽, 🌙, 🍬, 🍭, 🖤, 🔪, 🧛, 🪦, 😱, 🙀, 🌕, ⚰️
    { theme = "halloween", month = 10, day = 31 },
    -- 52. **thanksgiving** - 🦃 🍂 🍁 🌽 🥧 🍠 🍎 🍖 🍗 🥖 🥔 🍇 🍷 🌰 🥕
    --{ theme = "us_thanksgiving", holiday = "us_thanksgiving" },
    -- 61. **xmas** - 🎄 🎁 🤶 🎅 🛷 ❄ ⛄ 🌟 🦌 🎶 ❄️  ❅ ❇ \*
    { theme = "xmas", from = { month = 12, day = 24 }, to = { month = 12, day = 25 } },
    -- 28. **leaves** - 🍂 🍁 🍀 🌿   
    { theme = "leaves", from = { month = 9, day = 22 }, to = { month = 12, day = 20 } },
    -- 42. **snow** - ❄️  ❅ ❇ \* .
    { theme = "snow", from = { month = 12, day = 21 }, to = { month = 3, day = 19 } },
    -- 46. **spring** - 🐑 🐇 🦔 🐣 🦢 🐝 🌻 🌼 🌷 🌱 🌳 🌾 🍀 🍃 🌈
    { theme = "spring", from = { month = 3, day = 20 }, to = { month = 6, day = 20 } },
    -- 50. **summer** - 😎 🏄 🏊 🌻 🌴 🍹 🏝️ ☀️ 🌞 🕶️ 👕 ⛵ 🥥 🌊
    { theme = "summer", from = { month = 6, day = 21 }, to = { month = 9, day = 21 } },
    -- TODO: its
    -- 02. **arcade** - 🎮 🕹️ 👾 💾 ⚔️ 🛡️ 🏰
    -- 03. **art** - 🎨 🖼️ 🖌️ 🎭 🎶 📚 🖋️
    -- 04. **bakery** - 🍞 🥖 🥐 🍩 🍰 🧁 🍪
    -- 05. **beach** - 🌴 🏖️ 🍹 🌅 🏄 🐚 🌞
    -- 06. **binary** - 0, 1
    -- 07. **bugs** - 🐞, 🐜, 🪲, 🦗, 🕷️, 🕸️, 🐛
    -- 08. **business** - 💼, 🖊️, 📈, 📉, 💹, 💲, 🏢
    -- 09. **candy** - 🍬 🍭 🍫 🍩 🍰 🧁 🍪
    -- 10. **cards** - ♠️, ♥️, ♦️, ♣️, 🃏
    -- 11. **carnival** - 🎪 🎭 🍿 🎠 🎡 🎈 🤹
    -- 12. **casino** - 🎰 ♠️ ♦️ ♣️ ♥️ 🎲 🃏
    -- 13. **cats** - 🐱, 🦁, 🐯, 🐈, 🐅, 🐆
    -- 14. **coffee** - ☕ 🥐 🍰 🍪 🍩 🥛 🍫
    -- 15. **cyberpunk** - 🌃 💿 🕶️ ⚙️ 🖥️ 🎮 🔌
    -- 16. **deepsea** - 🐠 🐙 🦈 🌊 🦑 🐡 🐟
    -- 17. **desert** - 🌵 🐪 🏜️ 🌞 🦂 🪨 💧
    -- 18. **dice** - ⚀, ⚁, ⚂, ⚃, ⚄, ⚅
    -- 19. **diner** - 🍔 🍟 🥤 🍳 🥞 🥓 🍦
    -- 21. **emotional** - 😀, 😃, 😄, 😁, 😆, 😅, 😂, 🤣, 😊, 😇, 🙂, 🙃, 😉, 😌, 😍, 😘, 😗, 😙, 😚, 😋, 😛, 😝, 😜, 🤪, 🤨, 🧐, 🤓, 😎, 🤩, 😏, 😒, 😞, 😔, 😟, 😕, 🙁, ☹️, 😣, 😖, 😫, 😩, 🥺, 😢, 😭, 😤, 😠, 😡, 🤬, 🤯, 😳, 🥵, 🥶, 😱, 😨, 😰, 😥, 😓, 😶, 😐, 😑, 😬, 😯, 😦, 😧, 😮, 😲, 🥱, 😴, 🤤, 😪, 😵, 🤐, 🥴, 🤢, 🤮, 🤕, 🤒, 😷, 🥰, 😸, 😺, 😻, 😼, 😽, 🙀, 😿, 😹
    -- 22. **explorer** - 🌍 🌐 🗺️ 🔍 ⛺ 🌄 🧭
    -- 23. **fantasy** - 🐉 🏰 🪄 🧙 🛡️ 🗡️ 🌌 👑
    -- 24. **farm** - 🐄 🐖 🐓 🌾 🍎 🍏 🚜
    -- 25. **garden** - 🌱, 🌸, 🌻, 🌿, 🍂, 🍃, 🌾
    -- 27. **jungle** - 🦜 🦍 🌴 🐅 🐍 🌺 🦎
    -- 29. **lunar** - 🌑, 🌒, 🌓, 🌔, 🌕, 🌖, 🌗, 🌘
    -- 30. **magical** - 🔮 🌟 🧹 🎩 🐇 🪄 💫
    -- 31. **mathematical** - ➕, ➖, ✖️, ➗, ≠, ≈, ∞
    -- 32. **matrix** - ｦ, ｧ, ｨ, ｩ, ｪ, ｫ, ｬ, ｭ, ｮ, ｯ, ｰ, ｱ, ｲ, ｳ, ｴ, ｵ, ｶ, ｷ, ｸ, ｹ, ｺ, ｻ, ｼ, ｽ, ｾ, ｿ, ﾀ, ﾁ, ﾂ, ﾃ, ﾄ, ﾅ, ﾆ, ﾇ, ﾈ, ﾉ, ﾊ, ﾋ, ﾌ, ﾍ, ﾎ, ﾏ, ﾐ, ﾑ, ﾒ, ﾓ, ﾔ, ﾕ, ﾖ, ﾗ, ﾘ, ﾙ, ﾚ, ﾛ, ﾜ, ﾝ, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, -, =, *, _, +, |, :, <, >, "
    -- 33. **medieval** - 🏰 🛡️ ⚔️ 🎠 👑 🏹 🍺
    -- 34. **musical** - 🎵 🎶 🎤 🎷 🎸 🎺 🎻
    -- 35. **mystery** - 🕵️, 🔎, 🔒, 🔑, 📜, 🖋️, 🗝️
    -- 36. **mystical** - 🔮 🌕 🌟 📜 ✨ 🔥 💫
    -- 38. **nocturnal** - 🦉 🌙 🦇 🌌 🌠 🔭 🌚
    -- 39. **ocean** - 🌊 🐠 🐟 🐡 🐬 🐳 🦈 🐚 ⛵
    -- 40. **pirate** - ☠️ ⚓ 🏴‍☠️ 🗺️ 🦜 ⚔️ 💰
    -- 41. **retro** - 📻 📺 🎞️ 📼 🎙️ 🕰️ ☎️
    -- 43. **spa** - 🕯️ 🛁 🌸 💆 🍵 🧘 💅
    -- 44. **space** - 🪐 🌌 ⭐ 🌙 🚀 🛰️ ☄️ 🌠 👩‍🚀
    -- 45. **sports** - ⚽ 🏀 🏈 ⚾ 🎾 🏓 🏒
    -- 47. **stars** - ★ ⭐ ✮ ✦ ✬ ✯ 🌟
    -- 48. **steampunk** - ⚙️ 🕰️ 🎩 🚂 🧭 🔭 🗝️
    -- 51. **temporal** - 🕐, 🕑, 🕒, 🕓, 🕔, 🕕, 🕖, 🕗, 🕘, 🕙, 🕚, 🕛
    -- 53. **travel** - ✈️, 🌍, 🗺️, 🏨, 🧳, 🗽, 🚂
    -- 54. **tropical** - 🌴 🍍 🍉 🥥 🌺 🐢 🌊
    -- 55. **urban** - 🏢 🚕 🚇 🍕 🚦 🛴 🎧
    -- 58. **wilderness** - 🌲 🐺 🦌 🏞️ 🔥 ⛺ 🌌
    -- 59. **wildwest** - 🤠 🐎 🌵 🔫 ⛏️ 🌄 🚂
    -- 60. **winter_wonderland** - ❄️ ⛄ 🌨️ 🎿 🛷 🏔️ 🧣
    -- 62. **zodiac** - ♈, ♉, ♊, ♋, ♌, ♍, ♎, ♏, ♐, ♑, ♒, ♓
    -- 63. **zoo** - 🦁 🐘 🦓 🦒 🦅 🦉 🐆
  },
  -- maximum number of drops on the screen
  max = 75,
  -- every 150ms we update the drops
  interval = 100,
  -- show after 5 minutes. Set to false, to disable
  screensaver = 1000 * 60 * 5,
  -- will enable/disable automatically for the following filetypes
  filetypes = {
    "dashboard",
    "alpha",
    "ministarter",
  },
  -- winblend for the drop window
  winblend = 100,
}

return opts
