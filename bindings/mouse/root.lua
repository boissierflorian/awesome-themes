local awful = require("awful")
local gears = require("gears")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility

root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))