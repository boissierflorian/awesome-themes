---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful      = require("awful")
local mytable    = require("mytable")
local clickable  = require("wdgpack.clickable")

local function factory(theme, screen)
    local layoutbox = awful.widget.layoutbox(screen)
    
    clickable(layoutbox, {
        left_button_action = function() awful.layout.inc(1) end,
        middle_button_action = function() awful.layout.set(awful.layout.layouts[1]) end,
        right_button_action = function() awful.layout.inc(-1) end,
        up_button_action = function() awful.layout.inc(1) end,
        down_button_action = function() awful.layout.inc(-1) end,
    })

    return layoutbox
end

return factory

