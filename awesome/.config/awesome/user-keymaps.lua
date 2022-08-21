local settings = require("user-settings")
local awful = require("awful")
local keys = settings.keys
local apps = settings.apps
local resize_client = require("helpers.resize-client")
local move_client = require("helpers.move-client")
local naughty = require("naughty")

-- Hotkeys popup
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

awful.keyboard.append_global_keybindings({
    -- Terminal
    awful.key({ keys.mod }, "Return", function()
        awful.spawn(apps.terminal)
    end, { description = "open terminal", group = "app" }),

    -- App Launcher
    awful.key({ keys.mod }, " ", function()
        awful.spawn(apps.launcher)
    end, { description = "open app launcher", group = "app" }),

    --- File manager
    awful.key({ keys.mod }, "e", function()
        awful.spawn(apps.file_manager)
    end, { description = "open file manager", group = "app" }),


    --- Focus Windows by direction
    awful.key({ keys.mod }, "Up", function()
        awful.client.focus.bydirection("up")
    end, { description = "focus up", group = "client" }),
    awful.key({ keys.mod }, "Down", function()
        awful.client.focus.bydirection("down")
    end, { description = "focus down", group = "client" }),
    awful.key({ keys.mod }, "Left", function()
        awful.client.focus.bydirection("left")
    end, { description = "focus left", group = "client" }),
    awful.key({ keys.mod }, "Right", function()
        awful.client.focus.bydirection("right")
    end, { description = "focus right", group = "client" }),


    awful.key({ keys.mod, keys.ctrl }, "Up", function(c)
        resize_client(client.focus, "up")
    end, { description = "resize to the up", group = "client" }),
    awful.key({ keys.mod, keys.ctrl }, "Down", function(c)
        resize_client(client.focus, "down")
    end, { description = "resize to the down", group = "client" }),
    awful.key({ keys.mod, keys.ctrl }, "Left", function(c)
        resize_client(client.focus, "right")
    end, { description = "resize to the left", group = "client" }),
    awful.key({ keys.mod, keys.ctrl }, "Right", function(c)
        resize_client(client.focus, "left")
    end, { description = "resize to the right", group = "client" }),

    --- VOLUME CONTROL
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn("amixer sset Master 5%+", false)
        awesome.emit_signal("widget::volume")
        awesome.emit_signal("module::volume_osd:show", true)
    end, { description = "increase volume", group = "hotkeys" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn("amixer sset Master 5%-", false)
        awesome.emit_signal("widget::volume")
        awesome.emit_signal("module::volume_osd:show", true)
    end, { description = "decrease volume", group = "hotkeys" }),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn("amixer sset Master toggle", false)
    end, { description = "mute volume", group = "hotkeys" }),

    --- Music
    -- awful.key({}, "XF86AudioPlay", function()
    --     playerctl_daemon:play_pause()
    -- end, { description = "play pause music", group = "hotkeys" }),
    -- awful.key({}, "XF86AudioPrev", function()
    --     playerctl_daemon:previous()
    -- end, { description = "previous music", group = "hotkeys" }),
    -- awful.key({}, "XF86AudioNext", function()
    --     playerctl_daemon:next()
    -- end, { description = "next music", group = "hotkeys" }),

    --- Color picker
    -- awful.key({ keys.mod }, "x", function()
    --     awful.spawn.easy_async_with_shell(apps.utils.color_picker, function() end)
    -- end, { description = "open color picker", group = "hotkeys" }),

    --- Screenshots
    awful.key({}, "Print", function()
        awful.spawn(apps.trigger_screenshot, function() end)
    end, { description = "take a full screenshot", group = "hotkeys" }),

    --- Restart awesome
    awful.key({ keys.mod, keys.ctrl }, "r", awesome.restart, { description = "reload awesome", group = "WM" }),

    --- Quit awesome
    awful.key({ keys.mod, keys.ctrl }, "q", awesome.quit, { description = "quit awesome", group = "WM" }),

    --- Show help
    awful.key({ keys.mod }, "F1", hotkeys_popup.show_help, { description = "show Help", group = "WM" }),
})

-----------------------------------------------
-- TAGS
-----------------------------------------------
for i = 1, 9 do
    awful.keyboard.append_global_keybindings({
        awful.key({ keys.mod }, "#" .. i + 9, function()
            local tag = awful.screen.focused().tags[i]
            if tag then
                tag:view_only()
            end
        end, {
            description = "view tag #" .. i,
            group = "tag"
        }),

        awful.key({ keys.mod, "Control" }, "#" .. i + 9, function()
            local tag = awful.screen.focused().tags[i]
            if tag then
                client.focus:move_to_tag(tag);
            end
        end, {
            description = "move focused client to tag #" .. i,
            group = "tag"
        }), -- Move client to tag.
    })
end

awful.mouse.append_global_mousebindings({
    --- Left click
    awful.button({}, 1, function()
        naughty.destroy_all_notifications()
    end),
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- Move or swap by direction
        awful.key({ keys.mod, keys.shift }, "Up", function(c)
            move_client(c, "up")
        end),
        awful.key({ keys.mod, keys.shift }, "Down", function(c)
            move_client(c, "down")
        end),
        awful.key({ keys.mod, keys.shift }, "Left", function(c)
            move_client(c, "left")
        end),
        awful.key({ keys.mod, keys.shift }, "Right", function(c)
            move_client(c, "right")
        end),

        --- Toggle floating
        awful.key({ keys.mod }, "s", awful.client.floating.toggle),

        --- Toggle fullscreen
        awful.key({ keys.mod }, "f", function()
            client.focus.fullscreen = not client.focus.fullscreen
            client.focus:raise()
        end),

        --- Toggle maximize windows
        awful.key({ keys.mod }, "m", function(c)
            c.maximized = not c.maximized
        end, { description = "toggle maximize", group = "client" }),

        --- Toggle Sticky
        awful.key({ keys.mod, keys.shift }, "p", function(c)
            c.sticky = not c.sticky
        end),

        --- Close window
        awful.key({ keys.mod }, "q", function()
            client.focus:kill()
        end),

        --- Center window
        awful.key({ keys.mod }, "c", function(c)
            awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
        end),
    })
end)

--- Mouse buttons on the client
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        awful.button({ keys.mod }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        awful.button({ keys.mod }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
    })
end)
