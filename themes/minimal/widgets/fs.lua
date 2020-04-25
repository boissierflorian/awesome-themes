
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