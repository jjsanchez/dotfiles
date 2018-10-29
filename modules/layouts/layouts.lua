hs.window.animationDuration = 0

local mash = {"cmd", "ctrl"}
local bigMash = {"cmd", "ctrl", "alt"}
local leftScreen = hs.screen.allScreens()[1]
local rightScreen = hs.screen.allScreens()[2]
local apps = {
	intelliJ = { name = "IntelliJ IDEA",  nameOnDisk = "IntelliJ IDEA CE", screen = leftScreen},
	iTerm    = { name = "iTerm2",         nameOnDisk = "iTerm", screen = rightScreen},
	mail     = { name = "Mail",           nameOnDisk = "Mail", screen = rightScreen},
	calendar = { name = "Calendar",       nameOnDisk = "Calendar", screen = rightScreen},
	spotify  = { name = "Spotify",        nameOnDisk = "Spotify", screen = leftScreen},
	sublime  = { name = "Sublime Text", nameOnDisk = "Sublime Text", screen = leftScreen},
	chrome   = { name = "Google Chrome",  nameOnDisk = "Google Chrome", screen = rightScreen},
	chime     = { name = "Amazon Chime", nameOnDisk = "Amazon Chime", screen = leftScreena},
}

local function focus(app)
	-- The name of the app to launcOrFocus should match the name of the application on disk
	-- see: http://www.hammerspoon.org/docs/hs.application.html#launchOrFocus
	hs.application.launchOrFocus(app.nameOnDisk)
end

local function applyLayout(layout, appsToFocus, message)
	hs.layout.apply(layout)
	for _, app in pairs(appsToFocus) do focus(app) end
	hs.alert.show(message)
end

local function applyToFocusedWindow(callback)
	local app = hs.application.frontmostApplication()
	if app ~= nil then
		local win = app:focusedWindow();
		if win ~= nil then
			callback(win)
		end
	end
end

--[[---------------------------
	Arrange all windows 
--]]---------------------------
local function arrangeAllWindows()
	local layout = {
		{apps.spotify.name,  nil, apps.spotify.screen, hs.layout.maximized,  nil, nil},
        {apps.sublime.name,  nil, apps.sublime.screen, hs.layout.maximized,  nil, nil},
        {apps.iTerm.name,    nil, apps.iTerm.screen, hs.layout.maximized,  nil, nil},
        {apps.chime.name,     nil, apps.chime.screen, hs.layout.maximized,  nil, nil},
        {apps.intelliJ.name, nil, apps.intelliJ.screen, hs.layout.maximized, nil, nil},
        {apps.mail.name,     nil, apps.mail.screen, hs.layout.left50, nil, nil},
        {apps.calendar.name, nil, apps.calendar.screen, hs.layout.right50, nil, nil},
        {apps.chrome.name,   nil, apps.chrome.screen, hs.layout.maximized, nil, nil},
    }
    applyLayout(layout, {apps.spotify, apps.mail}, "All windows arranged")
end
hs.urlevent.bind("arrangeAllWindows", arrangeAllWindows)

--[[---------------------------
	Dev layout 
--]]---------------------------
local function devLayout()
	local layout = {
        {apps.intelliJ.name, nil, apps.intelliJscreen, hs.layout.maximized, nil, nil},
        {apps.iTerm.name,    nil, apps.iTerm.screen, hs.layout.maximized,  nil, nil},
    }
    applyLayout(layout, {apps.iTerm, apps.intelliJ}, "Dev layout")
end
hs.hotkey.bind(mash, "9", devLayout)
hs.urlevent.bind("devLayout", devLayout)

--[[---------------------------
	Email layout 
--]]---------------------------
local function emailLayout()
	local layout = {
        {apps.mail.name,   nil, apps.mail.screen, hs.layout.left50,  nil, nil},
        {apps.chrome.name, nil, apps.chrome.screen, hs.layout.right50, nil, nil},
    }
    applyLayout(layout, {apps.chrome, apps.mail}, "Email layout")
end
hs.hotkey.bind(mash, "0", emailLayout)
hs.urlevent.bind("emailLayout", emailLayout)

--[[---------------------------
	Prev screen
--]]---------------------------
hs.hotkey.bind(bigMash, "Left", function()
	applyToFocusedWindow(function(win)
		local nextScreen = win:screen():previous()
  		win:moveToScreen(nextScreen)
	end)
end)

--[[---------------------------
	Next screen
--]]---------------------------
hs.hotkey.bind(bigMash, "Right", function()
	applyToFocusedWindow(function(win)
		local nextScreen = win:screen():next()
  		win:moveToScreen(nextScreen)
	end)
end)

--[[---------------------------
	Full screen 
--]]---------------------------
hs.hotkey.bind({"cmd", "alt"}, "F", function()
	applyToFocusedWindow(function(win)
		win:maximize()
	end)
end)

--[[---------------------------
	To the left
--]]---------------------------
hs.hotkey.bind(mash, "Left", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.x = max.x
  		f.y = max.y
  		f.w = max.w / 2
  		f.h = max.h
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	To the right
--]]---------------------------
hs.hotkey.bind(mash, "Right", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.w = max.w / 2
  		f.h = max.h
  		f.x = max.x + f.w
  		f.y = max.y
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	To the Top
--]]---------------------------
hs.hotkey.bind(mash, "Up", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.w = max.w
  		f.h = max.h / 2
  		f.x = max.x
  		f.y = max.y
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	To the Bottom
--]]---------------------------
hs.hotkey.bind(mash, "Down", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.w = max.w
  		f.h = max.h / 2
  		f.x = max.x
  		f.y = max.y + f.h
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	BigScreen: Left
--]]---------------------------
hs.hotkey.bind(mash, ",", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.x = max.x
  		f.y = max.y
  		f.w = 3 * (max.w / 12)
  		f.h = max.h
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	BigScreen: Right
--]]---------------------------
hs.hotkey.bind(mash, "/", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.w = 3 * (max.w / 12)
  		f.h = max.h
  		f.x = max.x + (9 * (max.w / 12))
  		f.y = max.y
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	BigScreen: Center
--]]---------------------------
hs.hotkey.bind(mash, ".", function()
	applyToFocusedWindow(function(win)
		local f = win:frame()
  		local screen = win:screen()
  		local max = screen:frame()

  		f.w = 6 * (max.w / 12)
  		f.h = max.h
  		f.x = max.x + (3 * (max.w / 12))
  		f.y = max.y
  		win:setFrame(f)
	end)
end)

--[[---------------------------
	Focus Apps
--]]---------------------------
hs.hotkey.bind(mash, "S", function() focus(apps.spotify) end)
hs.hotkey.bind(mash, "I", function() focus(apps.intelliJ) end)
hs.hotkey.bind(mash, "T", function() focus(apps.iTerm) end)
hs.hotkey.bind(mash, "M", function() focus(apps.mail) end)
hs.hotkey.bind(mash, "A", function() focus(apps.calendar) end)
hs.hotkey.bind(mash, "N", function() focus(apps.sublime) end)
hs.hotkey.bind(mash, "C", function() focus(apps.chrome) end)
hs.hotkey.bind(mash, "L", function() focus(apps.chime) end)


hs.hotkey.bind(mash, "J", function() 
	hs.window.highlight.start()
	--hs.window.highlight.toggleIsolate(true) 
	hs.alert.show("toggle")
end)

