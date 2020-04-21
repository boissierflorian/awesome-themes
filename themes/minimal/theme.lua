local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi

local awesome, client = awesome, client
local my_table = require("my_table")
local math = { floor = math.floor }
local apps = require("apps")
local separators = require("wdgpack.separators")
local clickable = require("wdgpack.clickable")

local theme                                     = {}
theme.dir                                       = beautiful.themes_dir .. "/minimal"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.icon_dir                                  = theme.dir .. "/icons/"
theme.icon_titlebar_dir                         = theme.dir .. "/icons/titlebar/"
theme.font                                      = "Hack 10"
theme.fg_normal                                 = "#b0aba8"
theme.fg_focus                                  = "#3e646f"
theme.bg_normal                                 = "#1c1c22"
theme.bg_focus                                  = "#1c1c22"
theme.fg_urgent                                 = "#000000"
theme.bg_urgent                                 = "#FFFFFF"
theme.border_width                              = dpi(4)
theme.border_normal                             = "#3e646f"
theme.border_focus                              = "#3e646f"
theme.exit_screen_bg                            = "#1c1c22"
theme.exit_screen_border                        = "#3e646f"
theme.exit_screen_border_width                  = dpi(4)
theme.taglist_fg_focus                          = "#FFFFFF"
theme.taglist_bg_focus                          = "#1c1c22"
theme.taglist_bg_normal                         = "#1c1c22"
theme.taglist_shape_border_width_focus = dpi(1)
theme.taglist_shape_border_color_focus = theme.bg_focus
theme.titlebar_bg_normal                        = "#191919"
theme.titlebar_bg_focus                         = "#262626"
theme.icon_color                                = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(130)
theme.tasklist_disable_icon                     = true
theme.prompt_width                              = dpi(300)
theme.useless_gap                               = dpi(10)
theme.awesome_icon                              = theme.icon_dir .."awesome.png"
theme.menu_submenu_icon                         = theme.icon_dir .. "submenu.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "square_unsel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "square_unsel.png"
theme.vol                                       = theme.icon_dir .. "vol.png"
theme.vol_low                                   = theme.icon_dir .. "vol_low.png"
theme.vol_no                                    = theme.icon_dir .. "vol_no.png"
theme.vol_mute                                  = theme.icon_dir .. "vol_mute.png"
theme.disk                                      = theme.icon_dir .. "disk.png"
theme.net                                       = theme.icon_dir .. "net.png"
theme.ram                                       = theme.icon_dir .. "ram.png"
theme.shutdown                                  = theme.icon_dir .. "shutdown.png"
theme.cancel                                    = theme.icon_dir .. "cancel.png"
theme.reboot                                    = theme.icon_dir .. "reboot.png"
theme.lock                                      = theme.icon_dir .. "lock.png"
theme.suspend                                   = theme.icon_dir .. "suspend.png"
theme.quit                                      = theme.icon_dir .. "quit.png"
theme.ac                                        = theme.icon_dir .. "ac.png"
theme.bat                                       = theme.icon_dir .. "bat.png"
theme.bat_low                                   = theme.icon_dir .. "bat_low.png"
theme.bat_no                                    = theme.icon_dir .. "bat_no.png"
theme.play                                      = theme.icon_dir .. "play.png"
theme.pause                                     = theme.icon_dir .. "pause.png"
theme.stop                                      = theme.icon_dir .. "stop.png"
theme.layout_tile                               = theme.icon_dir .. "tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "dwindle.png"
theme.layout_max                                = theme.icon_dir .. "max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "floating.png"
theme.titlebar_close_button_focus               = theme.icon_titlebar_dir .. "close_focus.png"
theme.titlebar_close_button_normal              = theme.icon_titlebar_dir .. "close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.icon_titlebar_dir .. "ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.icon_titlebar_dir .. "ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.icon_titlebar_dir .. "ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.icon_titlebar_dir .. "ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.icon_titlebar_dir .. "sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.icon_titlebar_dir .. "sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.icon_titlebar_dir .. "sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.icon_titlebar_dir .. "sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.icon_titlebar_dir .. "floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.icon_titlebar_dir .. "floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.icon_titlebar_dir .. "floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.icon_titlebar_dir .. "floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.icon_titlebar_dir .. "maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.icon_titlebar_dir .. "maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.icon_titlebar_dir .. "maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.icon_titlebar_dir .. "maximized_normal_inactive.png"

-- lain related
theme.layout_centerfair                         = theme.icon_dir .. "centerfair.png"
theme.layout_termfair                           = theme.icon_dir .. "termfair.png"
theme.layout_centerwork                         = theme.icon_dir .. "centerwork.png"

local markup = lain.util.markup
local blue   = theme.fg_focus
local red    = "#EB8F8F"
local green  = "#8FEB8F"

-- Separators
local bounds_sep = separators.space(dpi(10))
local sm_sep = separators.space(dpi(5))


-- Textclock
local textclock           = wibox.widget.textclock("<span font='Hack 13'>%a %b %d, %H:%M</span>")
      textclock.font      = theme.font
      textclock.align     = "center"

local clock_sep           = separators.space(dpi(8))

local textclock_container = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    clock_sep,
    textclock,
    clock_sep,
}

local time_widget = wibox.container.margin(textclock_container, 0, 0, 0, dpi(4), theme.border_normal)
time_widget.point = function(geo, args)
    return {
        x = args.parent.width / 2,
        y = dpi(4)
    }
end

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { textclock },
    notification_preset = {
        font = "Hack 13",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})


-- Battery
local bat_percent = wibox.widget.textbox()
bat_percent.font = theme.font
bat_percent.align = "left"
local batbar = wibox.widget {
    forced_height    = dpi(1),
    forced_width     = dpi(24),
    color            = theme.fg_focus,
    background_color = theme.bg_focus,
    margins          = 1,
    paddings         = 1,
    shape            = gears.shape.rectangle,
    widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
    timeout = 1,
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        bat_percent.text = string.format("%d %%", bat_now.perc)
        batbar:set_value(bat_now.perc / 100)
    end
})


local bat_shape = function(thickness, gap)
    return function(cr, width, height)
        -- top
        cr:rectangle(0, 0, width, thickness)
        -- left
        cr:rectangle(0, 0, thickness, height)
        -- right top part
        cr:rectangle(width - thickness, 0, thickness, (height / 2) - gap)
        -- right bottom part
        cr:rectangle(width - thickness, (height / 2) + gap, thickness, height)
        -- bottom
        cr:rectangle(0, height - thickness, width, thickness)
    end
end

local batbg = wibox.container.background(batbar, theme.fg_focus, bat_shape(1, 2))
local batcontainer = wibox.container.margin(batbg, dpi(2), dpi(7), dpi(8), dpi(8))
local bat_percent_container = wibox.container.margin(bat_percent, dpi(0), dpi(0), dpi(4), dpi(4))
local batwidget = wibox.widget {
    layout = wibox.layout.align.horizontal,
    batcontainer,
    sm_sep,
    bat_percent_container,
}


-- /home fs
--[[ commented because it needs Gio/Glib >= 2.54
local fsicon = wibox.widget.imagebox(theme.disk)
local fsbar = wibox.widget {
    forced_height    = dpi(1),
    forced_width     = dpi(59),
    -- color            = theme.fg_normal,
    color            = "#ff0000",
    background_color = theme.bg_normal,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(6),
    widget           = wibox.widget.progressbar,
}
theme.fs = lain.widget.fs {
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10.5" },
    settings  = function()
        if fs_now["/"].percentage < 90 then
            fsbar:set_color(theme.fg_normal)
        else
            fsbar:set_color("#EB8F8F")
        end
        fsbar:set_value(fs_now["/"].percentage / 100)
    end
}
local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, dpi(2), dpi(7), dpi(4), dpi(4))
--]]

-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol)
local volpercent = wibox.widget.textbox()
volpercent.font = theme.font
theme.volume = lain.widget.alsabar {
    width = dpi(59), border_width = 0,
    notification_preset = { font = theme.font },
    --togglechannel = "IEC958,3",
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(theme.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(theme.vol_low)
        else
            volicon:set_image(theme.vol)
        end

        volpercent.text = volume_now.level .. "%"
    end,
    colors = {
        background   = theme.bg_normal,
        mute         = red,
        unmute       = theme.fg_normal
    }
}
volicon:buttons(my_table.join (
          awful.button({}, 1, function()
            awful.spawn(string.format("%s -e alsamixer", apps.terminal))
          end),
          awful.button({}, 2, function()
            os.execute(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 3, function()
            os.execute(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 4, function()
            os.execute(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 5, function()
            os.execute(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end)
))
local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))

-- Network
local network_icon = wibox.widget.imagebox(theme.net)
local network_widget = wibox.widget.textbox()
network_widget.font = theme.font
network_widget.align = "center"
-- network_widget.forced_width = dpi(85)

function string_limit(value, max)
    local svalue = tostring(value or "")
    if svalue and #svalue > max then
        return svalue:sub(0, max)
    end

    return svalue
end


local lain_net = lain.widget.net {
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        local sent, received = net_now.sent, net_now.received
        sent = math.floor(tonumber(sent))
        received = math.floor(tonumber(received))

        sent = string_limit(sent, 3)
        received = string_limit(received, 3)

        network_widget.text = string.format("%3d / %3d KB", sent, received)
    end
}

local ram_icon = wibox.widget.imagebox(theme.ram)
local ram_widget = wibox.widget.textbox()
ram_widget.font = theme.font
ram_widget.align = "center"
local lain_mem = lain.widget.mem {
    settings        = function()
        local mem_used        = mem_now.used
        ram_widget.text = mem_used .. " MB"
    end
}

local shutdown_icon = wibox.widget.imagebox(theme.shutdown)

clickable(shutdown_icon, {
    left_button_action = function()
        local exit_screen = _G["exit_screen"]
        return exit_screen and exit_screen.show()
    end
})

-- Eminent-like task filtering
-- local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
-- awful.widget.taglist.filter.all = function (t, args)
--     if t.selected or #t:clients() > 0 then
--         return orig_filter(t, args)
--     end
-- end

-- Screen padding
local screen_padding = { top = dpi(20), left = dpi(40), right = dpi(40), bottom = dpi(10) }

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

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s, 
        filter = awful.widget.taglist.filter.all, 
        buttons = awful.util.taglist_buttons, 
        style = { 
            spacing = dpi(15), 
        },
        widget_template = {
            {
                {
                    id     = 'index_role',
                    widget = wibox.widget.textbox,
                    align = 'center',
                    forced_width = dpi(45)
                },
                id     = 'icon_role',
                bottom = dpi(4),
                color  = theme.border_normal,
                widget = wibox.container.margin,
            },
        id     = 'background_role',
        widget = wibox.container.background,
        create_callback = function(self, c3, index, objects)
            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            
            if (c3.selected) then
                self:get_children_by_id('icon_role')[1].color = theme.border_focus
            else
                self:get_children_by_id('icon_role')[1].color = theme.bg_normal
            end
        end,
        update_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            
            if (c3.selected) then
                self:get_children_by_id('icon_role')[1].color = theme.border_focus
            else
                self:get_children_by_id('icon_role')[1].color = theme.bg_normal
            end
        end,
        }
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

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
    s.padding = screen_padding

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            bounds_sep,
            s.mytaglist,
        },
        { -- Middle widget
            layout = wibox.layout.manual,
            sm_sep,
            time_widget,
            sm_sep
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            sm_sep,
            -- fsicon,
            -- fsbar,
            batwidget,
            sm_sep,
            ram_icon,
            sm_sep,
            ram_widget,
            sm_sep,
            volicon,
            volpercent,
            sm_sep,
            network_icon,
            network_widget,
            sm_sep,
            s.mylayoutbox,
            sm_sep,
            shutdown_icon,
            bounds_sep,
        },
    }
end

return theme
