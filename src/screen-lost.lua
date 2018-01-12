

module(..., package.seeall)

--====================================================================--
-- POP UP: SCREEN 3
--====================================================================--

--[[

 - Version: 1.3
 - Made by Ricardo Rauber Pereira @ 2010
 - Blog: http://rauberlabs.blogspot.com/
 - Mail: ricardorauber@gmail.com

******************
 - INFORMATION
******************

  - Sample scene.

--]]

new = function (params)
    
    local clean
    ------------------
    -- Imports
    ------------------
    
    local widget = require "widget"
    
    ------------------
    -- Groups
    ------------------
    
    local localGroup = display.newGroup()
    
    ------------------
    -- Display Objects
    ------------------
    local reloadBtnHandler,menuBtnHandler, soundBtnHandler,reloadBtn,menuBtn,clearText,wonImage
    local w, h = display.contentWidth, display.contentHeight
    local background = display.newRoundedRect((w-200)/2, 0, 200,320,5)
    background:setFillColor(0,0,0)
    background.alpha = 0.7
    background:toBack()
    
    ------------------
    -- Stop sound
    ------------------
    audio.stop()
    local soundClip = audio.loadSound("audio/lost.mp3")
    if soundOn then
        local soundChanel = audio.play(soundClip)
    end
    ------------------
    -- Listeners
    ------------------
    reloadBtnHandler = function (event )
        if event.phase == "release" then
            clean()
            director:closePopUp("reload-level")
        end
        return true
    end

    menuBtnHandler = function (event )
        if event.phase == "release" then
            clean()
            director:closePopUp("main-menu")
        end
        return true
    end
    
    clean = function()
        if reloadBtn then
            display:remove( reloadBtn )
            reloadBtn = nil
        end
        if menuBtn then
            display:remove( menuBtn )
            menuBtn = nil
        end
        if clearText then
            display:remove( clearText )
            clearText = nil
        end
        if wonImage then
            display:remove( wonImage )
            wonImage = nil
        end
        if background then
            display:remove( background )
            background = nil
        end
    end
    
    --====================================================================--
    -- INITIALIZE
    --====================================================================--
    
    local function initVars ()
        
        
        
        ------------------
        -- Buttons
        ------------------
        reloadBtn = widget.newButton{
            sheet = all,
            defaultIndex = 196,
            overIndex = 196,
            width = 50,
            height = 47,
            onEvent = reloadBtnHandler,
            id = "CloseButton",
            text = "",
            emboss = false
        }
        
        menuBtn = widget.newButton{
            sheet = all,
            defaultIndex = 197,
            overIndex = 197,
            width = 50,
            height = 47,
            onEvent = menuBtnHandler,
            id = "MenuButton",
            text = "",
            emboss = false
        }
        
        
      
        
        clearText = display.newText("Level Failed ",w/2,10,nil,18) 
        clearText:setTextColor(255,255,255)
        clearText.x = w/2
        clearText:toFront()
        
        
        wonImage = display.newImageRect( backgrounds,8,131,98 )
        wonImage.x = w/2
        wonImage.y = 130
        wonImage:rotate(22*90/7) -- 90 = 22*90/7 radius
        
        --params.bestScore
        
        ------------------
        -- Positions
        ------------------
        
        reloadBtn.x = w/2-30
        reloadBtn.y = 270
        
        menuBtn.x = w/2 + 30
        menuBtn.y = 270
        
        
        
        ------------------
        -- Inserts
        ------------------
        
        localGroup:insert( background )
        localGroup:insert(reloadBtn)
        localGroup:insert(menuBtn)
        localGroup:insert(clearText)
        localGroup:insert(wonImage)
    end
    
    ------------------
    -- Initiate variables
    ------------------
    
    initVars()
    reloadBtnHandler,menuBtnHandler, soundBtnHandler,w, h = nil,nil,nil,nil,nil
    ------------------
    -- MUST return a display.newGroup()
    ------------------
    
    return localGroup
    
end
