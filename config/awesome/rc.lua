require("beautiful").init(os.getenv("XDG_CONFIG_HOME") .. "/awesome/theme.lua")
require("window")
require("keys")
require("rules")
require("desktop")
require("ears")
require("bar")
require("widget")

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
