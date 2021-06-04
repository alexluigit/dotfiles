local ruled = require("ruled")
local awful = require("awful")
require("awful.autofocus")

ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      size_hints_honor = false,
      screen = awful.screen.preferred,
      placement = awful.placement.centered + awful.placement.no_overlap +
        awful.placement.no_offscreen
    }
  }
  ruled.client.append_rule {
    id = "floating",
    rule_any = {
      class = {"Blueman-manager", "fmenu"},
      role = {"pop-up"},
      name = {"Friends List", "Steam - News"}
    },
    properties = {floating = true}
  }
  ruled.client.append_rule {
    id = "ontop",
    rule_any = {
      class = {"mpv"}
    },
    callback = function(c) c:connect_signal("property::fullscreen", function() if not c.fullscreen then c.ontop = true end end) end,
    properties = {ontop = true}
  }
end)

screen.connect_signal("request::desktop_decoration", function(s)
  screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}
  awful.tag({"1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])
end)
