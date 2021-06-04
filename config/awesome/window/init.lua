local awful = require("awful")
local gears = require("gears")
local gfs = gears.filesystem.get_configuration_dir()
local beautiful = require("beautiful")

require("window.savefloats")
require("window.better-resize")
require("window.swallowing")
require("window.layout-list")
require("window.flash_focus")

client.connect_signal("manage", function(c)
  if awesome.startup and not c.size_hints.user_position and
    not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
  -- Give Alacritty icon
  if c.class == "Alacritty" or c.class == "ncmpcpp" or c.class ==
    "htop" or c.instance == "alacritty" then
    local new_icon = gears.surface(gfs .. "icons/ghosts/terminal.png")
    c.icon = new_icon._native
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Hide all windows when a splash is shown
-- awesome.connect_signal("widgets::splash::visibility", function(vis)
--     local t = screen.primary.selected_tag
--     if vis then
--         for _, c in ipairs(t:clients()) do c.hidden = true end
--     else
--         for _, c in ipairs(t:clients()) do c.hidden = false end
--     end
-- end)
