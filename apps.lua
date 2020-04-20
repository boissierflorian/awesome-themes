local os = { getenv = os.getenv }

return {
    terminal = "terminator",
    scrlocker    = "i3lock",
    editor       = os.getenv("EDITOR") or "code",
    gui_editor   = os.getenv("GUI_EDITOR") or "gvim",
    browser      = os.getenv("BROWSER") or "firefox",
}