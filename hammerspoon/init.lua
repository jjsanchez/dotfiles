local layouts = require "modules/layouts/layouts"
local flux = require "modules/flux/flux"
local iterm = require "modules/iterm/iterm"

hs.window.animationDuration = 0

local hyper = {"ctrl", "alt", "shift"}

hs.hotkey.bind(hyper, "-", flux.decreaseLevel)
hs.hotkey.bind(hyper, "=", flux.increaseLevel)

hs.hotkey.bind(hyper, "return", layouts.maximize)
hs.hotkey.bind(hyper, "Left", layouts.toLeft)
hs.hotkey.bind(hyper, "Right", layouts.toRight)
hs.hotkey.bind(hyper, "Up", layouts.toTop)
hs.hotkey.bind(hyper, "Down", layouts.toBottom)
hs.hotkey.bind(hyper, "/", layouts.nextScreen)

hs.hotkey.bind(hyper, "S", function() layouts.focus(layouts.apps.spotify) end)
hs.hotkey.bind(hyper, "I", function() layouts.focus(layouts.apps.intelliJ) end)
hs.hotkey.bind(hyper, "T", function() layouts.focus(layouts.apps.iTerm) end)
hs.hotkey.bind(hyper, "M", function() layouts.focus(layouts.apps.mail) end)
hs.hotkey.bind(hyper, "A", function() layouts.focus(layouts.apps.things) end)
hs.hotkey.bind(hyper, "N", function() layouts.focus(layouts.apps.sublime) end)
hs.hotkey.bind(hyper, "C", function() layouts.focus(layouts.apps.chrome) end)
hs.hotkey.bind(hyper, "L", function() layouts.focus(layouts.apps.slack) end)
hs.hotkey.bind(hyper, "D", function() layouts.focus(layouts.apps.code) end)

hs.hotkey.bind(hyper, "k", layouts.devLayout)
hs.hotkey.bind(hyper, "j", layouts.emailLayout)
