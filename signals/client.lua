-- {{{ Required libraries
local client, awesome = client, awesome
local awful = require("awful")
local beautiful = require("beautiful")

local function update_client_border(c, args)
    local args = args or {}
    c.border_color = args.border_color or beautiful.border_normal
    c.border_width = args.border_width or beautiful.border_width
end

local function reset_client_border(c)
    update_client_border(c)
end

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Border
    reset_client_border(c)
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) 
    reset_client_border(c)
end)

client.connect_signal("unfocus", function(c) 
    c.border_color         = beautiful.border_normal
    c.border_width = 0
    update_client_border(c, {
        border_color = beautiful.border_normal,
        border_width = 0
    })
end)

