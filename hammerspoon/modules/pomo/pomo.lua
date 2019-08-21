local INTERVAL_SECONDS = 1
local POMO_LENGTH = 25 * 60
local BREAK_LENGTH = 5 * 60

local menu = hs.menubar.new()
local timer = nil
local currentPomo = nil
local numPomodoros = 0

local function completePomo(pomo)
    local n = hs.notify.new({
        title='Pomodoro complete',
        informativeText='Completed at ' .. os.date('%H:%M'),
        soundName='Hero'
    })
    n:autoWithdraw(false)
    n:hasActionButton(false)
    n:send()

    currentPomo = nil
    numPomodoros = numPomodoros + 1

    if timer then timer:stop() end
    timer = hs.timer.doAfter(INTERVAL_SECONDS * BREAK_LENGTH, function()
        local n = hs.notify.new({
            title='Get back to work',
            subTitle='Break time is over',
            informativeText='Sent at ' .. os.date('%H:%M'),
            soundName='Hero'
        })
        n:autoWithdraw(false)
        n:hasActionButton(false)
        n:send()
    end)
end

local function getMenubarTitle(pomo)
    local title = '🍅'
    if pomo then
    	local minutes = pomo.secondsLeft // 60
    	local seconds = pomo.secondsLeft % 60
        title = title .. (string.format('%02d:%02d', minutes, seconds))
        if pomo.paused then
            title = title .. ' - ⏸'
        end
    end
    return title
end

local function updateUI()
    menu:setTitle(getMenubarTitle(currentPomo))
end

local function timerCallback()
    if not currentPomo then return end
    if currentPomo.paused then return end
    currentPomo.secondsLeft = currentPomo.secondsLeft - 1
    if (currentPomo.secondsLeft <= 0) then completePomo(currentPomo) end
    updateUI()
end

local function startNew()
    if (not currentPomo or currentPomo.secondsLeft <= 0) then
        currentPomo = {secondsLeft=POMO_LENGTH}
    else 
        currentPomo.paused = false
    end

    if timer then timer:stop() end
    timer = hs.timer.doEvery(INTERVAL_SECONDS, timerCallback)
    updateUI()
end

local function togglePaused()
    if not currentPomo then return end
    currentPomo.paused = not currentPomo.paused
    updateUI()
end

local function stop()
    if not currentPomo then return end
    if timer then timer:stop() end
    currentPomo = nil
    updateUI()
end

local function reset()
    stop()
    numPomodoros = 0
    updateUI()
end

function pomo()
	menu:setMenu(function()
        return {
          { title=string.format('%d pomodors today', numPomodoros) },
          { title='▶️ - Start', fn=startNew },
          { title='⏹ - Stop', fn=stop },
          { title='⏸ - Pause', fn=togglePaused },
          { title='🚫 - Reset', fn=reset }
        }
    end)

    updateUI()
end

hs.urlevent.bind('startPomo', startNew)
hs.urlevent.bind('pausePomo', togglePaused)
hs.urlevent.bind('stopPomo', stop)