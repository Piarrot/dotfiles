-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
require("awful.autofocus")
-- Widget and layout library

-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

require("user-settings") --LOAD SETTINGS

require("user-layouts")

require("user-desktop")


-- {{{ Key bindings

local globalkeys = gears.table.join(awful.key({ MODKEY }, "F1", hotkeys_popup.show_help, {
    description = "show help",
    group = "awesome"
}), awful.key({ MODKEY }, "Left", awful.tag.viewprev, {
    description = "view previous",
    group = "tag"
}), awful.key({ MODKEY }, "Right", awful.tag.viewnext, {
    description = "view next",
    group = "tag"
}), awful.key({ MODKEY }, "Escape", awful.tag.history.restore, {
    description = "go back",
    group = "tag"
}), awful.key({ MODKEY }, "j", function()
    awful.client.focus.byidx(1)
end, {
    description = "focus next by index",
    group = "client"
}), awful.key({ MODKEY }, "k", function()
    awful.client.focus.byidx(-1)
end, {
    description = "focus previous by index",
    group = "client"
}),
    --  awful.key({ MODKEY }, "w", function()
    --     mymainmenu:show()
    -- end, {
    --     description = "show main menu",
    --     group = "awesome"
    -- }),
    -- Layout manipulation
    awful.key({ MODKEY, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, {
        description = "swap with next client by index",
        group = "client"
    }), awful.key({ MODKEY, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, {
        description = "swap with previous client by index",
        group = "client"
    }), awful.key({ MODKEY, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, {
        description = "focus the next screen",
        group = "screen"
    }), awful.key({ MODKEY, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, {
        description = "focus the previous screen",
        group = "screen"
    }), awful.key({ MODKEY }, "u", awful.client.urgent.jumpto, {
        description = "jump to urgent client",
        group = "client"
    }), awful.key({ MODKEY }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "go back",
        group = "client"
    }), -- Standard program
    awful.key({ MODKEY }, "Return", function()
        awful.spawn(TERMINAL)
    end, {
        description = "open a terminal",
        group = "launcher"
    }), awful.key({ MODKEY, "Control" }, "r", awesome.restart, {
        description = "reload awesome",
        group = "awesome"
    }), awful.key({ MODKEY }, "l", function()
        awful.tag.incmwfact(0.05)
    end, {
        description = "increase master width factor",
        group = "layout"
    }), awful.key({ MODKEY }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, {
        description = "decrease master width factor",
        group = "layout"
    }), awful.key({ MODKEY, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, {
        description = "increase the number of master clients",
        group = "layout"
    }), awful.key({ MODKEY, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, {
        description = "decrease the number of master clients",
        group = "layout"
    }), awful.key({ MODKEY, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, {
        description = "increase the number of columns",
        group = "layout"
    }), awful.key({ MODKEY, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, {
        description = "decrease the number of columns",
        group = "layout"
    }), awful.key({ MODKEY }, "space", function()
        awful.layout.inc(1)
    end, {
        description = "select next",
        group = "layout"
    }), awful.key({ MODKEY, "Shift" }, "space", function()
        awful.layout.inc(-1)
    end, {
        description = "select previous",
        group = "layout"
    }), awful.key({ MODKEY, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {
                raise = true
            })
        end
    end, {
        description = "restore minimized",
        group = "client"
    }), -- Prompt
    awful.key({ MODKEY }, "space", function()
        awful.spawn(LAUNCHER)
    end, {
        description = "run prompt",
        group = "launcher"
    }), awful.key({ MODKEY }, "x", function()
        awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end, {
        description = "lua execute prompt",
        group = "awesome"
    }))

local clientkeys = gears.table.join(awful.key({ MODKEY }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, {
    description = "toggle fullscreen",
    group = "client"
}), awful.key({ MODKEY }, "q", function(c)
    c:kill()
end, {
    description = "close",
    group = "client"
}), awful.key({ MODKEY, "Control" }, "space", awful.client.floating.toggle, {
    description = "toggle floating",
    group = "client"
}), awful.key({ MODKEY, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
end, {
    description = "move to master",
    group = "client"
}), awful.key({ MODKEY }, "o", function(c)
    c:move_to_screen()
end, {
    description = "move to screen",
    group = "client"
}), awful.key({ MODKEY }, "t", function(c)
    c.ontop = not c.ontop
end, {
    description = "toggle keep on top",
    group = "client"
}), awful.key({ MODKEY }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end, {
    description = "minimize",
    group = "client"
}), awful.key({ MODKEY }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
end, {
    description = "(un)maximize",
    group = "client"
}), awful.key({ MODKEY, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end, {
    description = "(un)maximize vertically",
    group = "client"
}), awful.key({ MODKEY, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end, {
    description = "(un)maximize horizontally",
    group = "client"
}))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys, -- View tag only.
        awful.key({ MODKEY }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, {
            description = "view tag #" .. i,
            group = "tag"
        }), -- Toggle tag display.
        awful.key({ MODKEY, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, {
            description = "toggle tag #" .. i,
            group = "tag"
        }), -- Move client to tag.
        awful.key({ MODKEY, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, {
            description = "move focused client to tag #" .. i,
            group = "tag"
        }), -- Toggle tag on focused client.
        awful.key({ MODKEY, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, {
            description = "toggle focused client on tag #" .. i,
            group = "tag"
        }))
end

local clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
end), awful.button({ MODKEY }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.move(c)
end), awful.button({ MODKEY }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.resize(c)
end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = { -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = { "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry" },
            class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
                "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui", "veromix", "xtightvncviewer" },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = { "Event Tester" -- xev.
            },
            role = { "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating = true
        }
    }, -- Add titlebars to normal clients and dialogs
    -- {
    --     rule_any = {
    --         type = { "normal", "dialog" }
    --     },
    --     properties = {
    --         titlebars_enabled = true
    --     }
    -- } -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {
            raise = true
        })
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {
            raise = true
        })
        awful.mouse.client.resize(c)
    end))

    awful.titlebar(c):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {
--         raise = false
--     })
-- end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
-- }}}
