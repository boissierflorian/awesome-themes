---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful         = require("awful")
local bindings      = require("bindings")
local clientbuttons = bindings.mouse.client
local clientkeys    = bindings.client

---------------------------------------------------------------------
-- Clients Rule
---------------------------------------------------------------------
local clients_rule = { 
    rule = { },
    properties = {
        focus = awful.client.focus.filter,
        --raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        honor_workarea = true,
        honor_padding = true,
     }
}

---------------------------------------------------------------------
-- Titlebars Rule
---------------------------------------------------------------------
local titlebars_rule = { 
    rule_any = { 
        type = { 
            "dialog", 
            "normal" 
        } 
    },
    properties = {
        titlebars_enabled = false 
    } 
}

awful.rules.rules = {
    clients_rule,
    titlebars_rule
}