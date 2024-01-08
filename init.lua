require "HammerspoonConfigs.blueSnooze.blueSnooze";

local menubar = hs.menubar.new()
local selectedMenuName = ''
local menuData = {}
local useBlueSnooze = false

function renderMenus()
    menuData = {}
    useBlueSnooze = hs.settings.get('useBlueSnooze') or false

    table.insert(menuData, {
        title = 'enable blueSnooze',
        checked = useBlueSnooze,
        fn = function()
            useBlueSnooze = not useBlueSnooze
            hs.settings.set('useBlueSnooze', useBlueSnooze)
            renderMenus()
        end
    })

    menubar:setTitle('🖥')
    menubar:setTooltip('Hammer Spoon Configs')
    menubar:setMenu(menuData)
end

renderMenus()
