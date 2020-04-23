---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local naughty       = require("naughty")

local debugger = {}

debugger.notify = function(message)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Debugger",
        text = tostring(message) 
    })
end

debugger.table_keys = function(table)
    if not table or type(table) ~= "table" then return end
    local keys = {}

    for k, _ in pairs(table) do
        keys[#keys + 1] = k
    end

    return keys
end

debugger.table_to_string = function(table)
    local str = "{"

    for k, v in pairs(table) do
        str = str .. "\n\t" .. tostring(k) .. " = " .. tostring(v) 
    end

    str = str .. "\n}"

    return str
end

_G["debugger"] = debugger