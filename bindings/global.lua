local awesome, os, client, screen = awesome, os, client, screen
local freedesktop = require("freedesktop")
local beautiful = require("beautiful")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local apps = require("apps")
local dpi = beautiful.xresources.apply_dpi
local keys = require("bindings.keys")
local lain = require("lain")
local my_table = require("my_table")

local modkey = keys.modkey
local altkey = keys.altkey

local groups = {
    hotkeys = "hotkeys",
    awesome = "awesome",
    tag = "tag",
    client = "client",
    layout = "layout",
    widgets = "widgets",
    launcher = "launcher"
}

local vi_focus = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274

local globalkeys =
    my_table.join(
    -- Take a screenshot
    awful.key(
        {altkey},
        "p",
        function()
            os.execute("screenshot")
        end,
        {description = "take a screenshot", group = groups.hotkeys}
    ),
    -- X screen locker
    awful.key(
        {modkey},
        "l",
        function()
            local exit_screen = _G["exit_screen"]
            if exit_screen and exit_screen.visible() then return end
            os.execute(apps.scrlocker)
        end,
        {description = "lock screen", group = groups.hotkeys}
    ),
    -- Exit screen
    awful.key(
        {modkey, "Control"},
        "l",
        function()
            local exit_screen = _G["exit_screen"]
            return exit_screen and exit_screen.show()
        end,
        {description = "lock screen", group = groups.hotkeys}
    ),
    -- Hotkeys
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = groups.awesome}),
    -- Tag browsing
    awful.key({modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = groups.tag}),
    awful.key({modkey}, "Right", awful.tag.viewnext, {description = "view next", group = groups.tag}),
    awful.key({modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = groups.tag}),
    -- Non-empty tag browsing
    -- awful.key(
    --     {altkey},
    --     "Left",
    --     function()
    --         lain.util.tag_view_nonempty(-1)
    --     end,
    --     {description = "view  previous nonempty", group = groups.tag}
    -- ),
    -- awful.key(
    --     {altkey},
    --     "Right",
    --     function()
    --         lain.util.tag_view_nonempty(1)
    --     end,
    --     {description = "view  previous nonempty", group = groups.tag}
    -- ),
    -- Default client focus
    awful.key(
        {altkey},
        "k",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = groups.client}
    ),
    awful.key(
        {altkey},
        "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = groups.client}
    ),
    -- By direction client focus
    awful.key(
        {modkey},
        "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus down", group = groups.client}
    ),
    awful.key(
        {modkey},
        "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus up", group = groups.client}
    ),
    awful.key(
        {modkey},
        "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus left", group = groups.client}
    ),
    awful.key(
        {modkey},
        "h",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus right", group = groups.client}
    ),
    awful.key(
        {modkey},
        "w",
        function()
            awful.util.mymainmenu:show()
        end,
        {description = "show main menu", group = groups.awesome}
    ),
    -- Layout manipulation
    awful.key(
        {modkey, "Shift"},
        "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "swap with next client by index", group = groups.client}
    ),
    awful.key(
        {modkey, "Shift"},
        "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with previous client by index", group = groups.client}
    ),
    awful.key(
        {modkey, "Control"},
        "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, "Control"},
        "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = groups.client}),
    awful.key(
        {altkey},
        "Tab",
        function()
            if cycle_prev then
                awful.client.focus.history.previous()
            else
                awful.client.focus.byidx(-1)
            end
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "cycle with previous/go back", group = groups.client}
    ),
    awful.key(
        {modkey, "Shift"},
        "Tab",
        function()
            if cycle_prev then
                awful.client.focus.byidx(1)
                if client.focus then
                    client.focus:raise()
                end
            end
        end,
        {description = "go forth", group = groups.client}
    ),
    -- Show/Hide Wibox
    awful.key(
        {modkey, "Shift"},
        "b",
        function()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = groups.awesome}
    ),
    -- On the fly useless gaps change
    awful.key(
        {altkey, "Control"},
        "+",
        function()
            lain.util.useless_gaps_resize(1)
        end,
        {description = "increment useless gaps", group = groups.tag}
    ),
    awful.key(
        {altkey, "Control"},
        "-",
        function()
            lain.util.useless_gaps_resize(-1)
        end,
        {description = "decrement useless gaps", group = groups.tag}
    ),
    -- Dynamic tagging
    awful.key(
        {modkey, "Shift"},
        "n",
        function()
            lain.util.add_tag()
        end,
        {description = "add new tag", group = groups.tag}
    ),
    awful.key(
        {modkey, "Shift"},
        "r",
        function()
            lain.util.rename_tag()
        end,
        {description = "rename tag", group = groups.tag}
    ),
    awful.key(
        {modkey, "Shift"},
        "Left",
        function()
            lain.util.move_tag(-1)
        end,
        {description = "move tag to the left", group = groups.tag}
    ),
    awful.key(
        {modkey, "Shift"},
        "Right",
        function()
            lain.util.move_tag(1)
        end,
        {description = "move tag to the right", group = groups.tag}
    ),
    awful.key(
        {modkey, "Shift"},
        "d",
        function()
            lain.util.delete_tag()
        end,
        {description = "delete tag", group = groups.tag}
    ),
    -- Standard program
    awful.key(
        { modkey },
        "x",
        function()
            awful.spawn(apps.terminal)
        end,
        {description = "open a terminal", group = groups.launcher}
    ),
    awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = groups.awesome}),
    awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = groups.awesome}),
    awful.key(
        {altkey, "Shift"},
        "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master width factor", group = groups.layout}
    ),
    awful.key(
        {altkey, "Shift"},
        "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master width factor", group = groups.layout}
    ),
    awful.key(
        {modkey, "Shift"},
        "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = "increase the number of master clients", group = groups.layout}
    ),
    awful.key(
        {modkey, "Shift"},
        "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = groups.layout}
    ),
    awful.key(
        {modkey, "Control"},
        "h",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = groups.layout}
    ),
    awful.key(
        {modkey, "Control"},
        "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = groups.layout}
    ),
    awful.key(
        {modkey},
        "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = groups.layout}
    ),
    awful.key(
        {modkey, "Shift"},
        "space",
        function()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = groups.layout}
    ),
    awful.key(
        {modkey, "Control"},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = groups.client}
    ),
    -- Dropdown application
    awful.key(
        {modkey},
        "z",
        function()
            awful.screen.focused().quake:toggle()
        end,
        {description = "dropdown application", group = groups.launcher}
    ),
    -- Widgets popups
    awful.key(
        {altkey},
        "c",
        function()
            if beautiful.cal then
                beautiful.cal.show(7)
            end
        end,
        {description = "show calendar", group = groups.widget}
    ),
    awful.key(
        {altkey},
        "h",
        function()
            if beautiful.fs then
                beautiful.fs.show(7)
            end
        end,
        {description = "show filesystem", group = groups.widget}
    ),
    -- Brightness
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            os.execute("xbacklight -inc 10")
        end,
        {description = "+10%", group = groups.hotkeys}
    ),
    awful.key(
        {},
        "XF86MonBrightnessDown",
        function()
            os.execute("xbacklight -dec 10")
        end,
        {description = "-10%", group = groups.hotkeys}
    ),
    -- ALSA volume control
    awful.key(
        {altkey, "Control"},
        "Up",
        function()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = groups.hotkeys}
    ),
    awful.key(
        {altkey, "Control"},
        "Down",
        function()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = groups.hotkeys}
    ),
    awful.key(
        {altkey},
        "m",
        function()
            os.execute(
                string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel)
            )
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = groups.hotkeys}
    ),
    awful.key(
        {altkey, "Control"},
        "m",
        function()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume 100%", group = groups.hotkeys}
    ),
    awful.key(
        {altkey, "Control"},
        "0",
        function()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume 0%", group = groups.hotkeys}
    ),
    -- Copy primary to clipboard (terminals to gtk)
    awful.key(
        {modkey, "Control"},
        "c",
        function()
            awful.spawn.with_shell("xsel | xsel -i -b")
        end,
        {description = "copy terminal to gtk", group = groups.hotkeys}
    ),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key(
        {modkey},
        "v",
        function()
            awful.spawn.with_shell("xsel -b | xsel")
        end,
        {description = "copy gtk to terminal", group = groups.hotkeys}
    ),
    -- User programs
    awful.key(
        {modkey},
        "b",
        function()
            awful.spawn(apps.browser)
        end,
        {description = "run browser", group = groups.launcher}
    ),
    awful.key(
        {modkey},
        "a",
        function()
            awful.spawn(apps.guieditor)
        end,
        {description = "run gui editor", group = groups.launcher}
    ),
    -- Rofi Launcher
    awful.key(
        {modkey},
        "r",
        function()
            awful.spawn(apps.rofi)
        end,
        {description = "run prompt", group = groups.launcher}
    ),
    awful.key(
        {modkey},
        "Return",
        function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = groups.awesome}
    )
    --]]
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = groups.tag}
        descr_toggle = {description = "toggle tag #", group = groups.tag}
        descr_move = {description = "move focused client to tag #", group = groups.tag}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = groups.tag}
    end
    globalkeys =
        my_table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, "Control"},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, "Control", "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus
        )
    )
end

-- Set keys
root.keys(globalkeys)
