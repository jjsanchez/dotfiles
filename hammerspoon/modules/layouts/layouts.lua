local layouts = {}

layouts.apps = {
	intelliJ = { name = "IntelliJ IDEA",  nameOnDisk = "IntelliJ IDEA"},
	iTerm    = { name = "iTerm2",         nameOnDisk = "iTerm"},
	mail     = { name = "Microsoft Outlook", nameOnDisk = "Microsoft Outlook"},
	calendar = { name = "Calendar",       nameOnDisk = "Calendar"},
	spotify  = { name = "Spotify",        nameOnDisk = "Spotify"},
	sublime  = { name = "Sublime Text", nameOnDisk = "Sublime Text"},
	chrome   = { name = "Google Chrome",  nameOnDisk = "Google Chrome"},
	chime    = { name = "Amazon Chime", nameOnDisk = "Amazon Chime"},
	slack    = { name = "Slack", nameOnDisk = "Slack"},
	things   = { name = "Things3", nameOnDisk = "Things3"},
	code   = { name = "Visual Studio Code", nameOnDisk = "Visual Studio Code"},
	firefox   = { name = "Firefox", nameOnDisk = "Firefox"},
}

local function moveMouseToFocusedWindow()
	local focusedWindow = hs.window.focusedWindow()
	local rect = focusedWindow:frame()
	local center = hs.geometry.rectMidPoint(rect)
	hs.mouse.setAbsolutePosition(center)
end

function layouts.focus(app)
	-- The name of the app to launchOrFocus should match the name of the application on disk
	-- see: http://www.hammerspoon.org/docs/hs.application.html#launchOrFocus
	hs.application.launchOrFocus(app.nameOnDisk)


	-- Move the pointer of the mouse to the center of the focused window.
	-- This is good for setups with multiple screens: When you focus an app on a different monitor,
	-- you don't need to move the mouse all the way there
	moveMouseToFocusedWindow()
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

function layouts.maximize()
	applyToFocusedWindow(function(win)
		win:maximize()
	end)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function layouts.toLeft()
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
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function layouts.toRight()
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
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function layouts.toTop()
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
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function layouts.toBottom()
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
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function layouts.upLeft()
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:fullFrame()
	
		f.x = max.x
		f.y = max.y
		f.w = max.w/2
		f.h = max.h/2
		win:setFrame(f)
	end)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function layouts.downLeft(win)
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:fullFrame()
	
		f.x = max.x
		f.y = max.y + (max.h / 2)
		f.w = max.w/2
		f.h = max.h/2
		win:setFrame(f)
	end)
  end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function layouts.downRight()
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:fullFrame()

		f.x = max.x + (max.w / 2)
		f.y = max.y + (max.h / 2)
		f.w = max.w/2
		f.h = max.h/2

		win:setFrame(f)
	end)
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function layouts.upRight()
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:fullFrame()
	
		f.x = max.x + (max.w / 2)
		f.y = max.y
		f.w = max.w/2
		f.h = max.h/2
		win:setFrame(f)
	end)
end

function layouts.centerWithFullHeight()
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:fullFrame()
	
		f.x = max.x + (max.w / 5)
		f.w = max.w * 3/5
		f.y = max.y
		f.h = max.h
		win:setFrame(f)
	end)
end

-- +-----------------+
-- |      |          |
-- | HERE |          |
-- |      |          |
-- +-----------------+
function layouts.left40()
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:frame()
	
		f.x = max.x
		f.y = max.y
		f.w = max.w * 0.4
		f.h = max.h
		win:setFrame(f)
	end)
end

-- +-----------------+
-- |      |          |
-- |      |   HERE   |
-- |      |          |
-- +-----------------+
function layouts.right60()
	applyToFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:frame()
	
		f.x = max.w * 0.4
		f.y = max.y
		f.w = max.w * 0.6
		f.h = max.h
		win:setFrame(f)
	end)
end

function layouts.nextScreen()
	applyToFocusedWindow(function(win)
		local currentScreen = win:screen()
		local allScreens = hs.screen.allScreens()
		currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
		nextScreenIndex = currentScreenIndex + 1
	
		if allScreens[nextScreenIndex] then
		win:moveToScreen(allScreens[nextScreenIndex])
		else
		win:moveToScreen(allScreens[1])
		end

		-- Move the pointer of the mouse to the center of the focused window.
		-- This is good for setups with multiple screens: When you focus an app on a different monitor,
		-- you don't need to move the mouse all the way there
		moveMouseToFocusedWindow()
	end)
end

local function applyLayout(layout, appsToFocus, message)
	hs.layout.apply(layout)
	for _, app in pairs(appsToFocus) do layouts.focus(app) end
end

function layouts.devLayout()
	local layout = {
        {layouts.apps.intelliJ.name, nil, nil, hs.layout.left50, nil, nil},
        {layouts.apps.iTerm.name,    nil, nil, hs.layout.right50,  nil, nil},
    }
    applyLayout(layout, {layouts.apps.iTerm, layouts.apps.intelliJ}, "Dev layout")
end

function layouts.emailLayout()
	local layout = {
        {layouts.apps.mail.name,   nil, nil, hs.layout.right50,  nil, nil},
        {layouts.apps.chrome.name, nil, nil, hs.layout.left50, nil, nil},
    }
    applyLayout(layout, {layouts.apps.chrome, layouts.apps.mail}, "Email layout")
end

return layouts
