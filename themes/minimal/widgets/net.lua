---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------)
local lain        = require("lain")
local info_widget = require("themes.minimal.widgets.info_widget")
local dpi         = require("beautiful.xresources").apply_dpi
local math        = { floor = math.floor }

local function factory(theme)
    return info_widget(theme, {
        icon = theme.net,
        spacing = 0,
        lain_init = function(textbox, icon)
            textbox.text = "Net"

            local lain_net = lain.widget.net {
                wifi_state = "on",
                eth_state = "on",
                settings = function()
                    local sent, received = net_now.sent, net_now.received
                    sent = math.floor(tonumber(sent))
                    received = math.floor(tonumber(received))

                    if sent < 1 and received < 1 then
                        icon:set_image(theme.net)
                    else
                        if sent > 0 and received < 1 then
                            icon:set_image(theme.net_send)
                        elseif received > 0 and sent < 1 then
                            icon:set_image(theme.net_receive)
                        else
                            icon:set_image(theme.net_send_and_receive)
                        end
                    end
                end
            }
        end
    })
end

return factory