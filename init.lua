hs.window.animationDuration = 0

local screen = hs.screen.allScreens()[1]:name()
local mash = {"cmd", "ctrl"}
local apps = {
	intelliJ = { name = "IntelliJ IDEA",  nameOnDisk = "IntelliJ IDEA 15 CE"},
	iTerm    = { name = "iTerm2",         nameOnDisk = "iTerm"},
	mail     = { name = "Mail",           nameOnDisk = "Mail"},
	calendar = { name = "Calendar",       nameOnDisk = "Calendar"},
	spotify  = { name = "Spotify",        nameOnDisk = "Spotify"},
	sublime  = { name = "Sublime Text 2", nameOnDisk = "Sublime Text 2"},
	chrome   = { name = "Google Chrome",  nameOnDisk = "Google Chrome"},
	lync     = { name = "Microsoft Lync", nameOnDisk = "Microsoft Lync"},
}

function focus(app)
	-- The name of the app to launcOrFocus should match the name of the application on disk
	-- see: http://www.hammerspoon.org/docs/hs.application.html#launchOrFocus
	hs.application.launchOrFocus(app.nameOnDisk)
end

function applyLayout(layout, appsToFocus, message)
	hs.layout.apply(layout)
	for _, app in pairs(appsToFocus) do focus(app) end
	hs.alert.show(message)
end

function applyToFocusedWindow(callback)
	local app = hs.application.frontmostApplication()
	if app ~= nil then
		local win = app:focusedWindow();
		if win ~= nil then
			callback(win)
		end
	end
end

function arrangeAllWindows()
	local layout = {
		{apps.spotify.name,  nil, screen, hs.layout.left30,  nil, nil},
        {apps.sublime.name,  nil, screen, hs.layout.left30,  nil, nil},
        {apps.iTerm.name,    nil, screen, hs.layout.left30,  nil, nil},
        {apps.lync.name,     nil, screen, hs.layout.left30,  nil, nil},
        {apps.intelliJ.name, nil, screen, hs.layout.right70, nil, nil},
        {apps.mail.name,     nil, screen, hs.layout.right70, nil, nil},
        {apps.calendar.name, nil, screen, hs.layout.right70, nil, nil},
        {apps.chrome.name,   nil, screen, hs.layout.right70, nil, nil},
    }
    applyLayout(layout, {apps.spotify, apps.mail}, "All windows arranged")
end

function devLayout()
	local layout = {
        {apps.intelliJ.name, nil, screen, hs.layout.right70, nil, nil},
        {apps.iTerm.name,    nil, screen, hs.layout.left30,  nil, nil},
    }
    applyLayout(layout, {apps.iTerm, apps.intelliJ}, "Dev layout")
end

--[[---------------------------
	Arrange all windows 
--]]---------------------------
hs.hotkey.bind(mash, "0", arrangeAllWindows)
hs.urlevent.bind("arrangeAllWindows", arrangeAllWindows)

--[[---------------------------
	Dev layout 
--]]---------------------------
hs.hotkey.bind(mash, "9", devLayout)
hs.urlevent.bind("devLayout", devLayout)

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
	Focus Apps
--]]---------------------------
hs.hotkey.bind(mash, "S", function() focus(apps.spotify) end)
hs.hotkey.bind(mash, "I", function() focus(apps.intelliJ) end)
hs.hotkey.bind(mash, "T", function() focus(apps.iTerm) end)
hs.hotkey.bind(mash, "M", function() focus(apps.mail) end)
hs.hotkey.bind(mash, "A", function() focus(apps.calendar) end)
hs.hotkey.bind(mash, "N", function() focus(apps.sublime) end)
hs.hotkey.bind(mash, "C", function() focus(apps.chrome) end)
hs.hotkey.bind(mash, "L", function() focus(apps.lync) end)


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