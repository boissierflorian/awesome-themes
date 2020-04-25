local beautiful = require("beautiful")

local style = { mt = {}, theme = {} }

function style.new(args)
    local args = args or {}
    style.theme_directory = args.theme_directory -- todo default theme dir ?
    style.icon_directory = style.theme_directory .. "/icons/"

    -- Legacy
    style.theme.wallpaper = style.theme_directory .. "/" .. args.wallpaper
    style.theme.font = args.font

    return style
end


function style.icon(path)
    local icon_key = path:match[[^(.+)%.%a+$]]
    style.theme[icon_key] = style.icon_directory .. path
end

function style.icons(paths)
    for _, path in pairs(paths) do 
        style.icon(path)
    end
end

local function merge_values(tab)
    for k, v in pairs(tab) do
        style.theme[k] = v
    end
end

function style.colors(colors) merge_values(colors) end
function style.units(units) merge_values(units) end
function style.flags(flags) merge_values(flags) end

function style.mt:__call(...) return style.new(...) end

return setmetatable(style, style.mt)