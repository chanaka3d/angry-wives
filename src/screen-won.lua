

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
    local reloadBtnHandler,menuBtnHandler, soundBtnHandler
    local w, h = display.contentWidth, display.contentHeight
    local background = display.newRoundedRect((w-200)/2, 0, 200,320,5)
    background:setFillColor(0,0,0)
    background.alpha = 0.7
    background:toBack()
    ------------------
    -- Stop sound
    ------------------
    audio.stop()
    local soundClip = audio.loadSound("audio/won.mp3")
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
    
    nextBtnHandler = function (event )
        if event.phase == "release" then
            clean()
            director:closePopUp("next-level")
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
        if nextBtn then
            display:remove( nextBtn )
            nextBtn = nil
        end
        if clearText then
            display:remove( clearText )
            clearText = nil
        end
        if wonImage then
            display:remove( wonImage )
            wonImage = nil
        end
        if bestScoreText then
            display:remove( bestScoreText )
            bestScoreText = nil
        end
        if scoreForRemainingBabes then
            display:remove( scoreForRemainingBabes )
            scoreForRemainingBabes = nil
        end
        if currentScoreText then
            display:remove( currentScoreText )
            currentScoreText = nil
        end
        if bonesText then
            display:remove( bonesText )
            bonesText = nil
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
        
        
        nextBtn = widget.newButton{
        sheet = all,
        defaultIndex = 194,
        overIndex = 194,
        width = 50,
        height = 47,
        onEvent = nextBtnHandler,
        id = "SoundButton",
        text = "",
        emboss = false
        }
        
        clearText = display.newText("Level Cleared !! ",w/2,10,nil,18) 
        clearText:setTextColor(255,255,255)
        clearText.x = w/2
        clearText:toFront()
        
        
        wonImage = display.newImageRect(backgrounds,7,137,138)
        wonImage.x = w/2
        wonImage.y = 100
        wonImage:rotate(22*90/7) -- 90 = 22*90/7 radius
        
        --params.bestScore
        --[[
        
        
        
        if bestscre is less than score or   bestsocre is 0 
        best score = score
        so show new best score
        if bestscore is gr8 than score
        show old best score
        show score
        
        
        ]]--
        
        
        
        bestScoreText = nil
        if params.bestScore ~= 0 then
            bestScoreText = display.newText("Best: " .. params.bestScore,w/2,170,nil,18) 
            bestScoreText:setTextColor(255,255,255)
            bestScoreText.x = w/2
            bestScoreText:toFront()
        end
        
        scoreForRemainingBabes = params.scoreForRemainingBabes
        
        bonesText = display.newText("Bonus Points: "  .. scoreForRemainingBabes ,w/2,200,nil,18) 
        params.score = params.score + scoreForRemainingBabes
        bonesText.x = w/2
        bonesText:toFront()
        
        if(params.bestScore < params.score or params.bestScore == 0) then
            currentScoreText = display.newText("New Best: " .. params.score,w/2,230,nil,20)
            currentScoreText:setTextColor(0,142,14)
            
            scores:store( "level"..params.level, params.score)
            scores:save()
        else
            currentScoreText = display.newText("New Score: " .. params.score,w/2,230,nil,20) 
            currentScoreText:setTextColor(255,255,255)
        end
        currentScoreText.x = w/2
        currentScoreText:toFront()
        
        
        
        ------------------
        -- Positions
        ------------------
        
        reloadBtn.x = w/2-50
        reloadBtn.y = 290
        
        menuBtn.x = w/2
        menuBtn.y = 290
        
        nextBtn.x = w/2 + 50
        nextBtn.y = 290
        
        
        ------------------
        -- Inserts
        ------------------
        
        localGroup:insert( background )
        localGroup:insert(reloadBtn)
        localGroup:insert(menuBtn)
        localGroup:insert(nextBtn)
        localGroup:insert(clearText)
        localGroup:insert(wonImage)
        if bestScoreText ~= nil then
            localGroup:insert(bestScoreText)
        end
        localGroup:insert(currentScoreText)
    end
    
    ------------------
    -- Initiate variables
    ------------------
    
    initVars()
    widget,reloadBtnHandler,menuBtnHandler, soundBtnHandler = nil,nil,nil,nil
    ------------------
    -- MUST return a display.newGroup()
    ------------------
    
    return localGroup
    
    end
