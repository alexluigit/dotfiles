local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local shapes = require("helpers.shape")

local awesome_icon = require("bar.awesome_icon")
local get_taglist = require("bar.taglist")
local notif_icon = require("bar.notify_icon")
local final_systray = require("bar.systray")
local get_tasklist = require("bar.tasklist")
local playerctl_bar = require("bar.playerctl")

screen.connect_signal("request::desktop_decoration", function(s)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mytaglist = get_taglist(s)
    s.mytasklist = get_tasklist(s)
    awful.wibar({position = "bottom", screen = s}):setup{
        layout = wibox.layout.fixed.vertical,
        {
            layout = wibox.layout.align.horizontal,
            bg = beautiful.xcolor0,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    {
                        {
                            awesome_icon,
                            s.mytaglist,
                            spacing = 20,
                            spacing_widget = {
                                color = beautiful.xcolor8,
                                shape = shapes.pgram(4),
                                widget = wibox.widget.separator
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        bg = beautiful.xcolor0,
                        shape = shapes.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(5),
                    left = dpi(10),
                    right = dpi(5),
                    bottom = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    playerctl_bar,
                    margins = dpi(5),
                    widget = wibox.container.margin
                }
            },
            {
                {
                    {
                        s.mytasklist,
                        bg = beautiful.xcolor0 .. "00",
                        shape = shapes.rrect(6),
                        widget = wibox.container.background
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin
                },
                widget = wibox.container.constraint
            },
            {
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.textclock,
                {
                    awful.widget.only_on_screen(final_systray, screen[1]),
                    margins = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    {
                        {
                            s.mylayoutbox,
                            top = dpi(4),
                            bottom = dpi(4),
                            right = dpi(7),
                            left = dpi(7),
                            widget = wibox.container.margin
                        },
                        bg = beautiful.xcolor0,
                        shape = shapes.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    margins = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    {
                        notif_icon,
                        bg = beautiful.xcolor0,
                        shape = shapes.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(5),
                    right = dpi(10),
                    left = dpi(5),
                    bottom = dpi(5),
                    widget = wibox.container.margin
                },
            }
        }
    }
end)

local function remove_wibar(c)
    if c.fullscreen or c.maximized then
        c.screen.mywibox.visible = false
    else
        c.screen.mywibox.visible = true
    end
end
local function add_wibar(c)
    if c.fullscreen or c.maximized then
        c.screen.mywibox.visible = true
    end
end
awesome.connect_signal("widgets::splash::visibility", function(vis)
    screen.primary.mywibox.visible = not vis
end)
client.connect_signal("property::fullscreen", remove_wibar)
client.connect_signal("request::unmanage", add_wibar)
