---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful      = require("awful")
local wibox      = require("wibox")
local beautiful  = require("beautiful")
local dpi        = require("beautiful.xresources").apply_dpi

local function factory(theme, screen)
    local taglist = awful.widget.taglist({
        screen = screen, 
        filter = awful.widget.taglist.filter.all, 
        buttons = awful.util.taglist_buttons, 
        style = { 
            spacing = dpi(15), 
        },
        widget_template = {
            {
                {
                    id     = 'index_role',
                    widget = wibox.widget.textbox,
                    align = 'center',
                    forced_width = dpi(45)
                },
                id     = 'icon_role',
                bottom = dpi(4),
                color  = theme.border_normal,
                widget = wibox.container.margin,
            },
        id     = 'background_role',
        widget = wibox.container.background,
        create_callback = function(self, c3, index, objects)
            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            
            if (c3.selected) then
                self:get_children_by_id('icon_role')[1].color = theme.border_focus
            else
                self:get_children_by_id('icon_role')[1].color = theme.bg_normal
            end
        end,
        update_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            
            if (c3.selected) then
                self:get_children_by_id('icon_role')[1].color = theme.border_focus
            else
                self:get_children_by_id('icon_role')[1].color = theme.bg_normal
            end
        end,
        }
    })

    return taglist
end

return factory