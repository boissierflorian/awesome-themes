---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful      = require("awful")
local mytable    = require("mytable")

local function factory(theme, screen)
    local layoutbox = awful.widget.layoutbox(screen)
    
    layoutbox:buttons(mytable.join(
        awful.button({}, 1, function () awful.layout.inc(1) end),
        awful.button({}, 2, function () awful.layout.set(awful.layout.layouts[1]) end),
        awful.button({}, 3, function () awful.layout.inc(-1) end),
        awful.button({}, 4, function () awful.layout.inc( 1) end),
        awful.button({}, 5, function () awful.layout.inc(-1) end))
    )

    return layoutbox
end

return factory

