-- Menubar configuration
local settings = require("user-settings")
local keys = settings.keys
local apps = settings.apps
local menubar = require("menubar")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
require("awful.autofocus")

menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(awful.button({}, 1, function(t)
    t:view_only()
end), awful.button({ keys.mod }, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
end), awful.button({}, 3, awful.tag.viewtoggle), awful.button({ keys.mod }, 3, function(t)
    if client.focus then
        client.focus:toggle_tag(t)
    end
end), awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
end), awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
end))

screen.connect_signal("request::desktop_decoration", function(s)
    --- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    if (s.index == 1) then
        -- Create the wibox
        s.mywibox = awful.wibar({
            position = "top",
            screen = s
        })

        -- Add widgets to the wibox
        s.mywibox:setup({
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,

                awful.widget.taglist {
                    screen = s,
                    filter = awful.widget.taglist.filter.all,
                    buttons = taglist_buttons
                },
            },
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                layout = wibox.layout.fixed.horizontal,

                wibox.widget.systray(),
                wibox.widget.textclock(),
            },

        })
    end
end)

--- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

--- Wallpapers
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            image                 = beautiful.wallpaper,
            resize                = true,
            widget                = wibox.widget.imagebox,
            horizontal_fit_policy = "fit",
            vertical_fit_policy   = "fit",
        }
    }
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
