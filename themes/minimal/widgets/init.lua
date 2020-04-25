local widgets = {
    "layoutbox",
    "taglist",
    "clock",
    "bat",
    "cpu",
    "temp",
    "mem",
    "vol",
    "net",
    "shutdown_button", 
}

local module = {}

for _, widget in pairs(widgets) do
    module[widget] = require(string.format("themes.minimal.widgets.%s", widget))
end

return module