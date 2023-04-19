local run_once = require("helpers.run-once");
local awful = require("awful");

local function autostart_apps()
    -- Compositor
    run_once("picom", 'bash -c "DISPLAY=\':0\' picom -b --experimental-backends"')

    -- Polkit
    run_once("lxpolkit")
    run_once("gnome-keyring-daemon", "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh")


    -- Other tools
    run_once("thunar --daemon")

    run_once("cbatticon")
    run_once("nm-applet")
    run_once("flameshot")
    run_once("megasync")
    run_once("blueman-applet")
    run_once("pasystray")
    run_once("copyq")

    awful.spawn("bash ~/bin/wacom.sh", false)
end

autostart_apps()
