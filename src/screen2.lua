module(..., package.seeall)

--====================================================================--
-- SCENE: SCREEN 2
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


new = function ( params )
    
    ------------------
    -- Imports
    ------------------
    local clean
    require( "ice" )
    
    -------------------
    -- Find about sound
    -------------------
    local path = system.pathForFile( "angryBabes.txt", system.DocumentsDirectory )
    local file = io.open( path, "r" )
    
    if file ~= nil then
        local saveData = file:read( "*a" )
        io.close( file )
        
        if saveData == "true" then 
            soundOn = true
        else
            soundOn = false
        end
        saveData = nil
    else
        soundOn = true
    end
    ------------------
    -- Groups
    ------------------
    
    local localGroup = display.newGroup()
    local levelBtnsLeft = display.newGroup();
    local levelBtnsRight = display.newGroup();
    local moreLevelsBtn = display.newImageRect( all,201,50,50 )
    local levelSlide
    local scores = ice:loadBox( "scores" )
    --scores:clear()
    
    ------------------
    -- Swap action detection
    ------------------
    local beginX 
    local beginY  
    local endX  
    local endY 
    
    local xDistance  
    local yDistance  
    
    local function checkSwipeDirection()
        if ( endX == nil or beginX == nil or endY == nil or bginY == nil) then
            return
        end
        xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value. 
        yDistance =  math.abs(endY - beginY)
        
        if xDistance > yDistance then
            if beginX > endX then
                if levelSlide == 1 then  
                    moreLevelsBtn.isVisible = false
                    transition.to(levelBtnsLeft,{time=500,x = -480, onComplete=function() moreLevelsBtn.isVisible = true end})
                    transition.to(levelBtnsRight,{time=500,x = -480, onComplete=function() moreLevelsBtn.isVisible = true end})
                    levelSlide = 2
                    moreLevelsBtn.rotation = 180
                    scores:store("levelSlide",2)
                end
            else 
                if levelSlide == 2 then
                    moreLevelsBtn.isVisible = false
                    transition.to(levelBtnsLeft,{time=500,x = 0, onComplete=function() moreLevelsBtn.isVisible = true end})
                    transition.to(levelBtnsRight,{time=500,x = 0, onComplete=function() moreLevelsBtn.isVisible = true end})
                    levelSlide = 1
                    moreLevelsBtn.rotation = 0
                    scores:store("levelSlide",1)
                end
            end
        else 
            if beginY > endY then
                print("swipe up")
            else 
                print("swipe down")
            end
        end
        
    end
    
    
    local function swipe(event)
        if event.phase == "began" then
            beginX = event.x
            beginY = event.y
        end
        
        if event.phase == "ended"  then
            endX = event.x
            endY = event.y
            checkSwipeDirection();
        end
        
        return true
    end
    
    
    ------------------
    -- Listeners
    ------------------
    local popClosed = function(whatToDo)
        clean()
        director:changeScene({level=1},"level-loader","crossfade")
    end
    
    local levelButtonHandler = function( event )
        if event.phase == "began" then
            audio.stop(backgroundMusicChannel)
            
            local notStarted = scores:retrieve("notStarted") or 0
            if notStarted == 0 then
                scores:store("notStarted", 1)
                director:openPopUp({}, "screen-help",popClosed)
                popOnDisplay = true;
            else
                clean()
                director:changeScene({level=event.target.level},"level-loader","crossfade")
            end
            notStarted = nil
        end
        
        return true
    end
    --[[
    local backBtnHandler = function (event )
    if event.phase == "release" then
    director:changeScene( "level-loader", "crossfade" )
    end
    end
    ]]--
    local moreLevelsSlider = function ()
        if levelSlide == 1 then  
            transition.to(levelBtnsLeft,{time=500,x = -480})
            transition.to(levelBtnsRight,{time=500,x = -480})
            levelSlide = 2
            if moreLevelsBtn then
                moreLevelsBtn.rotation = 180
            end
            scores:store("levelSlide",2)
        else
            transition.to(levelBtnsLeft,{time=500,x = 0})
            transition.to(levelBtnsRight,{time=500,x = 0})
            levelSlide = 1
            if moreLevelsBtn then
                moreLevelsBtn.rotation = 0
            end
            scores:store("levelSlide",1)
        end
    end
    
    
    
    local touched = function ( event )
        if event.phase == "began" then
            moreLevelsSlider()
        end
        return true
    end
    
    
    moreLevelsBtn:addEventListener( 'touch', touched )
    ------------------
    -- Helper Methods
    ------------------
    -- Helper function for the level selection button placement
    local addLockOnLevel = 2
    local createLevelBtn = function (index)
        local btnId = "Level".. index .. "Button"
        local sheetIndex = index + 41 + index -1 
        local overIndex = sheetIndex + 1
        local btnEventHandler = function() return true end
        if addLockOnLevel > index then
            btnEventHandler = levelButtonHandler
        end
        
        local levelBtn = display.newGroup( )
        local levelBtnRect = display.newRoundedRect(0, 0, 50, 50, 12 )
        levelBtnRect.strokeWidth = 3
        
        levelBtnRect:setFillColor(48,136,196)
        levelBtnRect:setStrokeColor(32,90,130)
        
        local levelBtnText = display.newText(index,20,12,"HelveticaNeue-Bold",16)
        
        levelBtn:insert( levelBtnRect )
        levelBtn:insert( levelBtnText )
        
        levelBtn:addEventListener( 'touch', btnEventHandler )
        
        local x = 74 + 90*((index-1)%4) 
        local y = 74 + 70*math.floor((index-1)/4)
        
        levelBtn.x = x levelBtn.y = y
        levelBtn.isVisible = true
        levelBtn.level = index
        
        
        -- Check level locked or not..
        local lock = nil
        if addLockOnLevel <= index then
            lock = display.newImageRect(all,43, 20,30)
            lock.x = (x+45)
            lock.y = (y)
        end
        
        
        btnId,sheetIndex,overIndex,btnEventHandler,x,y = nil,nil,nil,nil,nil,nil
        return {btn=levelBtn,lock=lock}
        
    end
    
    
    ------------------
    -- Display Objects
    ------------------
    
    local background = display.newImageRect(backgrounds,2, 480,360)
    
    
    for i=1, 24, 1 do
        local scores = ice:loadBox( "scores" )
        local scoreTextBest = scores:retrieve( "level"..i ) or 0
        if scoreTextBest ~= 0 then
            addLockOnLevel = i+2
        end
        local btnContent
        if i <= 12 then
            btnContent = createLevelBtn(i)
            levelBtnsLeft:insert(btnContent.btn)
            
            -- Uncomment the following to lock the levels..
            if btnContent.lock ~= nil then
                levelBtnsLeft:insert(btnContent.lock)
            end
        else
            btnContent = createLevelBtn(i)
            btnContent.btn.x = btnContent.btn.x + 480
            btnContent.btn.y = btnContent.btn.y - 210
            
            if btnContent.lock ~= nil then
                btnContent.lock.x = btnContent.lock.x + 480
                btnContent.lock.y = btnContent.lock.y - 210
            end
            levelBtnsRight:insert(btnContent.btn)
            
            -- Uncomment the following to lock the levels..
            if btnContent.lock ~= nil then
                levelBtnsRight:insert(btnContent.lock)
            end
            
        end
        scores,scoreTextBest,btnContent = nil,nil,nil
    end
    
    
    
    
    
    --== Close Button
    --[[
    local backBtn = widget.newButton{
    sheet = all,
    defaultIndex = 194,
    overIndex = 195,
    width = 85,
    height = 23,
    onEvent = backBtnHandler,
    id = "CloseButton",
    text = "",
    emboss = false
    }
    ]]--
    
   
    
    clean =  function ()
        
        
        -- removing event listners
        if swipe then
            Runtime:removeEventListener("touch", swipe)
        end
        if touched then
            background:removeEventListener( "touch" , touched )
        end
        if background then 
            display.remove(background) 
            background = nil 
        end 
        if scores then
            scores = nil
        end
        
        for i=1, 24, 1 do
            if i <= 12 then 
                if levelBtnsLeft and levelBtnsLeft[i] then
                    if levelBtnsLeft[i].btn then
                        levelBtnsLeft[i]:removeEventListener( 'touch', btnEventHandler )
                        display.remove(levelBtnsLeft[i].btn)
                        levelBtnsLeft[i].btn = nil
                    end
                    if levelBtnsLeft[i].lock then
                        display.remove(levelBtnsLeft[i].lock)
                        levelBtnsLeft[i].lock = nil
                    end
                end
            else 
                if levelBtnsRight and levelBtnsRight[i] then
                    if levelBtnsRight[i].btn then
                        levelBtnsRight[i]:removeEventListener( 'touch', btnEventHandler )
                        display.remove(levelBtnsRight[i].btn)
                        levelBtnsRight[i].btn = nil
                    end
                    if levelBtnsRight[i].lock then 
                        display.remove(levelBtnsRight[i].lock)
                        levelBtnsRight[i].lock = nil
                    end
                end
            end
        end
        if levelBtnsLeft then
            display:remove(levelBtnsLeft)
            levelBtnsLeft = nil
        end
        
        if levelBtnsRight then
            display:remove(levelBtnsRight)
            levelBtnsRight = nil
        end
    
        if moreLevelsBtn then
            moreLevelsBtn:removeEventListener( 'touch', touched )
            display:remove(moreLevelsBtn)
            moreLevelsBtn = nil
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
    localGroup:insert( levelBtnsLeft )
    localGroup:insert( levelBtnsRight )
    localGroup:insert( moreLevelsBtn )
    --localGroup:insert( backBtn )
    
    
    
    
    ------------------
    -- Positions
    ------------------
    
    
    background.x= display.contentWidth/2
    background.y = display.contentHeight/2
    --backBtn.x = 50; backBtn.y = 300
    moreLevelsBtn.x = 430; moreLevelsBtn.y = 160
    
    
    local scores = ice:loadBox( "scores" )
    levelSlide = scores:retrieve("levelSlide")
    
    if levelSlide == nil then
        levelSlide = 1
    end
    
    
    
    if levelSlide == 2 then  
        levelBtnsLeft.x  = -480
        levelBtnsRight.x = -480
        moreLevelsBtn.rotation = 180
    else
        levelBtnsLeft.x  = 0
        levelBtnsRight.x = 0
        moreLevelsBtn.rotation = 0
    end
    
    ------------------
    -- Sound
    ------------------
    if soundOn then
        if not audio.isChannelPlaying(backgroundMusicChannel) then
            audio.setVolume(1.0)
            audio.rewind()
            audio.play( backgroundMusic, { loops=-1}  )  -- play the background music on channel 1, loop infinitely, and fadein over 5 seconds 
        end
    end
    
    ------------------
    -- Listeners
    ------------------
    
    background:addEventListener( "touch" , touched )
    Runtime:addEventListener("touch", swipe)
end

------------------
-- Initiate variables
------------------

initVars()
path,file,beginX,beginY = nil,nil,nil,nil,nil
endX,endY,xDistance,yDistance,addLockOnLevel = nil,nil,nil,nil,nil
_W, _H = nil,nil
--Cleaning


------------------
-- MUST return a display.newGroup()
------------------

return localGroup

end
