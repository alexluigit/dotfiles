-- wibar.lua
local awful = require("awful")
local gears = require("gears")
local cfg = require("gears.filesystem").get_configuration_dir()
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local shapes = require("helpers.shape")
local systray_margin = (beautiful.wibar_height - beautiful.systray_icon_size) / 2

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar)
    bar.forced_width = dpi(100)
    bar.shape = shapes.rrect(beautiful.border_radius - 3)
    bar.bar_shape = shapes.rrect(beautiful.border_radius - 3)
    bar.background_color = beautiful.xcolor0
    return bar
end

-- Awesome Panel -----------------------------------------------------------

local icon1 = wibox.widget {
    widget = wibox.widget.imagebox,
    image = gears.surface.load_uncached(cfg .. "icons/ghosts/awesome.png"),
    resize = true
}

local awesome_icon = wibox.widget {
    {
        icon1,
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(10),
        right = dpi(5),
        widget = wibox.container.margin
    },
    bg = beautiful.xcolor0,
    widget = wibox.container.background
}

awesome_icon:buttons(gears.table.join(awful.button({}, 1, function()
    awesome.emit_signal("widgets::start::show", mouse.screen)
end)))

-- Taglist Panel -----------------------------------------------------------

local get_taglist = function(s)
  -- Taglist buttons
  local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({modkey}, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({modkey}, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end))

  -- The actual png icons
  -- I do have the svgs, but inkscape does a better job of scaling
  local ghost = gears.surface.load_uncached(cfg .. "icons/ghosts/ghost.png")
  local ghost_icon = gears.color.recolor_image(ghost, beautiful.xcolor6)
  local dot = gears.surface.load_uncached(cfg .. "icons/ghosts/dot.png")
  local dot_icon = gears.color.recolor_image(dot, beautiful.xcolor8)
  local pacman = gears.surface.load_uncached(cfg .. "icons/ghosts/pacman.png")
  local pacman_icon = gears.color.recolor_image(pacman, beautiful.xcolor3)

  -- Function to update the tags
  local update_tags = function(self, c3)
    local imgbox = self:get_children_by_id('icon_role')[1]
    if c3.selected then
      imgbox.image = pacman_icon
    elseif #c3:clients() == 0 then
      imgbox.image = dot_icon
    else
      imgbox.image = ghost_icon
    end
  end

  local pac_taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    style = {shape = gears.shape.rectangle},
    layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
    widget_template = {
      {
        {id = 'icon_role', widget = wibox.widget.imagebox},
        id = 'margin_role',
        top = dpi(7),
        bottom = dpi(7),
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
      create_callback = function(self, c3, index, objects)
        update_tags(self, c3)
        self:connect_signal('mouse::enter', function()
          if self.bg ~= beautiful.xbackground .. "60" then
            self.backup = self.bg
            self.has_backup = true
          end
          self.bg = beautiful.xbackground .. "60"
        end)
        self:connect_signal('mouse::leave', function()
          if self.has_backup then
            self.bg = self.backup
          end
        end)
      end,
      update_callback = function(self, c3, index, objects)
        update_tags(self, c3)
      end
    },
    buttons = taglist_buttons
  }
  return pac_taglist
end

-- Notifs Panel ---------------------------------------------------------------

local icon2 = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.icon_font,
    markup = "<span foreground='" .. beautiful.xcolor4 .. "'>" .. "" .. "</span>",
    resize = true
}

local notif_icon = wibox.widget {
    {
        icon2,
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

-- Battery Bar Widget ---------------------------------------------------------

local battery_bar = wibox.widget {
    max_value = 100,
    value = 70,
    forced_width = dpi(200),
    shape = shapes.rrect(beautiful.border_radius - 3),
    bar_shape = shapes.rrect(beautiful.border_radius - 3),
    color = {
        type = 'linear',
        from = {0, 0},
        to = {55, 20},
        stops = {
            {1 + (80) / 100, beautiful.xcolor10},
            {0.75 - (80 / 100), beautiful.xcolor9},
            {1 - (80) / 100, beautiful.xcolor10}
        }
    },
    background_color = beautiful.xcolor0,
    border_width = dpi(0),
    border_color = beautiful.border_color,
    widget = wibox.widget.progressbar
}

local battery_tooltip = awful.tooltip {}
battery_tooltip.shape = shapes.prrect(beautiful.border_radius - 3, true, true,
                                       false, false)
battery_tooltip.preferred_alignments = {"middle", "front", "back"}
battery_tooltip.mode = "outside"
battery_tooltip:add_to_object(battery_bar)
battery_tooltip.text = 'Not Updated'

awesome.connect_signal("ears::battery", function(value)
    battery_bar.value = value
    battery_bar.color = {
        type = 'linear',
        from = {0, 0},
        to = {75 - (100 - value), 20},
        stops = {
            {1 + (value) / 100, beautiful.xcolor10},
            {0.75 - (value / 100), beautiful.xcolor9},
            {1 - (value) / 100, beautiful.xcolor10}
        }
    }

    local bat_icon = ' '
    if value >= 90 and value <= 100 then
        bat_icon = ' '
    elseif value >= 70 and value < 90 then
        bat_icon = ' '
    elseif value >= 60 and value < 70 then
        bat_icon = ' '
    elseif value >= 50 and value < 60 then
        bat_icon = ' '
    elseif value >= 30 and value < 50 then
        bat_icon = ' '
    elseif value >= 15 and value < 30 then
        bat_icon = ' '
    else
        bat_icon = ' '
    end

    battery_tooltip.markup =
        " " .. "<span foreground='" .. beautiful.xcolor12 .. "'>" .. bat_icon ..
            "</span>" .. value .. '% '
end)

-- Timer for charging animation
local q = 0
local g = gears.timer {
    timeout = 0.03,
    call_now = false,
    autostart = false,
    callback = function()
        if q >= 100 then q = 0 end
        q = q + 1
        battery_bar.value = q
        battery_bar.color = {
            type = 'linear',
            from = {0, 0},
            to = {75 - (100 - q), 20},
            stops = {
                {1 + (q) / 100, beautiful.xcolor10},
                {0.75 - (q / 100), beautiful.xcolor1},
                {1 - (q) / 100, beautiful.xcolor10}
            }
        }
    end
}

-- The charging animation
local running = false
awesome.connect_signal("ears::charger", function(plugged)
    if plugged then
        g:start()
        running = true
    else
        if running then
            g:stop()
            running = false
        end
    end
end)

local battery = format_progress_bar(battery_bar)

-- Systray Widget -------------------------------------------------------------

local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
    mysystray,
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin
}

-- Tasklist Buttons -----------------------------------------------------------

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
  if c == client.focus then c.minimized = true
  else c:emit_signal("request::activate", "tasklist", {raise = true}) end
  end),
  awful.button({}, 3, function() awful.menu.client_list({theme = {width = 250}}) end),
  awful.button({}, 4, function() awful.client.focus.byidx(1) end),
  awful.button({}, 5, function() awful.client.focus.byidx(-1) end))

-- Playerctl Bar Widget -------------------------------------------------------

-- Title Widget
local song_title = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_artist = wibox.widget {
    markup = 'nothing playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_logo = wibox.widget {
    markup = '<span foreground="' .. beautiful.xcolor6 .. '"></span>',
    font = beautiful.icon_font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local playerctl_bar = wibox.widget {
    {
        {
            {
                song_logo,
                left = dpi(3),
                right = dpi(10),
                bottom = dpi(1),
                widget = wibox.container.margin
            },
            {
                {
                    song_title,
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            {
                {
                    song_artist,
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                left = dpi(10),
                widget = wibox.container.margin
            },
            spacing = 1,
            spacing_widget = {
                bg = beautiful.xcolor8,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    },

    bg = beautiful.xcolor0,
    shape = shapes.rrect(beautiful.border_radius - 3),
    widget = wibox.container.background
}

playerctl_bar.visible = false

awesome.connect_signal("bling::playerctl::player_stopped", function() playerctl_bar.visible = false end)

-- Get Title
awesome.connect_signal("bling::playerctl::title_artist_album", function(title, artist, _)
  playerctl_bar.visible = true
  song_title.markup = '<span foreground="' .. beautiful.xcolor5 .. '">' .. title .. '</span>'
  song_artist.markup = '<span foreground="' .. beautiful.xcolor4 .. '">' .. artist .. '</span>'
end)

-- Create the Wibar -----------------------------------------------------------

screen.connect_signal("request::desktop_decoration", function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create layoutbox widget
    s.mylayoutbox = awful.widget.layoutbox(s)
    -- Create the wibox
    s.mywibox = awful.wibar({position = "bottom", screen = s})
    -- Remove wibar on full screen
    local function remove_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = false
        else
            c.screen.mywibox.visible = true
        end
    end
    -- Remove wibar on full screen
    local function add_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = true
        end
    end
    -- Hide bar when a splash widget is visible
    awesome.connect_signal("widgets::splash::visibility", function(vis)
        screen.primary.mywibox.visible = not vis
    end)
    client.connect_signal("property::fullscreen", remove_wibar)
    client.connect_signal("request::unmanage", add_wibar)
    -- Create the taglist widget
    s.mytaglist = get_taglist(s)
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        bg = beautiful.xcolor0,
        style = {bg = beautiful.xcolor0},
        layout = {
            spacing = dpi(0),
            spacing_widget = {
                bg = beautiful.xcolor8,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    nil,
                    awful.widget.clienticon,
                    nil,
                    layout = wibox.layout.fixed.horizontal
                },
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }
    local final_systray = wibox.widget {
        {mysystray_container, top = dpi(5), layout = wibox.container.margin},
        bg = beautiful.xcolor0,
        shape = shapes.rrect(beautiful.border_radius - 3),
        widget = wibox.container.background
    }
    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.fixed.vertical,
        {
            widget = wibox.container.background,
            bg = beautiful.xcolor0,
            forced_height = beautiful.widget_border_width
        },
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    {
                        {
                            awesome_icon,
                            s.mytaglist,
                            spacing = 18,
                            spacing_widget = {
                                color = beautiful.xcolor8,
                                shape = gears.shape.powerline,
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
                s.mypromptbox,
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
                        shape = shapes.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    margins = dpi(5),
                    widget = wibox.container.margin
                },
                widget = wibox.container.constraint
            },
            {
                -- {
                --     {
                --         {
                --             battery,
                --             margins = dpi(5),
                --             widget = wibox.container.margin
                --         },
                --         bg = beautiful.xcolor0,
                --         shape = shapes.rrect(beautiful.border_radius - 3),
                --         widget = wibox.container.background
                --     },
                --     margins = dpi(5),
                --     widget = wibox.container.margin
                -- },
                -- nil,
                -- nil,
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

                layout = wibox.layout.fixed.horizontal
            }
        }
    }
end)

-- EOF ------------------------------------------------------------------------
