---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awful = require("awful")

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

--run_once({ "urxvtd", "unclutter -root" }) -- entries must be separated by commas
run_once({
    "numlockx on",
    "compton -c --backend glx --vsync opengl-swc"
})