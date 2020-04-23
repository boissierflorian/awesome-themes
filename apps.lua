---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local os = { getenv = os.getenv }

return {
    terminal  = "terminator",
    scrlocker = "betterlockscreen -l dim",
    rofi      = "rofi -modi drun,run -show drun -show-icons",
    editor    = os.getenv("EDITOR") or "code",
    guieditor = os.getenv("GUI_EDITOR") or "/opt/vscode/bin/code --no-sandbox",
    browser   = os.getenv("BROWSER") or "firefox",
    musicplayer = "spotify"
}