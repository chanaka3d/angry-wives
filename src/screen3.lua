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

new = function ()
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	
	
	------------------
	-- Listeners
	------------------
	
	
        ------------------
	-- Functions
	------------------
	
	local bt01t = function ( event )
		if event.phase == "began" then
                        clean()
			director:changeScene( "screen1", "moveFromLeft" )
                    end
                    return true
	end
	--
	
	------------------
	-- UI Objects
	------------------
        local bt01 = display.newText( "go back" , 100, 100, native.systemFont, 12)
        bt01:setTextColor ( 255,255,255 )
        
        bt01:addEventListener( 'touch', bt01t )
    
	--
	clean = function ()
           

            if bt01 then
                bt01._functionListeners = nil
                bt01._tableListeners = nil
                display.remove(bt01)
                bt01 = nil
            end
        end
	
	--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local function initVars ()
		
		------------------
		-- Inserts
		------------------
		
		localGroup:insert( bt01 )
		
		------------------
		-- Positions
		------------------
		bt01.x = display.contentWidth/2
		bt01.y = display.contentHeight/2 + 50
		
		------------------
		-- Listeners
		------------------
		
		
	end
	
	------------------
	-- Initiate variables
	------------------
	
	initVars()
	
	------------------
	-- MUST return a display.newGroup()
	------------------
	
	return localGroup
	
end
