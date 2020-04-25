---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------)
local os          = os
local lain        = require("lain")
local info_widget = require("themes.minimal.widgets.info_widget")
local dpi         = require("beautiful.xresources").apply_dpi
local clickable   = require("wdgpack.clickable")
local awful       = require("awful")
local mytable     = require("mytable")
local apps        = require("apps")


local function factory(theme)
    return info_widget(theme, {
        icon = theme.vol,
        lain_init = function(textbox, icon)
            local lain_alsabar = lain.widget.alsabar {
                width = dpi(59), border_width = 0,
                notification_preset = { font = theme.font },
                settings = function()
                    if volume_now.status == "off" then
                        icon:set_image(theme.vol_mute)
                    elseif volume_now.level == 0 then
                        icon:set_image(theme.vol_no)
                    elseif volume_now.level <= 50 then
                        icon:set_image(theme.vol_low)
                    else
                        icon:set_image(theme.vol)
                    end

                    textbox.text = volume_now.level .. "%"
                end,

                colors = {
                    background = theme.bg_normal,
                    mute       = red,
                    unmute     = theme.fg_normal
                }
            }

            -- Shortcut access reference
            theme.volume = lain_alsabar

            -- EVENTS
            clickable(icon, {
                left_button_action = function()
                    awful.spawn(string.format("%s -e alsamixer", apps.terminal))
                end,
                middle_button_action = function()
                    os.execute(string.format("%s set %s 100%%", lain_alsabar.cmd, lain_alsabar.channel))
                    lain_alsabar.update()
                end,
                right_button_action = function()
                    os.execute(string.format("%s set %s toggle", lain_alsabar.cmd, lain_alsabar.togglechannel or lain_alsabar.channel))
                    lain_alsabar.update()
                end,
                up_button_action = function()
                    os.execute(string.format("%s set %s 1%%+", lain_alsabar.cmd, lain_alsabar.channel))
                    lain_alsabar.update()
                end,
                down_button_action = function()
                    os.execute(string.format("%s set %s 1%%-", lain_alsabar.cmd, lain_alsabar.channel))
                    lain_alsabar.update()
                end,
            })
        end
    })
end

return factory