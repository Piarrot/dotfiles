-- This is used later as the default terminal and editor to run.
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nvim"
local launch_editor = terminal .. " -e " .. editor

return {
    keys = {
        mod = "Mod4", --SUPER
        alt = "Mod1",
        ctrl = "Control",
        shift = "Shift",
    },
    apps = {
        terminal = terminal,
        launcher = "rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-5.rasi",
        launch_editor = launch_editor,
        file_manager = "thunar",
        launch_compositor = 'DISPLAY=":0" picom -b --experimental-backends && DISPLAY=":1" picom -b --experimental-backends',
        screenshot = "flameshot",
        trigger_screenshot = "flameshot gui"
    }
}
