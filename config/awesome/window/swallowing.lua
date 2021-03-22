local awful = require("awful")
local window = require("helpers.window")
local dont_swallow_classname_list = {"Gimp", "Brave-browser"}

local function swallow(child)
    local parent = awful.client.focus.history.get(child.screen, 1)
    if not parent then return end
    if string.match(child.instance, "fmenu.*") and parent.instance == child.instance then
       window.turn_off(parent) return
    end
    for _, classname in ipairs(dont_swallow_classname_list) do
        if classname == parent.class then return end
    end
    local dna = "dna " .. parent.pid .. " " .. child.pid
    awful.spawn.easy_async_with_shell(dna, function(_, _, _, exitcode)
        if exitcode == 1 then return end
        parent.minimized = true

        child:connect_signal("unmanage", function()
          parent.minimized = false
        end)
    end)
end

client.connect_signal("manage", swallow)
