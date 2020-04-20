local awesome = awesome
local freedesktop = require("freedesktop")
local beautiful = require("beautiful")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local apps = require("apps")
local dpi           = beautiful.xresources.apply_dpi

local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", apps.terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", apps.terminal, apps.editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or dpi(16),
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", apps.terminal },
        -- other triads can be put here
    }
})