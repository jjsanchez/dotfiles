require "modules/layouts/layouts"
local flux = require "modules/flux/flux"

--require "modules/pomo/pomo"
--pomo()

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
        hs.alert.show("Config loaded")
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

local bigMash = {"cmd", "ctrl", "alt"}
hs.hotkey.bind(bigMash, "-", flux.decreaseLevel)
hs.hotkey.bind(bigMash, "=", flux.increaseLevel)
