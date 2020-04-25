---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local wibox      = require("wibox")
local lain       = require("lain")
local separators = require("wdgpack.separators")
local dpi        = require("beautiful.xresources").apply_dpi

local info_widget = { mt = {} }

function info_widget.info_widget(theme, args)
    -- local icon_path = theme.icon_dir .. (args.icon or "")
    local icon_path = args.icon
    local font      = args.theme or theme.font
    local align     = args.align or "center"
    local spacing   = separators.space(dpi(args.spacing or 5))
    local lain_init = args.lain_init

    local icon          = wibox.widget.imagebox(icon_path)
    local textbox       = wibox.widget.textbox()
    textbox.font  = font
    textbox.align = align

    if lain_init then
        lain_init(textbox, icon)
    end

    return wibox.widget {
        layout = wibox.layout.align.horizontal,
        icon,
        spacing,
        textbox
    } 
end

function info_widget.mt:__call(...)
    return info_widget.info_widget(...)
end

return setmetatable(info_widget, info_widget.mt)