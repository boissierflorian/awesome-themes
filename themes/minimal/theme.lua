---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awesome, client = awesome, client

local gears         = require("gears")
local lain          = require("lain")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local dpi           = require("beautiful.xresources").apply_dpi
local mytable       = require("mytable")
local apps          = require("apps")
local separators    = require("wdgpack.separators")
local clickable     = require("wdgpack.clickable")
local theme_widgets = require("themes.minimal.widgets")


local minimal_style = require("themes.minimal.style")
local theme = minimal_style.theme

-- Separators
local bounds_sep = separators.space(dpi(10))
local sm_sep = separators.space(dpi(5))
local vertical_sep = separators.space(dpi(8), {
    border = true,
    border_right = dpi(2),
    border_color = theme.fg_focus
})

-- Wibar widgets
local clock_widget    = theme_widgets.clock(theme)
local vol_widget      = theme_widgets.vol(theme)
local bat_widget      = theme_widgets.bat(theme)
local net_widget      = theme_widgets.net(theme)
local cpu_widget      = theme_widgets.cpu(theme)
local mem_widget      = theme_widgets.mem(theme)
local temp_widget     = theme_widgets.temp(theme)
local shutdown_button = theme_widgets.shutdown_button(theme)

-- Screen padding
-- local screen_padding = { top = dpi(20), left = dpi(40), right = dpi(40), bottom = dpi(10) }

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag.new(awful.util.tagnames, s, awful.layout.layouts)

    s.mylayoutbox = theme_widgets.layoutbox(theme, s)
    s.mytaglist   = theme_widgets.taglist(theme, s)

    -- Create the wibox
    local wibox_width = s.workarea.width * 0.9
    s.mywibox = awful.wibar({ 
        position = "top",
        screen = s,
        stretch = false, 
        width = wibox_width, 
        height = dpi(30),
        bg = theme.bg_normal, 
        fg = theme.fg_normal 
    })

    -- Wibox custom properties
    s.mywibox.y = dpi(10)
    s.padding = {
        top = theme.screen_padding_top,
        left = theme.screen_padding_left,
        right = theme.screen_padding_right,
        bottom = theme.screen_padding_bottom,
    }

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            bounds_sep,
            s.mylayoutbox,
            sm_sep,
            vertical_sep,
            separators.space(dpi(16)),
            s.mytaglist,
        },
        { -- Middle widget
            layout = wibox.layout.manual,
            clock_widget,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            sm_sep,
            -- fsicon,
            -- fsbar,
            bat_widget,
            sm_sep,
            cpu_widget,
            sm_sep,
            temp_widget,
            sm_sep,
            mem_widget,
            sm_sep,
            -- volicon,
            -- volpercent,
            vol_widget,
            sm_sep,
            net_widget,
            sm_sep,
            vertical_sep,
            separators.space(dpi(8)),
            shutdown_button,
            bounds_sep,
        },
    }
end

return theme
