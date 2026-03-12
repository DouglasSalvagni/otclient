GameHelperWindow = nil
GameHelperButton = nil
local tabButtons = {}
local tabPanels = {}

local function setupWindow()
    if not GameHelperWindow or GameHelperWindow:isDestroyed() then
        return
    end
    tabButtons.one = GameHelperWindow:getChildById('tabOneButton')
    tabButtons.two = GameHelperWindow:getChildById('tabTwoButton')
    tabPanels.one = GameHelperWindow:getChildById('tabOneContent')
    tabPanels.two = GameHelperWindow:getChildById('tabTwoContent')
    if tabButtons.one then
        tabButtons.one.onClick = function() selectTab('one') end
    end
    if tabButtons.two then
        tabButtons.two.onClick = function() selectTab('two') end
    end
end

function init()
    GameHelperButton = modules.game_mainpanel.addToggleButton('gameHelperButton', tr('Game Helper'),
        '/images/options/button_empty', toggle)
    if GameHelperButton then
        GameHelperButton:setOn(false)
    end
    GameHelperWindow = g_ui.displayUI('game_helper')
    if GameHelperWindow then
        GameHelperWindow:hide()
        setupWindow()
        selectTab('one')
    end
    connect(g_game, {
        onGameEnd = onGameEnd
    })
end

function terminate()
    disconnect(g_game, {
        onGameEnd = onGameEnd
    })
    if GameHelperWindow and not GameHelperWindow:isDestroyed() then
        GameHelperWindow:destroy()
        GameHelperWindow = nil
    end
    if GameHelperButton then
        GameHelperButton:destroy()
        GameHelperButton = nil
    end
end

function onGameEnd()
    hide()
end

function toggle()
    if not GameHelperWindow or GameHelperWindow:isDestroyed() then
        show()
        return
    end
    if GameHelperWindow:isVisible() then
        hide()
    else
        show()
    end
end

function show()
    if not GameHelperWindow or GameHelperWindow:isDestroyed() then
        GameHelperWindow = g_ui.displayUI('game_helper')
        setupWindow()
    end
    selectTab('one')
    GameHelperWindow:show()
    GameHelperWindow:raise()
    GameHelperWindow:focus()
    if GameHelperButton then
        GameHelperButton:setOn(true)
    end
end

function hide()
    if not GameHelperWindow or GameHelperWindow:isDestroyed() then
        if GameHelperButton then
            GameHelperButton:setOn(false)
        end
        return
    end
    GameHelperWindow:hide()
    if GameHelperButton then
        GameHelperButton:setOn(false)
    end
end

function selectTab(name)
    if not tabPanels.one or not tabPanels.two or not tabButtons.one or not tabButtons.two then
        return
    end
    local isOne = name == 'one'
    tabPanels.one:setVisible(isOne)
    tabPanels.two:setVisible(not isOne)
    tabButtons.one:setOn(isOne)
    tabButtons.two:setOn(not isOne)
end
