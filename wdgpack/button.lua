local button = {}

function button.new()
end

function button.mt:__call(...)
    return button.new(...)
end

return setmetatable(button, button.mt)