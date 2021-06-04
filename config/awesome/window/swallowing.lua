local awful = require("awful")
local dont_swallow_parent_list = {"Gimp", "Brave-browser", "Emacs"}
local dont_swallow_child_list = {"Alacritty"}

local function swallow(child)
  local parent = awful.client.focus.history.get(child.screen, 1)
  if not parent then return end
  for _, classname in ipairs(dont_swallow_parent_list) do
    if classname == parent.class then return end
  end
  for _, classname in ipairs(dont_swallow_parent_list) do
    if classname == parent.class then return end
  end
  if string.match(child.instance, "fmenu.*") and parent.instance == child.instance then
    parent.minimized = true
  end
  for _, classname in ipairs(dont_swallow_child_list) do
    if classname ~= child.class then
    parent.minimized = true
    end
  end
  child:connect_signal("request::unmanage", function()
    parent.minimized = false
  end)
end

client.connect_signal("request::manage", swallow)

