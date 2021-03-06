-- 系统待机时注销Mac微信，这样手机微信可以收到提醒
-- 正常来说，直接杀掉微信进程即可，但貌似因为我装了微信访撤回插件的原因，直接杀掉进程并不会让Mac微信下线

script = [[
    tell application "WeChat" to activate

    tell application "System Events"
        tell process "WeChat"
            key code 43 using {command down}
        end tell
    end tell

    tell application "System Events"
        tell process "WeChat"
            tell window "General"
                click button "Log Out" of window "General" of application process "WeChat" of application "System Events"
            end tell
        end tell
    end tell

    delay 1

    tell application "System Events"
        tell process "WeChat"
            tell window "General"
                click button "Log Out" of sheet 1 of window "General" of application process "WeChat" of application "System Events"
            end tell
        end tell
    end tell

]]

function logoutWechat(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidSleep) then
        print("screensDidSleep")
        hs.applescript(script)
    elseif (eventType == hs.caffeinate.watcher.screensDidLock) then
        --锁屏时似乎无法进行屏幕操作
        --print("screensDidLock")
        --hs.applescript(script)
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(logoutWechat)
caffeinateWatcher:start()

