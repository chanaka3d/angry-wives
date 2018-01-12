

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
    require ("ice")
    
    ------------------
    -- Groups
    ------------------
    
    local localGroup = display.newGroup()
    
    ------------------
    -- ICE
    ------------------
    local scores = ice:loadBox( "scores" )
    ------------------
    -- Display Objects
    ------------------
    local helpImageA
    local w, h = display.contentWidth, display.contentHeight
    local background = display.newRoundedRect(0, 0, 480,320,5)
    background:setFillColor(0,0,0)
    background.alpha = 0.7
    background:toBack()
    
    
    ------------------
    -- Listeners
    ------------------
   
    
    nextBtnHandler = function (event )
        if event.phase == "release" then
            clean()
            director:closePopUp("next-level")
        end
        return true
    end
    
    local touched = function ( event )
            if event.phase == "ended" then
                    director:closePopUp("next-level")
            end
    end
    
    clean = function()
        if helpImageA then
            display:remove( helpImageA )
            helpImageA = nil
        end
        if background then
            display:remove( background )
            background = nil
        end
        if touched then
            background:removeEventListener( "touch" , touched )
        end
    end
    --====================================================================--
    -- INITIALIZE
    --====================================================================--
    
    local function initVars ()
        local imageNum = 57
        if params.level == 11 then
            imageNum = 58
        elseif params.level == 17 then
            imageNum = 59
        end
        helpImageA = display.newImageRect(all,imageNum,300,130)
        helpImageA.x = w/2
        helpImageA.y = h/2
        
        background:addEventListener( "touch" , touched )
        ------------------
        -- Inserts
        ------------------
        
        localGroup:insert( background )
        localGroup:insert( helpImageA )
        imageNum = nil
    end
    
    ------------------
    -- Initiate variables
    ------------------
    
    initVars()
    w, h = nil,nil
    ------------------
    -- MUST return a display.newGroup()
    ------------------
    
    return localGroup
    
end
