local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()
    --- Global
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            raise = true,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            screen = awful.screen.focused,
            focus = awful.client.focus.filter,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })

    --- Float
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = {
                "Devtools", --- Firefox devtools
            },
            class = {
                "zoom",
                "Lxappearance",
                "Nm-connection-editor",
            },
            name = {
                "Event Tester", -- xev
                "ColorGrab"
            },
            role = {
                "AlarmWindow",
                "pop-up",
                "GtkFileChooserDialog",
                "conversation",
            },
            type = {
                "dialog",
            },
        },
        properties = { floating = true, screen = awful.screen.focused },
    })

    ruled.client.append_rule({
        id = "MEGAsync",
        rule_any = {
            name = {
                "MEGAsync"
            }
        },
        properties = {
            floating = true,
            offset = 500,
            placement = awful.placement.resize_to_mouse + awful.placement.no_offscreen
        }
    })
end)
