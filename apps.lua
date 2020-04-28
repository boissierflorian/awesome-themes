---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local os = { getenv = os.getenv }

return {
    terminal    = "terminator",
    scrlocker   = "betterlockscreen -l dim",
    rofi        = "rofi -modi drun,run -show drun -show-icons",
    editor      = os.getenv("EDITOR") or "code",
    guieditor   = os.getenv("GUI_EDITOR") or "/opt/vscode/bin/code --no-sandbox",
    browser     = os.getenv("BROWSER") or "brave-browser-stable",
    musicplayer = "spotify",
    screenshot  = "spectacle -b -n -o /tmp/screenshot.png && xclip -selection clipboard -target image/png -i /tmp/screenshot.png && paplay /usr/share/sounds/freedesktop/stereo/camera-shutter.oga"
}