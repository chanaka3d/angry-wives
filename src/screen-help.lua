

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
    local helpImageA, helpImageB
    local w, h = display.contentWidth, display.contentHeight
    local background = display.newRoundedRect(0, 0, 480,320,5)
    background:setFillColor(0,0,0)
    background.alpha = 0.7
    background:toBack()
    
    
    ------------------
    -- Listeners
    ------------------
    
    local touched = function ( event )
        if event.phase == "ended" then
            if helpImageA.isVisible then
                helpImageA.isVisible = false
                helpImageB.isVisible = true
            else
                clean()
                director:closePopUp("next-level")
            end
        end
    end
    --====================================================================--
    -- INITIALIZE
    --====================================================================--
    clean = function()
        if helpImageA then
            display.remove(helpImageA)
            helpImageA = nil
        end
        if helpImageB then
            display.remove( helpImageB )
            helpImageB = nil
        end
        if background then
            background:removeEventListener( "touch" , touched )
            display.remove( background )
            background = nil
        end
    end
    local function initVars ()
        
        helpImageA = display.newImageRect(backgrounds,5,429,131)
        helpImageA.x = w/2
        helpImageA.y = h/2
        
        helpImageB = display.newImageRect(backgrounds,21,159,335)
        helpImageB.x = w/2
        helpImageB.y = h/2
        helpImageB.rotation = 270
        helpImageB.isVisible = false
        
        background:addEventListener( "touch" , touched )
        ------------------
        -- Inserts
        ------------------
        
        localGroup:insert( background )
        localGroup:insert( helpImageA )
        localGroup:insert( helpImageB )
    end
    
    ------------------
    -- Initiate variables
    ------------------
    
    initVars()
    
    ------------------
    -- MUST return a display.newGroup()
    ------------------
    w, h = nil, nil
    return localGroup
    
    end
