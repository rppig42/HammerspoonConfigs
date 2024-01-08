-- With Bluesnooze the Bluetooth connection is switched off when your Mac sleeps, and switched on when your Mac wakes.
-- *********************
-- Need to install blueutil first:
-- brew install blueutil
-- *********************

local useBlueSnooze = false

function watcherHandler(eventType)
    useBlueSnooze = hs.settings.get('useBlueSnooze') or false
    if (eventType == hs.caffeinate.watcher.systemWillSleep) then
        if useBlueSnooze then
            bluetoothSwitch('0')
        end
    elseif (eventType == hs.caffeinate.watcher.systemDidWake or eventType == hs.caffeinate.watcher.screensDidWake) then
        -- there's a delay for systemDidWake, so use screensDidWake alternatively
        if useBlueSnooze then
            bluetoothSwitch('1')
        end
    end
end

function bluetoothSwitch(state)
    -- state: 0 for off, 1 for on
    cmd = "/opt/homebrew/bin/blueutil --power " .. (state)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end

caffeinateWatcher = hs.caffeinate.watcher.new(watcherHandler)
caffeinateWatcher:start()

print("blueSnooze working")
