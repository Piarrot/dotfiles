-- This is used later as the default terminal and editor to run.
TERMINAL = "alacritty"
LAUNCHER = "rofi -show run"
EDITOR = os.getenv("EDITOR") or "nvim"
LAUNCH_EDITOR_COMMAND = TERMINAL .. " -e " .. EDITOR

-- Default modkey.
MODKEY = "Mod4" --Super
