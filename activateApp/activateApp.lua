function hideOrActivate(name)
    app = hs.application.get(name)
    if app and app:isHidden() then
        app:activate()
    else
        app:hide()
    end
end

hs.hotkey.bind('alt', '1',  function()
    hideOrActivate('Google Chrome')
end)

hs.hotkey.bind('alt', '2',  function()
    hideOrActivate('Warp')
end)
