---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local beautiful     = require("beautiful")
local style         = require("themes.base.style")
local dpi           = require("beautiful.xresources").apply_dpi
local naughty       = require("naughty")

---------------------------------------------------------------------
-- STYLE
---------------------------------------------------------------------
local theme_style = style({
    theme_directory = string.format("%s/minimal", beautiful.themes_dir),
    wallpaper = "images/wall.png",
})

---------------------------------------------------------------------
-- NOTIFICATIONS
---------------------------------------------------------------------
naughty.config.padding = dpi(16)


---------------------------------------------------------------------
-- FONTS
---------------------------------------------------------------------
theme_style.fonts({
    font = "Hack 10",
    clock_font = "Hack 13",
    clock_format = "%a %b %d, %H:%M",
    calendar_font = "Hack 10,"
})

---------------------------------------------------------------------
-- UNITS
---------------------------------------------------------------------
theme_style.units({
    border_width                     = dpi(4),
    exit_screen_border_width         = dpi(4),
    taglist_shape_border_width_focus = dpi(1),
    menu_height                      = dpi(16),
    menu_width                       = dpi(130),
    prompt_width                     = dpi(300),
    useless_gap                      = dpi(10),
    screen_padding_top               = dpi(20),
    screen_padding_left              = dpi(40),
    screen_padding_right             = dpi(40),
    screen_padding_bottom            = dpi(10),
    screen_padding_bottom            = dpi(10),
    notification_icon_size           = dpi(30),
})

---------------------------------------------------------------------
-- FLAGS
---------------------------------------------------------------------
theme_style.flags({
    tasklist_disable_icon  = true,
})

---------------------------------------------------------------------
-- COLORS
---------------------------------------------------------------------
theme_style.colors({
    fg_normal                                 = "#b0aba8",
    fg_focus                                  = "#3e646f",
    bg_normal                                 = "#1c1c22",
    bg_focus                                  = "#1c1c22",
    fg_urgent                                 = "#000000",
    bg_urgent                                 = "#FFFFFF",
    border_normal                             = "#3e646f",
    border_focus                              = "#3e646f",
    exit_screen_bg                            = "#1c1c22",
    exit_screen_border                        = "#3e646f",
    taglist_fg_focus                          = "#FFFFFF",
    taglist_bg_focus                          = "#1c1c22",
    taglist_bg_normal                         = "#1c1c22",
    taglist_shape_border_color_focus          = "#1c1c22",
    icon_color                                = "#3e646f",
})

---------------------------------------------------------------------
-- ICONS
---------------------------------------------------------------------
theme_style.icons({
    "awesome_icon.png",
    "menu_submenu_icon.png",
    "taglist_squares_unsel.png",
    "taglist_squares_unsel.png",
    "vol.png",
    "vol_low.png",
    "vol_no.png",
    "vol_mute.png",
    "disk.png",
    "net.png",
    "net_send.png",
    "net_receive.png",
    "net_send_and_receive.png",
    "ram.png",
    "cancel.png",
    "reboot.png",
    "lock.png",
    "suspend.png",
    "quit.png",
    "ac.png",
    "temp.png",
    "cpu.png",
    "bat.png",
    "bat_med.png",
    "bat_low.png",
    "bat_no.png",
    "play.png",
    "pause.png",
    "stop.png",
    "shutdown.png",
    "layout_tile.png",
    "layout_tileleft.png",
    "layout_tilebottom.png",
    "layout_tiletop.png",
    "layout_fairv.png",
    "layout_fairh.png",
    "layout_spiral.png",
    "layout_dwindle.png",
    "layout_max.png",
    "layout_fullscreen.png",
    "layout_magnifier.png",
    "layout_floating.png",
    "layout_cascade.png",
    "layout_cascadetile.png",
    "layout_centerfair.png",
    "layout_termfair.png",
    "layout_centerwork.png",
})

return theme_style