---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local wibox      = require("wibox")
local clickable  = require("wdgpack.clickable")

local function factory(theme, screen)
    local shutdown_button = wibox.widget.imagebox(theme.shutdown)

    clickable(shutdown_button, {
        left_button_action = function()
            local exit_screen = _G["exit_screen"]
            return exit_screen and exit_screen.show()
        end,
    })

    return shutdown_button
end

return factory