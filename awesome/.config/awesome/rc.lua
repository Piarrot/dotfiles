-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("user-errorhandlers")

require("user-theme")

require("user-layouts")

require("user-desktop")

require("user-keymaps")

require("user-rules")

require("user-autostart")
