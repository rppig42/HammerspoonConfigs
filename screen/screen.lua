-- 一键切换Mac主屏幕，并将所有的窗口移到主屏幕上去
local menubar = hs.menubar.new()
local selectedMenuName = ''
local menuData = {}

function renderMenus()
    menuData = {}
    local allScreens = hs.screen.allScreens()
    for i, v in ipairs(allScreens) do
        table.insert(menuData, {
            title = v:name(),
            checked = v:name() == selectedMenuName,
            fn = function()
                selectedMenuName = v:name()
                renderMenus()
                v:setPrimary()
                -- 如果不需要移动窗口，可以注释moveWindows函数
                moveWindows()
            end
        })
    end

    table.insert(menuData, {
        title = '🌘',
        fn = function()
            for i, v in ipairs(allScreens) do
                if v:name() == 'Color LCD' then
                    v:setBrightness(math.ceil(1 - v:getBrightness()))
                end
            end
        end
    })

    menubar:setTitle('🖥')
    menubar:setTooltip('Set as primary screen')
    menubar:setMenu(menuData)
end

function moveWindows()
    local allWindows = hs.window.visibleWindows()
    local primaryScreen = hs.screen.primaryScreen()

    for i, window in ipairs(allWindows) do window:moveToScreen(primaryScreen) end

end

local screenwatcher = hs.screen.watcher.new(renderMenus)
screenwatcher:start()

renderMenus()

