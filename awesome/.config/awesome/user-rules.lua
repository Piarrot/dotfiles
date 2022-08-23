local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

--- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height
local centered_client_placement = require("helpers.centered-client-placement")

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
            titlebars_enabled = beautiful.titlebar_enabled,
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
                "Lxappearance",
                "Nm-connection-editor",
            },
            name = {
                "MEGAsync",
                "Event Tester", -- xev
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
        properties = { floating = true },
    })
end)
