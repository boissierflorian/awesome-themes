---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------)
local lain        = require("lain")
local info_widget = require("themes.minimal.widgets.info_widget")
local dpi         = require("beautiful.xresources").apply_dpi

local function factory(theme)
    return info_widget(theme, {
        icon = theme.ram,
        lain_init = function(textbox)
            textbox.forced_width = dpi(61)

            local lain_mem = lain.widget.mem {
                settings  = function()
                    local mem_used = mem_now.used or 0
                    textbox.text = mem_used .. " MB"
                end
            }
        end
    })
end

return factory