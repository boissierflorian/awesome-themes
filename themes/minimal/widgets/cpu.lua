---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------)
local lain        = require("lain")
local info_widget = require("themes.minimal.widgets.info_widget")
local dpi         = require("beautiful.xresources").apply_dpi

local function factory(theme)
    return info_widget(theme, {
        icon = theme.cpu,
        lain_init = function(textbox)
            textbox.forced_width = dpi(40)

            local lain_cpu = lain.widget.cpu {
                settings = function()
                    local cpu_usage = cpu_now.usage
                    textbox.text = string.format("%3d%%", cpu_usage)
                end
            }
        end
    })
end

return factory