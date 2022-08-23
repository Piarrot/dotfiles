local run_once = require("helpers.run-once");
local awful = require("awful");

local function autostart_apps()
    -- Compositor
    run_once("picom", "DISPLAY=':0' picom -b --experimental-backends")

    -- Polkit
    run_once("lxpolkit")
    run_once("gnome-keyring-daemon", "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh")

    -- Other tools
    run_once("thunar", "thunar --daemon")

    run_once("flameshot")

    awful.spawn("~/bin/wacom.sh", false)
end

autostart_apps()
