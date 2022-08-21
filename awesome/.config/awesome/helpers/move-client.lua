local beautiful = require("beautiful")
local awful = require("awful")

local function move_to_edge(c, direction)
    local workarea = awful.screen.focused().workarea
    if direction == "up" then
        c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
    elseif direction == "down" then
        c:geometry({
            nil,
            y = workarea.height
                + workarea.y
                - c:geometry().height
                - beautiful.useless_gap * 2
                - beautiful.border_width * 2,
            nil,
            nil,
        })
    elseif direction == "left" then
        c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
    elseif direction == "right" then
        c:geometry({
            x = workarea.width
                + workarea.x
                - c:geometry().width
                - beautiful.useless_gap * 2
                - beautiful.border_width * 2,
            nil,
            nil,
            nil,
        })
    end
end

return function(c, direction)
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        move_to_edge(c, direction)
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end
