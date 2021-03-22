modkey = "Mod4"
require("beautiful").init(os.getenv("XDG_CONFIG_HOME") .. "/awesome/theme.lua")
require("window")
require("keys")
require("rules")
require("ears")
require("widget")
require("module")

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
