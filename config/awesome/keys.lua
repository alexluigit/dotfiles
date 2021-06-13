local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local screenshots = "flameshot full -p " .. os.getenv("HOME") .. "/Pictures/screenshots"
local emacs_main = os.getenv("HOME") .. "/.local/bin/x/lof -f Emacs -D 0 -l 'emacsclient -c' -k '\\We'"
local emacs_lf = "floatwin -d 75%x96%+24%+1% -n lf-emacs emacsclient -ne '\\(lf-new-frame\\)'"
local powermenu = os.getenv("HOME") .. "/.local/bin/x/powermenu"
local smartpaste = os.getenv("HOME") .. "/.local/bin/x/smartpaste"
local hypkey = "Mod3"
local modkey = "Mod4"
local window = require("helpers.window")

local key_or_cmd = function (class, key, cmd, ...)
  if class == client.focus.class then
    awful.spawn("xvkbd -xsendevent -text " .. key, false)
  else
  if type(cmd) ~= "string" then cmd(...)
  else load("client.focus:" .. cmd)() end
  end
end

-- Main Bindings
awful.keyboard.append_global_keybindings({
  awful.key({"Control"}, "n", function() key_or_cmd("Brave-browser", "'\\[Down]'", awful.spawn, "xvkbd -xsendevent -text '\\Cn'", false) end,
            {description = "Send down arrow in some app", group = "client"}),
  awful.key({"Control"}, "p", function() key_or_cmd("Brave-browser", "'\\[Up]'", awful.spawn, "xvkbd -xsendevent -text '\\Cp'", false) end,
            {description = "Send up arrow in some app", group = "client"}),
  awful.key({modkey}, "n", function() key_or_cmd("Emacs", "'\\Wn'", awful.client.focus.byidx, 1) end,
            {description = "focus next", group = "client"}),
  awful.key({modkey}, "p", function() key_or_cmd("Emacs", "'\\Wp'", awful.client.focus.byidx, -1) end,
            {description = "focus previous", group = "client"}),
  awful.key({modkey}, "q", function() key_or_cmd("Emacs", "'\\Wq'", "kill()") end,
            {description = "close", group = "client"}),
  awful.key({modkey}, "e", function() awful.spawn(emacs_main, false) end,
            {description = "Launch emacs", group = "client"}),
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
  awful.key({modkey}, "Return", function() awful.spawn("alacritty", false) end,
            {description = "Open terminal", group = "client" }),
  awful.key({}, "Delete", function() awful.spawn(powermenu, false) end,
            {description = "Power menu", group = "awesome" }),
  awful.key({}, "Insert", function() awful.spawn("rofi -show run -theme dmenu.rasi", false) end,
            {description = "Power menu", group = "awesome" }),
})

-- Launcher
awful.keyboard.append_global_keybindings({
  awful.key({hypkey}, "f", function() awful.spawn(emacs_lf, false) end,
            {description = "open lf (in emacs)", group = "launcher"}),
  awful.key({hypkey}, "h", function() awful.spawn("floatwin -t -d 1920x2000+80+80 htop", false) end,
            {description = "open htop", group = "launcher"}),
  awful.key({hypkey}, "m", function() awful.spawn("floatwin -t -d 30%x80%+3%+10% ncmpcpp", false) end,
            {description = "open ncmpcpp", group = "launcher"}),
  awful.key({hypkey}, "w", function() awful.spawn("bravectl start", false) end,
            {description = "open brave", group = "launcher"}),
  awful.key({hypkey}, "i", function() awful.spawn("bravectl inco", false) end,
            {description = "open brave(inco)", group = "launcher"}),
  awful.key({hypkey}, "t", function() awful.spawn("murl toggle", false) end,
            {description = "toggle murl", group = "launcher"}),
  awful.key({hypkey}, "s", function() awful.spawn(screenshots, false) end,
            {description = "take screenshots", group = "launcher"}),
  awful.key({hypkey}, "v", function() awful.spawn("floatwin -c mpv:emacs-mpv", false) end,
            {description = "toggle playing video", group = "launcher"}),
})

-- Client
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({}, "F2", function(c) c.maximized = not c.maximized c:raise() end,
              {description = "(un)maximize", group = "client"}),
    awful.key({hypkey}, "Left", function(c) window.resize_dwim(c, "left") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, "Right", function(c) window.resize_dwim(c, "right") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, "Up", function(c) window.resize_dwim(c, "up") end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({hypkey}, "Down", function(c) window.resize_dwim(c, "down") end,
              {description = "increase master width factor", group = "layout"}),
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
  awful.key({}, "F1", function() awful.spawn("floatwin -d 64%x90%+35%+3% -c BraveDev: bravectl dev", false) end,
            {description = "toggle browser", group = "awesome"}),
  awful.key({}, "F7", function() awful.spawn("playerctl previous", false) end,
            {description = "playerctl previous", group = "awesome"}),
  awful.key({}, "F8", function() awful.spawn("playerctl play-pause", false) end,
            {description = "toggle playerctl", group = "awesome"}),
  awful.key({}, "F9", function() awful.spawn("playerctl next", false) end,
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
            {description = "show help", group = "awesome"}),
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
    awful.button({modkey}, 1, function(c) c:activate{context = "mouse_click", action = "mouse_move"} end),
    awful.button({modkey}, 3, function(c) c:activate{context = "mouse_click", action = "mouse_resize"} end)
  })
end)
