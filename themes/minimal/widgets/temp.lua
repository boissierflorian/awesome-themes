---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------)
local lain        = require("lain")
local info_widget = require("themes.minimal.widgets.info_widget")

local function factory(theme)
    return info_widget(theme, {
        icon = theme.temp,
        lain_init = function(textbox)
            local lain_temp = lain.widget.temp {
                settings = function()
                    local temp = coretemp_now
                    textbox.text = string.format("%2d°", temp)
                end
            }
        end
    })
end

return factory