---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local wibox    = require("wibox")
local awful    = require("awful")
local mytable = require("mytable")
local mouse = mouse

local clickable = { mt = {} }

local function empty() end

function clickable.new(widget, args)
    local args = args or {}
    local hover_opacity = args.hover_opacity or 0.8
    local left_button_action = args.left_button_action or empty
    local middle_button_action = args.middle_button_action or empty
    local right_button_action = args.right_button_action or empty
    local up_button_action = args.up_button_action or empty
    local down_button_action = args.down_button_action or empty

    local old_cursor, old_wibox

    widget:connect_signal("mouse::enter", function(widget)
        widget.opacity = hover_opacity
        widget:emit_signal("widget::redraw_needed")

        local w = mouse.current_wibox
        if w then
            old_cursor, old_wibox = w.cursor, w
            w.cursor = 'hand2'
        end
    end)
    
    widget:connect_signal("mouse::leave", function(widget)
        widget.opacity = 1
        widget:emit_signal("widget::redraw_needed")

        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)
    
    local  widget_buttons = mytable.join(
        awful.button({}, 1, left_button_action),
        awful.button({}, 2, middle_button_action),
        awful.button({}, 3, right_button_action),
        awful.button({}, 4, up_button_action),
        awful.button({}, 5, down_button_action)
    )

    -- TODO  : Find a way to retrieve old buttons mapping in order to preserve them ...
     widget: buttons(widget_buttons)

    return widget
end

function clickable.mt:__call(...)
    return clickable.new(...)
end

return setmetatable(clickable, clickable.mt)