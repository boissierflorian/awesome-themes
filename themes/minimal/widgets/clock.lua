---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local lain       = require("lain")
local wibox      = require("wibox")
local separators = require("wdgpack.separators")
local dpi        = require("beautiful.xresources").apply_dpi

local clock_sep  = separators.space(dpi(8))

local function factory(theme)
    local clock_font = theme.clock_font
    local calendar_font = theme.calendar_font
    local clock_format = theme.clock_format

    local textclock_markup = string.format("<span font='%s'>%s</span>", clock_font, clock_format)
    local textclock        = wibox.widget.textclock(textclock_markup)
          textclock.font   = clock_font
          textclock.align  = "center"

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
            font = calendar_font,
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

