---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local client, awesome = client, awesome
local awful  = require("awful")

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

    -- Disable maximized status by default
    local current_tag = awful.screen.focused().selected_tag
    local current_layout = current_tag.layout

    -- TODO: stateful layouts aren't supported yet
    if type(current_layout) == "table" then
      if current_layout.name ~= "max" then
        c.maximized = false
      end
    end
end)
