---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------)
local lain        = require("lain")
local info_widget = require("themes.minimal.widgets.info_widget")
local dpi         = require("beautiful.xresources").apply_dpi

local function factory(theme)
    return info_widget(theme, {
        icon      = theme.bat,
        lain_init = function(textbox, icon)
            textbox.forced_width = dpi(44)

            local lain_bat  = lain.widget.bat({
                timeout = 2,
                settings = function()
                    if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

                    local percent = bat_now.perc

                    if percent > 90 then
                        icon:set_image(theme.bat)
                    elseif percent > 60 then
                        icon:set_image(theme.bat_med)
                    elseif percent > 40 then
                        icon:set_image(theme.bat_low)
                    else
                        icon:set_image(theme.bat_no)
                    end

                    textbox.text = string.format("%d %%", percent)
                end
            })
        end
    })
end

return factory