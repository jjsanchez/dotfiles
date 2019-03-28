local iterm = {}

function iterm.newSession() 
    hs.application.launchOrFocus("iTerm")
    local iterm = hs.appfinder.appFromName("iTerm2")
    iterm:selectMenuItem({"Shell", "Close Terminal Window"})
    local script = [[
        tell application "iTerm"
	        create window with default profile
	        tell the current window
		        tell the current session
			        set name to "App"
			        write text "cd ~/Development/"
			        write text "ll"
			
			        set othertab to split vertically with default profile
	        		tell othertab
	        			write text "cd ~/Development/UI"
	        			write text "ll"
                    end tell
                end tell
	    	
		        set remote to create tab with profile "Default"
                
		        tell remote
		        	tell the current session
		        		set name to "Remote"
		        		write text "dt"
		        	end tell
		        end tell
            end tell
        end tell
    ]]
    hs.osascript.applescript(script)
end

return iterm