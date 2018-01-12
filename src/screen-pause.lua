

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
        ------------------
        -- Imports
        ------------------
        local clean
        local widget = require "widget"
	
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
        -- Display Objects
        ------------------
        local reloadBtnHandler,menuBtnHandler, soundBtnHandler,closeBtnHandler,fbBtnHandler, soundBtn1, soundBtn2
        local w, h = display.contentWidth, display.contentHeight,reloadBtn,menuBtn,closeBtn,fbBtn
        local background = display.newRoundedRect((w-200)/2, 0, 200,320,5)
        background:setFillColor(0,0,0)
        background.alpha = 0.7
	
	
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

        soundBtnHandler = function (event )
            if event.phase == "release" then
                local saveData = ""
                if soundOn then
                    saveData = "false"
                    soundOn = false
                    audio.pause()
                    
                    soundBtn1.isVisible = false
                    soundBtn2.isVisible = true
                else
                    saveData = "true"
                    soundOn = true
                    audio.resume()
                    
                    soundBtn1.isVisible = true
                    soundBtn2.isVisible = false
                end
                local path = system.pathForFile( "angryBabes.txt", system.DocumentsDirectory )
                local file = io.open( path, "w" )
                file:write( saveData )
                io.close( file )
            end
            return true
        end
        
        closeBtnHandler = function (event )
            if event.phase == "release" then
                clean()
                director:closePopUp("resume-level")
            end
            return true
        end
        
        fbBtnHandler = function (event )
            if event.phase == "release" then
                if(not system.openURL("fb://page/494166797318902")) then
                    system.openURL("http://www.facebook.com/angrywivesgame")
                end
            end
            return true
        end
        
        
        clean = function() 
            if background then
                display:remove( background )
                background = nil
            end
            if reloadBtn then
                display:remove( reloadBtn )
                reloadBtn = nil
            end
            if menuBtn then
                display:remove( menuBtn )
                menuBtn = nil
            end
            if soundBtn1 then
                display:remove( soundBtn1 )
                soundBtn1 = nil
            end
            if soundBtn2 then
                display:remove( soundBtn2 )
                soundBtn2 = nil
            end
            if closeBtn then
                display:remove( closeBtn )
                closeBtn = nil
            end
            if fbBtn then
                display:remove( fbBtn )
                fbBtn = nil
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
                        width = 70,
                        height = 67,
                        onEvent = reloadBtnHandler,
                        id = "CloseButton",
                        text = "",
                        emboss = false
                }

                menuBtn = widget.newButton{
                        sheet = all,
                        defaultIndex = 197,
                        overIndex = 197,
                        width = 70,
                        height = 67,
                        onEvent = menuBtnHandler,
                        id = "MenuButton",
                        text = "",
                        emboss = false
                }


                soundBtn1 = widget.newButton{
                        sheet = all,
                        defaultIndex = 198,
                        overIndex = 198,
                        width = 70,
                        height = 67,
                        onEvent = soundBtnHandler,
                        id = "SoundButton",
                        text = "",
                        emboss = false
                }

                soundBtn2 = widget.newButton{
                        sheet = all,
                        defaultIndex = 199,
                        overIndex = 199,
                        width = 70,
                        height = 67,
                        onEvent = soundBtnHandler,
                        id = "SoundButton",
                        text = "",
                        emboss = false
                }

                closeBtn = widget.newButton{
                        sheet = all,
                        defaultIndex = 40,
                        overIndex = 40,
                        width = 33,
                        height = 33,
                        onEvent = closeBtnHandler,
                        id = "SoundButton",
                        text = "",
                        emboss = false
                }
                fbBtn = widget.newButton{
                        sheet = backgrounds,
                        defaultIndex = 22,
                        overIndex = 22,
                        width = 33,
                        height = 33,
                        onEvent = fbBtnHandler,
                        id = "fbButton",
                        text = "",
                        emboss = false
                }
		------------------
                -- Positions
                ------------------

                reloadBtn.x = w/2
                reloadBtn.y = 50

                menuBtn.x = w/2
                menuBtn.y = 120

                soundBtn1.x = w/2
                soundBtn1.y = 200
                
                soundBtn2.x = w/2
                soundBtn2.y = 200
                
                closeBtn.x = w/2 + 70
                closeBtn.y = 20
                
                fbBtn.x = w/2
                fbBtn.y = 270
                
                if soundOn then
                    soundBtn1.isVisible = true
                    soundBtn2.isVisible = false
                else
                    soundBtn1.isVisible = false
                    soundBtn2.isVisible = true
                end
                ------------------
		-- Inserts
		------------------
		
		localGroup:insert( background )
		localGroup:insert(reloadBtn)
                localGroup:insert(menuBtn)
                localGroup:insert(soundBtn1)
                localGroup:insert(soundBtn2)
                localGroup:insert(closeBtn)
                localGroup:insert(fbBtn)
		
	end
	
	------------------
	-- Initiate variables
	------------------
	
	initVars()
	
        
        reloadBtnHandler,menuBtnHandler, soundBtnHandler,closeBtnHandler,fbBtnHandler,w, h,widget = nil,nil,nil,nil,nil,nil,nil,nil
	------------------
	-- MUST return a display.newGroup()
	------------------
	
	return localGroup
	
end
