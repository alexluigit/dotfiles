local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local shapes = require("helpers.shape")

local timedate = {}

-- Date Widget --

local date_text = wibox.widget {
    font = beautiful.font,
    format = "%m/%d/%y",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

date_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'>" ..
                       date_text.text .. "</span>"

date_text:connect_signal("widget::redraw_needed", function()
    date_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'>" ..
                           date_text.text .. "</span>"
end)

local date_icon = wibox.widget {
    font = beautiful.icon_font_name .. "12",
    markup = "<span foreground='" .. beautiful.xcolor11 .. "'></span>",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local date_pill = wibox.widget {
    {
        {date_icon, top = dpi(1), widget = wibox.container.margin},
        shapes.horizontal_pad(10),
        {date_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}

function timedate.date () return date_pill end

-- Time Widget --

local time_text = wibox.widget {
    font = beautiful.font,
    format = "%l:%M %P",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

time_text.markup = "<span foreground='" .. beautiful.xcolor5 .. "'>" ..
                       time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
    time_text.markup = "<span foreground='" .. beautiful.xcolor5 .. "'>" ..
                           time_text.text .. "</span>"
end)

local time_icon = wibox.widget {
    font = beautiful.icon_font_name .. "12",
    markup = "<span foreground='" .. beautiful.xcolor5 .. "'></span>",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local time_pill = wibox.widget {
    {
        {time_icon, top = dpi(1), widget = wibox.container.margin},
        shapes.horizontal_pad(10),
        {time_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}

function timedate.time () return time_pill end

return timedate
