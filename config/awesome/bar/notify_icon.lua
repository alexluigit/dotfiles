local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local notif_icon = wibox.widget {
    {
        wibox.widget {
            widget = wibox.widget.textbox,
            font = beautiful.icon_font,
            markup = "<span foreground='" .. beautiful.xcolor4 .. "'>" .. "" .. "</span>",
            resize = true
        },
        top = dpi(4),
        right = dpi(7),
        left = dpi(7),
        bottom = dpi(4),
        widget = wibox.container.margin
    },
    bg = beautiful.xcolor0,
    widget = wibox.container.background
}

notif_icon:buttons(gears.table.join(awful.button({}, 1, function()
    awesome.emit_signal("widgets::notif_panel::show", mouse.screen)
end)))

return notif_icon
