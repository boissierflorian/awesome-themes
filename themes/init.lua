---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local os, client = os, client
local awful     = require("awful")
local beautiful = require("beautiful")

-- local debug         = require("debug")
-- local themes_dir = debug.getinfo(1, 'S').source:match[[^@(.*/).*$]]
-- beautiful.themes_dir = themes_dir:sub(0, #themes_dir - 1)

beautiful.themes_dir = string.format("%s/.config/awesome/themes", os.getenv("HOME"))

local themes = { "minimal" }

local chosen_theme = themes[1]

require("themes.layout")

beautiful.init(string.format("%s/%s/theme.lua", beautiful.themes_dir, chosen_theme))