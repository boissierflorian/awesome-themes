---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local screen       = screen
local gears        = require("gears")
local wibox        = require("wibox")
local awful        = require("awful")
local naughty      = require("naughty")
local beautiful    = require("beautiful")
local mytable      = require("mytable")
local clickable    = require("wdgpack.clickable")
local separators   = require("wdgpack.separators")
local dpi          = require("beautiful.xresources").apply_dpi
local apps         = require("apps")
local lain_helpers = require("lain.helpers")

local theme = beautiful.get()

local exit_screen = {}

-- Get screen geometry
local screen_geometry = awful.screen.focused().geometry

-- Dimensions
local width  = dpi(170)
local height = dpi(360)

-- Base widget
local widget = wibox ({
    x       = (screen_geometry.width / 2) - (width / 2),
    y       = (screen_geometry.height / 2) - (height / 2),
    visible = false,
    ontop   = true,
    type    = 'splash',
    width   = width,
    height  = height,
    bg = beautiful.exit_screen_bg,
    border_color = beautiful.exit_screen_border,
    border_width = beautiful.exit_screen_border_width,
    shape = gears.shape.rounded_rect
})

local hide_wrapper = function()
    exit_screen.hide()
end

-- Buttons
widget:buttons(
    mytable.join(
        awful.button({}, 2, hide_wrapper),
        awful.button({}, 3, hide_wrapper)
    )
)

-- Key grabber
local keymap   = {
    ["Escape"] = hide_wrapper,
    ["q"] = hide_wrapper
}

local keygrabber = {
    instance = nil,
    run = function(_, key, event)
        if event == 'release' then return end
        
        local key_action = keymap[key]
        if key_action then
            key_action()
        end
    end
}

exit_screen.show = function()
    keygrabber.instance = awful.keygrabber.run(keygrabber.run)
    widget.visible = true
end

exit_screen.hide = function()
    awful.keygrabber.stop(keygrabber.instance)
    widget.visible = false
end

exit_screen.visible = function()
    return widget.visible
end

-- Items
local sm_sep = separators.space(dpi(4))
local md_sep = separators.space(dpi(16))


local function list_item(icon_path, text, callback)
    local imagebox       = wibox.widget.imagebox(icon_path)
    local textbox        = wibox.widget.textbox(text)
          textbox.font   = theme.font

    imagebox.forced_height = dpi(50)
    local item_widget    = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        md_sep,
        imagebox,
        md_sep,
        textbox
    }

    --item_widget.forced_height = dpi(50)
    clickable(item_widget, {
        hover_opacity = 0.7,
        left_button_action = callback
    })

    return item_widget
end

local empty = function() end

local shutdown_item = list_item(theme.shutdown, "Shutdown", function()
    exit_screen.hide()
    lain_helpers.async("systemctl poweroff", empty)
end)

local cancel_item = list_item(theme.cancel, "Cancel", hide_wrapper)

local lock_item = list_item(theme.lock, "Lock", function() 
    exit_screen.hide()
    lain_helpers.async(apps.scrlocker, empty)
end)

local quit_item = list_item(theme.quit, "Quit", function() 
    awesome.quit()
end)

local suspend_item = list_item(theme.suspend, "Suspend", function()
    exit_screen.hide()
    lain_helpers.async(apps.scrlocker .. " && systemctl suspend", empty)
end)

local reboot_item = list_item(theme.reboot, "Reboot", function()
    exit_screen.hide()
    lain_helpers.async("systemctl reboot", empty)
end)


local sep = wibox.widget {
    layout        = wibox.layout.align.horizontal,
    widget        = wibox.widget.separator,
    color         = "#ff0000",
    thickness     = 2,
    -- shape         = gears.shape.rectangle,
    orientation   = "horizontal",
    forced_width  = 200,
    forced_height = 10,
    border_width = 1,
    border_color = "#00ff00",
    visible       = true
}
sep.forced_height = 20
sep.visible = true

widget:setup {
    layout = wibox.layout.align.vertical,
    separators.space(dpi(20), { vertical = true }),
    {
        layout = wibox.layout.fixed.vertical,
        cancel_item,
        reboot_item,
        shutdown_item,
        separators.space(dpi(8), { vertical = true }),
        lock_item,
        suspend_item,
        quit_item
    },
    separators.space(dpi(25) , { vertical = true })
}


-- Global reference
_G["exit_screen"] = exit_screen

return exit_screen