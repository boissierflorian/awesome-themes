---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful   = require("awful")
local mytable = require("mytable")
local keys    = require("bindings.keys")

---------------------------------------------------------------------
-- Bindings
---------------------------------------------------------------------
local clientbuttons = mytable.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),

    awful.button({ keys.modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    
    awful.button({ keys.modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

return clientbuttons