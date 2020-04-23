---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful = require("awful")
local gears = require("gears")
local lain = require("lain")
local keys = require("bindings.keys")
local mytable = require("mytable")

---------------------------------------------------------------------
-- Keys
---------------------------------------------------------------------
local altkey = keys.altkey
local modkey = keys.modkey

---------------------------------------------------------------------
-- Groups
---------------------------------------------------------------------
local groups = {
    client = "client"
}

---------------------------------------------------------------------
-- Shortcuts
---------------------------------------------------------------------
local clientkeys =
    mytable.join(
    awful.key({altkey, "Shift"}, "m", lain.util.magnify_client, {description = "magnify client", group = groups.client}),
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = groups.client}
    ),
    awful.key(
        {modkey},
        "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = groups.client}
    ),
    awful.key(
        {modkey, "Control"},
        "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = groups.client}
    ),
    awful.key(
        {modkey, "Control"},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = groups.client}
    ),
    awful.key(
        {modkey},
        "o",
        function(c)
            c:move_to_screen()
        end,
        {description = "move to screen", group = groups.client}
    ),
    awful.key(
        {modkey},
        "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = groups.client}
    ),
    -- awful.key(
    --     {modkey},
    --     "n",
    --     function(c)
    --         -- The client currently has the input focus, so it cannot be
    --         -- minimized, since minimized clients can't have the focus.
    --         c.minimized = true
    --     end,
    --     {description = "minimize", group = groups.client}
    -- ),
    awful.key(
        {modkey, "Shift"},
        "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "maximize", group = groups.client}
    )
)

return clientkeys
