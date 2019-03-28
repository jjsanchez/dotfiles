local layouts = {}

layouts.apps = {
	intelliJ = { name = "IntelliJ IDEA",  nameOnDisk = "IntelliJ IDEA CE"},
	iTerm    = { name = "iTerm2",         nameOnDisk = "iTerm"},
	mail     = { name = "Microsoft Outlook", nameOnDisk = "Microsoft Outlook"},
	calendar = { name = "Calendar",       nameOnDisk = "Calendar"},
	spotify  = { name = "Spotify",        nameOnDisk = "Spotify"},
	sublime  = { name = "Sublime Text", nameOnDisk = "Sublime Text"},
	chrome   = { name = "Google Chrome",  nameOnDisk = "Google Chrome"},
	chime     = { name = "Amazon Chime", nameOnDisk = "Amazon Chime"},
}

function layouts.focus(app)
	-- The name of the app to launcOrFocus should match the name of the application on disk
	-- see: http://www.hammerspoon.org/docs/hs.application.html#launchOrFocus
	hs.application.launchOrFocus(app.nameOnDisk)
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