local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local myXBin = os.getenv("HOME") .. "/.local/bin/x/"
local dmenu = "rofi -show run -theme ~/.config/rofi/themes/dmenu.rasi"
local powermenu = myXBin .. "powermenu"
local smartpaste = myXBin .. "smartpaste"
local screenshots = "flameshot full -p " .. os.getenv("HOME") .. "/Pictures/screenshots"
local emacs_open = myXBin .. "lof -c Emacs -d 0 -r 'emacsclient -c' -k '\\We'"
local emacs_maybe = myXBin .. "emacs-x "
local hypkey = "Mod3"
local window = require("helpers.window")

-- Main Bindings
awful.keyboard.append_global_keybindings({
  awful.key({modkey}, "n", function() awful.spawn(emacs_maybe .. "down", false) end,
            {description = "focus next by index", group = "client"}),
  awful.key({modkey}, "p", function() awful.spawn(emacs_maybe .. "up", false) end,
            {description = "focus previous by index", group = "client"}),
  awful.key({modkey}, "q", function() awful.spawn(emacs_maybe .. "close", false) end,
            {description = "close", group = "client"}),
  awful.key({modkey}, "e", function() awful.spawn(emacs_open, false) end,
            {description = "launch emacs", group = "client"}),
  awful.key({modkey}, "t", function() awful.spawn("alacritty") end,
            {description = "open a terminal", group = "launcher"}),
  awful.key({modkey}, "s", function() awful.spawn("bravectl start") end,
            {description = "open brave", group = "launcher"}),
  awful.key({modkey}, "Left", function() awful.tag.viewprev() end,
            {description = "focus the next tag(desktop)", group = "tag"}),
  awful.key({modkey}, "Right", function() awful.tag.viewnext() end,
            {description = "focus the previous tag(desktop)", group = "tag"}),
  awful.key({modkey}, "Down", function() awful.client.swap.byidx(1) end,
            {description = "swap with next client by index", group = "client" }),
  awful.key({modkey}, "Up", function() awful.client.swap.byidx(-1) end,
            {description = "swap with previous client by index", group = "client" }),
  awful.key({modkey}, "Escape", function() awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end end,
            {description = "go back", group = "client"}),
  awful.key({}, "Delete", function() awful.spawn(powermenu) end,
            {description = "show exit screen", group = "awesome"}),
  awful.key({}, "Insert", function() awful.spawn(dmenu) end)
})

-- Launcher
awful.keyboard.append_global_keybindings({
  awful.key({hypkey}, "h", function() awful.spawn("floatwin -t -d 1920x2160+0+0 htop", false) end,
            {description = "open htop", group = "launcher"}),
  awful.key({hypkey}, "m", function() awful.spawn("floatwin -t -d 30%x80%+3%+10% ncmpcpp", false) end,
            {description = "open ncmpcpp", group = "launcher"}),
  awful.key({hypkey}, "n", function() awful.spawn("nautilus", false) end,
            {description = "open file browser", group = "launcher"}),
  awful.key({hypkey}, "i", function() awful.spawn("bravectl inco", false) end,
            {description = "open brave(inco)", group = "launcher"}),
  awful.key({hypkey}, "o", function() awful.spawn("floatwin -t -d 50%x50%+50%+50% -n 1 fmenu 1", false) end,
            {description = "open fmenu", group = "launcher"}),
  awful.key({hypkey}, "u", function() awful.spawn("murl main", false) end,
            {description = "open murl", group = "launcher"}),
  awful.key({hypkey}, "t", function() awful.spawn("murl toggle", false) end,
            {description = "toggle murl", group = "launcher"}),
  awful.key({hypkey}, "s", function() awful.spawn(screenshots, false) end,
            {description = "take screenshots", group = "launcher"}),
})

-- Client
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({hypkey}, "Left", function(c) window.resize_dwim(c, "left") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, "Right", function(c) window.resize_dwim(c, "right") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, "Up", function(c) window.resize_dwim(c, "up") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, "Down", function(c) window.resize_dwim(c, "down") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, " ", function(c) c.maximized = not c.maximized c:raise() end,
              {description = "(un)maximize", group = "client"}),
    awful.key({hypkey}, "Return", function(c) c:swap(awful.client.getmaster()) end,
              {description = "become master", group = "client"}),
    awful.key({hypkey}, "Delete", function(c) c.ontop = not c.ontop end,
              {description = "toggle keep top", group = "client"}),
    awful.key({hypkey}, "BackSpace", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"})
  })
end)

-- Function Keys
awful.keyboard.append_global_keybindings({
  awful.key({}, "F7", function() awful.spawn("playerctl -p mpd previous", false) end,
            {description = "playerctl previous", group = "awesome"}),
  awful.key({}, "F8", function() awful.spawn("playerctl -p mpd play-pause", false) end,
            {description = "toggle playerctl", group = "awesome"}),
  awful.key({}, "F9", function() awful.spawn("playerctl -p mpd next", false) end,
            {description = "playerctl next", group = "awesome"}),
  awful.key({}, "F10", function() awful.spawn("pulsemixer --toggle-mute", false) end,
            {description = "mute volume", group = "awesome"}),
  awful.key({}, "F11", function() awful.spawn("pulsemixer --change-volume -8", false) end,
            {description = "decrease volume", group = "awesome"}),
  awful.key({}, "F12", function() awful.spawn("pulsemixer --change-volume +8", false) end,
            {description = "increase volume", group = "awesome"}),
  awful.key({modkey}, "F1", hotkeys_popup.show_help,
            {description = "show help", group = "awesome"}),
  awful.key({modkey}, "F6", function() awful.spawn(smartpaste, false) end,
            {description = "smartpaste", group = "awesome"}),
})

-- Num row keybinds
awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers = {modkey},
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then tag:view_only() end
    end
  },
  awful.key {
    modifiers = {modkey, "Control"},
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then awful.tag.viewtoggle(tag) end
    end
  },
  awful.key {
    modifiers = {hypkey},
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then client.focus:move_to_tag(tag) end
      end
    end
  },
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c) c:activate{context = "mouse_click"} end),
    awful.button({}, 8, function() awful.spawn("xvkbd -text '\\Aq'", false) end),
    awful.button({}, 9, function() awful.spawn("xvkbd -text '\\At'", false) end),
    awful.button({modkey}, 1, function(c) c:activate{context = "mouse_click", action = "mouse_move"} end),
    awful.button({modkey}, 3, function(c) c:activate{context = "mouse_click", action = "mouse_resize"} end)
  })
end)
