---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local lain       = require("lain")
local wibox      = require("wibox")
local separators = require("wdgpack.separators")
local dpi        = require("beautiful.xresources").apply_dpi

local clock_sep  = separators.space(dpi(8))

local function factory(theme)
    local textclock     = wibox.widget.textclock("<span font='Hack 13'>%a %b %d, %H:%M</span>")
    textclock.font      = theme.font
    textclock.align     = "center"

    local textclock_container = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        clock_sep,
        textclock,
        clock_sep,
    }

    -- Calendar
    theme.cal = lain.widget.cal({
        attach_to = { textclock },
        notification_preset = {
            font = "Hack 12",
            fg   = theme.fg_normal,
            bg   = theme.bg_normal
        }
    })

    local clock_widget = wibox.container.margin(textclock_container, 0, 0, 0, dpi(4), theme.border_normal)
    clock_widget.point = function(geo, args)
        return {
            x = (args.parent.width / 2),
            y = dpi(4)
        }
    end

    return clock_widget
end

return factory

