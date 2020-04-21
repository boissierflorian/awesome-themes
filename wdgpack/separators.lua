local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local separators = {}

separators.space = function(width, args)
    local width            = width or dpi(4)

    local args = args or {}
    local border = args.border or false
    local border_top = args.border_top or 0
    local border_bottom = args.border_bottom or 0
    local border_left = args.border_left or 0
    local border_right = args.border_right or 0
    local border_color = args.border_color
    local vertical = args.vertical or false
    
    local widget = wibox.widget.textbox()
    if vertical then
        widget.forced_height = width
    else
        widget.forced_width = width
    end

    if border then
        return wibox.container.margin(widget, border_left, border_right, border_top, border_bottom, border_color)
    end

    return widget
end

return separators