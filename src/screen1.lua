module(..., package.seeall)

--====================================================================--
-- SCENE: SCREEN 1
--====================================================================--
local _W = display.contentWidth
local _H  = display.contentHeight


new = function ( params )
    
    local clean
    
    ------------------
    -- Groups
    ------------------
    
    local localGroup = display.newGroup()
    
    ------------------
    -- Display Objects
    ------------------
    
    
    local background = display.newImageRect( backgrounds ,1 , 480, 360 )
    
    
    
    
    --====================================================================--
    -- BUTTONS
    --====================================================================--
    
    ------------------
    -- Functions
    ------------------
    
    local bt01 = display.newImageRect( all,66,130,43 )
    
    local function bt01t( event )
        if event.phase == "began" then
            clean()
            director:changeScene( "screen2", "moveFromLeft" )
        end
        return true
    end
    bt01:addEventListener( "touch", bt01t )
    
    --
    
    ------------------
    -- UI Objects
    ------------------
    --
    clean = function ()
        if background then
            display.remove(background)
            background = nil
        end
        
        if bt01 then
            bt01:removeEventListener( "touch", bt01t )
            display.remove(bt01)
            bt01 = nil
            bt01t = nil
        end
    end
    
    --====================================================================--
    -- INITIALIZE
    --====================================================================--
    
    local initVars = function ()
        
        ------------------
        -- Inserts
        ------------------
        
        localGroup:insert( background )
        localGroup:insert( bt01 )
        
        
        ------------------
        -- Positions
        ------------------
        bt01.x = _W/2
        bt01.y = _H/2 + 50
        --
        background.x = _W/2
        background.y = _H/2
        
    end
    
    ------------------
    -- Initiate variables
    ------------------
    
    initVars()
    
    ------------------
    -- MUST return a display.newGroup()
    ------------------
    widget,background = nil,nil
    return localGroup
    
    end
