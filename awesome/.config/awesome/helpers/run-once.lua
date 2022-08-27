local awful = require("awful")

local function run_once(findme, cmd)
    local command = cmd
    if (cmd == nil) then
        command = findme
    end
    awful.spawn.easy_async_with_shell(string.format("ps aux | grep '%s' | grep -v 'grep'", findme), function(stdout)
        if stdout == "" or stdout == nil then
            awful.spawn(command, false)
        end
    end)
end

return run_once
