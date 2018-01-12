module(..., package.seeall)


--====================================================================--
-- SCENE: SCREEN 1
--====================================================================--
local _W = display.contentWidth
local _H  = display.contentHeight



system.activate( "multitouch" )

new = function ( params )
    --clean()
    physics.start()
    ------------------
    -- Imports
    ------------------
    local localGroup = display.newGroup()
    local level = params.level
    
    ------------------
    -- Audio
    ------------------
    audio.stop()
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
    else
        soundOn = true
    end
    
    
    ------------------
    -- Imports
    ------------------
    
    require( "ice" )
    local widget = require "widget"
    
    -- Load or Create our Score box
    local scores = ice:loadBox( "scores" )
    local scoreTextBest = scores:retrieve( "level"..level ) or 0
    local scoreText = 0
    
    local scoreTextLabel = display.newText('Level' .. level .. ' :  ' .. scoreText,350,20,nil,15)
    local scoreTextBestLabel = display.newText("Best : ".. scoreTextBest,350,0,nil,15)
    
    scoreTextLabel:setTextColor(0,0,0)
    scoreTextLabel:setReferencePoint(display.TopLeftReferencePoint)
    scoreTextLabel.x= _W - scoreTextLabel.width - 20
    scoreTextBestLabel:setTextColor(0,0,0)
    scoreTextBestLabel:setReferencePoint(display.TopLeftReferencePoint)
    scoreTextBestLabel.x = _W - scoreTextBestLabel.width - 20
    
    if scoreTextBest == 0 then
        scores:store( "level"..level, 0)
    end
    local incrementScore = function(by)
        if by == nil then by = 0 end
        scoreText = scoreText + by   
        scoreTextLabel.text = 'Level' .. level .. ' : ' .. scoreText
        scoreTextLabel.x= _W - scoreTextLabel.width - 20
    end
    
    
    --physics.setDrawMode( "hybrid" )
    ------------------
    -- Groups
    ------------------
    
    local localGroup = display.newGroup()
    local livesGroup = display.newGroup()
    local levelData = require("level-data").getLevelData(level)
    local livesData = require("level-lives").getLevelLives(level)
    
    local stage = display.currentStage
    local foreground = display.newGroup() 
    stage.refGroup = foreground
    
    stage.xMin = -480 ; stage.xMax = 0 ; stage.yMin = 0 ; stage.yMax = 0
    
    
        
        
        local prevTrail = display.newGroup( )
        prevTrail.isVisible = false
        foreground:insert( prevTrail )
        
        ------------------
        -- Params
        ------------------
        local _W = display.contentWidth
        local _H  = display.contentHeight
        local stageBottom =_H-51 --Don't know the reason but have to reduce another 10pixles
        local followBabe = false
        
        ------------------
        -- Display Objects
        ------------------
        -- Background buildings
        -- sets gradient 'g' on rect
        
        local g = graphics.newGradient(
        { 131, 181, 228 },
        { 228, 227, 131 },
        "down" )
        local rect = display.newRect(foreground, 0, -200, 960, 720 )
        rect:setFillColor( g ) 
        g = nil
        foreground:insert( rect )
        
        local object01_1 = display.newImageRect( foreground,backgrounds ,6 ,240, 90.5 ) 
        
        -- Ground
        
        local foreObject_1 = display.newImageRect( foreground,all ,202 ,240.5, 25.5 )
        local foreObject_2 = display.newImageRect( foreground,all ,202 ,241, 25.5 )
        local foreObject_3 = display.newRect(foreground,0,stageBottom-32,4000,500)
        local mainBack    = display.newImageRect( foreground,all ,44 ,480, 360 );mainBack.x = _W/2;mainBack.y = _H/2 +56
        
        
        local foreObject_4 = display.newRect(480, -1500 , 10,1780)
        foreground:insert(foreObject_4 )
        
        
        foreObject_3.name = "ground"
        foreObject_4.name = "ground"
        physics.addBody( foreObject_3, "static", {density=1.0, bounce=0, friction=0.5} )
        physics.addBody( foreObject_4, "static", {density=1.0, bounce=0, friction=0.5} )
        
        
        
        
        ------------------------------------
        ------------------------------------
        --Create the spring and babe
        ------------------------------------
        ------------------------------------
        
        local launcher = display.newImageRect(foreground, all,68, 42.5, 32.5 )
        
        local clean, babeCircle, babeLaunchGroup, btPopUp,babeCount,loadNewLife,touchBabe,babeInit_x,babeInit_y,getBabeById,xShift,onEveryFrame,popClosed
        local touchScreenForBabe
        local babeTerrainShift = 0
        local timerStash = {}
        local transitionStash = {}
        local babes = {}
        local babeCount = 0
        local popOnDisplay = false
        local allTransCount = 1
        local spring = display.newImageRect(foreground,all,69, 20, 52 )
        local arrow = display.newImageRect(foreground,all,60, 21, 125 )
        local xScale = 1
        local bombable = false
        
        arrow.x = 72
        arrow.y = _H/2        
        
        arrow:setReferencePoint(display.BottomCenterReferencePoint)
        arrow.yScale = 1
        arrow.rotation = 45
        arrow.alpha = 0
        
        launcher.x = 70
        launcher.y = _H/2+65
        
        spring.x = 72
        spring.y = _H/2+37        
        
        spring:setReferencePoint(display.BottomCenterReferencePoint)
        spring.yScale = 1
        spring.rotation = 45
        spring:toFront( )
        
        
        
        babeCircle = display.newCircle( foreground, 0,0, 30 )
        -------------------------
        -- Show the help screens for each powered babe
        -------------------------
        local levelPlayed = scores:retrieve( "level-played".. level ) or false
        if not levelPlayed then
            if level == 6 or level==11 or level == 17 then
                director:openPopUp({level=level}, "screen-help-inside",popClosed)
            end
            scores:store( "level-played"..level, true)
        end
        levelPlayed = nil
        
        ---------------------------
        
        ---------------------------   
        
        local function loadNewLife()
            local index = 1
            for i = 1 , babeCount do
                if babes[i].state == "" then
                    index = i
                end
            end
            
            
            
            local nextLife = livesGroup[livesGroup.numChildren]
            
            if livesGroup.numChildren ~= 0 then
                if nextLife.kind == "babe-red" then
                    babes[index] = display.newImageRect(foreground,all,1 ,  17.5, 17.5 )
                elseif nextLife.kind == "babe-green" then
                    babes[index] = display.newImageRect(foreground,all,14 , 17.5, 17.5 )
                elseif nextLife.kind == "babe-blue" then
                    babes[index] = display.newImageRect(foreground,all,22 , 17.5, 17.5 )   
                elseif nextLife.kind == "babe-black" then
                    babes[index] = display.newImageRect(foreground,all,42 , 17.5, 17.5 )
                end
            end
            
            babes[index].rotation = 45
            babeInit_x = spring.x + (spring.height+18/2)*math.sin(math.rad(45))
            babeInit_y = spring.y - (spring.height+18/2)*math.cos(math.rad(45)) 
            babes[index].x = babeInit_x; babes[index].y = babeInit_y
            babes[index]:toFront( )
            --babes[index]:addEventListener( "touch", touchBabe )
            
            babes[index].id = "babe" .. (livesGroup.numChildren + 1)
            babes[index].state = "living"
            babes[index].name = "babe"
            babes[index].kind = livesGroup[livesGroup.numChildren].kind
            timer.cancel( timerStash[livesGroup[livesGroup.numChildren].tid] )
            display.remove(livesGroup[livesGroup.numChildren])
            livesGroup[livesGroup.numChildren] = nil
            
            babeCircle:addEventListener( "touch", touchBabe )
            babeCircle.x = babeInit_x; babeCircle.y = babeInit_y
            babeCircle:toFront( )
            babeCircle.alpha = 0.1
            babeCircle.currentBabe = babes[index]
            
            index,nextLife = nil,nil
        end
        
        
        
        
        touchBabe =  function ( event )
            local target = event.target
            local currentBabe = event.target.currentBabe
            local eXpos = event.x 
            local eYpos = event.y
            local k,xk,newAngle,x,y,xForce,yForce
            if not bombable then bombable = true end
            
            
            if event.phase == "began" then
                display.getCurrentStage():setFocus(target)
                target.hasFocus = true
                target,currentBabe,eXpos,eYpos = nil ,nil, nil, nil
                return true
            elseif target.hasFocus then
                if event.phase == "moved" then
                    
                    eXpos = event.x/xScale --+ currentBabe.width/2
                    eYpos = (event.y - (_H - _H*xScale)/2)/xScale--+ target.height/2
                    
                    k = spring.height + currentBabe.height/2 
                    xk = math.sqrt (math.pow(eXpos - spring.x,2)+math.pow(eYpos-spring.y,2))
                    newAngle = math.atan(math.abs(eXpos-spring.x)/math.abs(eYpos-spring.y))
                    
                    --[[
                    
                    (D)  |   (A)
                    ------------
                    (C)  |   (B)
                    
                    ]]--
                    
                    
                    if eXpos - spring.x > 0 and eYpos - spring.y < 0  then -- Regin (A)
                        if k - xk > 0 then
                            currentBabe.x = eXpos
                            currentBabe.y = eYpos
                            
                            spring.rotation = math.deg( newAngle )
                            
                            local yScale = (xk - currentBabe.height/2)/spring.height
                            if yScale <= 0 then
                                yScale = 0.1
                            end
                            spring.yScale = yScale
                        else
                            currentBabe.x = spring.x + k*math.sin(newAngle)
                            currentBabe.y = spring.y - k*math.cos(newAngle)
                            
                            spring.rotation = math.deg( newAngle )
                            
                            spring.yScale = 1
                            
                        end
                    elseif eXpos - spring.x <= 0 and eYpos - spring.y < 0 then -- Regin (D)  
                        if k - xk > 0 then
                            spring.rotation = 0
                            
                            currentBabe.x = spring.x
                            currentBabe.y = eYpos
                            local yScale = (spring.y - eYpos - currentBabe.height/2)/spring.height
                            
                            if spring.yScale < 0 then
                                yScale = 0.1
                            end
                            spring.yScale = yScale
                            yScale = nil
                        else
                            currentBabe.x = spring.x
                            
                            spring.rotation = 0
                            if spring.y - eYpos > k then   -------Fix is here....
                                currentBabe.y = spring.y - k
                                spring.yScale = 1
                            else
                                currentBabe.y = eYpos
                                local yScale = (spring.y - eYpos - currentBabe.height/2 )/spring.height
                                if spring.yScale < 0 then
                                    yScale = 0.1
                                end
                                spring.yScale = yScale
                                yScale = nil
                            end                   
                            
                        end
                    elseif eXpos-spring.x >0 and eYpos-spring.y > 0 then --Regin (B)
                        local debugStr = " Regin B - "
                        if k - xk > 0 then
                            currentBabe.y = spring.y
                            
                            if spring.x - eXpos > 0 then  
                                currentBabe.x = spring.x
                                spring.yScale = 0.1
                            else
                                currentBabe.x = eXpos
                                local yScale = (eXpos - spring.x - currentBabe.height/2 )/spring.height
                                if spring.yScale < 0 then
                                    yScale = 0.1
                                end
                                spring.yScale = yScale
                                yScale = nil
                            end   
                        else
                            
                            currentBabe.x = spring.x + k
                            currentBabe.y = spring.y
                            
                            spring.yScale = 1
                        end
                        spring.rotation = 90
                        
                        
                    elseif  eXpos-spring.x < 0 and eYpos-spring.y > 0 then --Regin (C)
                        
                    end
                    
                    currentBabe.rotation = spring.rotation
                    arrow.rotation = spring.rotation
                    arrow.alpha = 0.3
                    
                    babeCircle.x = currentBabe.x; babeCircle.y = currentBabe.y
                    
                    
                elseif event.phase == "ended" then
                    display.getCurrentStage():setFocus(nil)
                    target.hasFocus = false
                    x = eXpos
                    y = eYpos
                    xForce = (-1 * (x - currentBabe.x ) ) * 2.15	--> 2.75
                    yForce = (-1 * (y - currentBabe.y)) * 2.15	--> 2.75
                    
                    
                    
                    local angularForce = 1800*(1- spring.yScale)
                    xForce = angularForce*math.sin(math.rad(spring.rotation ) ) -- Deived from F = -K x ( X - X0 ) Hook's Law
                    yForce = angularForce*math.cos(math.rad(spring.rotation))
                    angularForce = nil
                    
                    -- remove aiming feedback
                    currentBabe.state = "flying"
                    stage:addEventListener( "touch", touchScreenForBabe )
                    followBabe = true
                    physics.start()
                    local shapeRed = { -7.5,-9, 4,-5, 8,8, -8.5,7 }
                    physics.addBody( currentBabe, { density=4, friction=3, bounce=0.3 , radius=25, shape=shapeRed } )     
                    shapeRed = nil       
                    currentBabe:applyForce( xForce*2.2/10, -yForce*2.2/10, target.x, target.y )
                    
                    
                    local musicName = ""
                    if currentBabe.kind == "babe-red"  then
                        musicName = "audio/03-launch-red.mp3"
                    elseif  currentBabe.kind == "babe-blue" then  
                        musicName = "audio/04-launch-blue.mp3"
                    elseif  currentBabe.kind == "babe-green" then  
                        musicName = "audio/05-launch-green.mp3"
                    elseif  currentBabe.kind == "babe-black" then  
                        musicName = "audio/06-launch-black.mp3"
                    end
                    local lauchMusic,lauchMusicChanel = audio.loadSound(musicName),nil
                    if soundOn then
                        lauchMusicChanel = audio.play(lauchMusic)
                    end
                    
                    if prevTrail.numChildren > 0 then 
                        for i=1,prevTrail.numChildren do
                            display.remove( prevTrail[i] )
                            prevTrail[i] = nil
                        end
                        prevTrail:removeSelf( )
                        prevTrail = display.newGroup( )
                        foreground:insert(prevTrail)
                    end
                    lauchMusic,lauchMusicChanel = nil,nil
                    -- Reseting the spring and putting a new babe on it.
                    
                    -- First removing the timer to play the babe animation while waiting ( only last one has to remove )
                    babeCircle:removeEventListener( "touch", touchBabe )
                    
                    
                    local onTransComplete = function() 
                        
                        target.x = babeInit_x; target.y = babeInit_y 
                        arrow.rotation = 45
                        arrow.alpha = 0
                    end       
                    transitionStash.nt1 = transition.to(spring,{time=500,yScale=1,rotation=45, transition=easing.inOutExpo, onComplete=onTransComplete})
                    
                    
                    
                    
                    local nextLife = livesGroup[livesGroup.numChildren]
                    
                    local babeAnimHelper = function()
                        return function()
                            
                            transitionStash.nt2 = transition.to(nextLife,{time=500,x=babeInit_x, y=babeInit_y, onComplete=loadNewLife})
                            
                        end
                    end
                    
                    if nextLife  then
                        
                        transitionStash.nt3=transition.to(nextLife,{time=500,delay=500,x=babeInit_x-100, y=babeInit_y+20,
                        onComplete=babeAnimHelper()
                        })
                        
                        
                    end
                    
                    
                    
                else
                    display.getCurrentStage():setFocus(nil)
                    target.hasFocus = false
                    
                end
                
                k,xk,newAngle,x,y,xForce,yForce,angularForce,eXpos,eYpos,currentBabe = nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil                                         -- Cancel phase    
                
                return true
            end
            k,xk,newAngle,x,y,xForce,yForce,angularForce,eXpos,eYpos,currentBabe = nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil                                         -- Cancel phase    
            return false
        end
        
        local terrain
        local function createLives()
            
            
            local sequenceData =
            {
            frames= { 2,3,4,5,6,7,8,9,10,11,12,13,12,11,10,9,8,7,6,5,4,3,2 }, -- frame indexes of animation, in image sheet
            time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
            loopCount = 1        -- Optional. Default is 0.
            
            }
            
            -- LIVES DISPLAY
            local y_base = stageBottom-42
            local x_offset = -10
            local img,prev
            
            function  playWithDelayHelper(img)
                local tmp = img
                local playing = false
                return  function ()
                    
                    if playing  then
                        if tmp then  
                            tmp:pause() 
                        end
                        playing = false
                    else
                        if tmp and type(tmp)=="table"  then 
                            tmp:play() 
                        end
                        playing = true
                    end
                end
            end
            
            for i=1, #livesData do
                
                if livesData[i].terrain then
                    if livesData[i].name == "terrain-b" then
                        terrain = display.newImageRect(all,204,85,15)
                        terrain.y = livesData[i].y 
                        terrain.x = livesData[i].x 
                        local physicsProperties = { friction=0.5, bounce=0.3 } 
                        physicsProperties.shape = livesData[i].shape
                        physics.addBody( terrain, "static", physicsProperties )
                        foreground:insert(terrain)
                        
                        babeTerrainShift = 15
                        launcher.y = launcher.y - babeTerrainShift
                        spring.y = spring.y - babeTerrainShift
                        arrow.y = arrow.y - babeTerrainShift
                    end
                else
                    
                    if(livesData[i].kind == "babe-green") then
                        sequenceData.frames = {15,16,17,18,19,20,21,20,19,18,17,16,15}
                    elseif (livesData[i].kind == "babe-blue") then
                        sequenceData.frames = {23,24,25,26,27,28,29,30,31,32,33,32,31,30,29,28,27,25,24,23}
                    elseif (livesData[i].kind == "babe-red") then
                        sequenceData.frames = {2,3,4,5,6,7,8,9,10,11,12,13,13,12,11,10,9,8,7,6,5,4,3,2}
                    elseif (livesData[i].kind == "babe-black") then
                        sequenceData.frames = {45,46,47,48,49,50,51,52,53,54,55,56,56,55,54,53,52,51,50,49,48,47,46,45}
                    end
                    
                    img = display.newSprite( all, sequenceData )
                    if i==1 then
                        img.x = 45
                    else
                        if prev then
                            img.x = prev.x + x_offset
                        else
                            img.x = 45
                        end
                        
                    end
                    img.name = livesData[i].name
                    img.kind = livesData[i].kind
                    img.lived = livesData[i].lived
                    babeCount = babeCount + 1
                    babes[babeCount] = {state=''}
                    
                    
                    img.y = y_base-babeTerrainShift
                    img:pause()
                    img.tid = 'newTimerx'..i
                    timerStash['newTimerx'..i] = timer.performWithDelay( math.random ( 1000,5000 ),playWithDelayHelper( img ),0 )
                    livesGroup:insert( img )
                    prev = img
                end
            end
            
            
            
            sequenceData, y_base,x_offset,prev,img = nil,nil,nil,nil,nil
            
            
        end
        
        -- Create Life icons
        
        --self.layer.physicsForegroundGroup:insert( o.display )
        --babe.isBodyActive = false
        --babe:addEventListener( babe.UPDATE_EVENT, self )
        
        
        
        local function getBabeById(id)
            local currentBabe
            local i
            for i=1,foreground.numChildren do
                if(id==foreground[i].id) then
                    currentBabe = foreground[i]
                end
                
            end
            i = nil
            return currentBabe
        end
        
        
        local function getObjectByName(name)
            local currentObj
            local i
            for i=1,foreground.numChildren do
                if(name==foreground[i].name) then
                    currentObj = foreground[i]
                end
                
            end
            i = nil
            return currentObj
        end
        
        local function onLocalPostCollisionHelper(obj,force)
            function  dieWithDelayHelper(img)
                local tmp = img
                return  function ()
                    local itemName = tmp.name
                    tmp:removeSelf( )
                    tmp = nil
                    
                    if(itemName == "man1" or itemName == "man2") then
                        local found = false
                        for i=1,foreground.numChildren do
                            if(foreground[i].name=="man1" or foreground[i].name=="man2") then
                                found = true
                            end
                            
                        end -- end for
                        
                        if not found then
                            
                            --- Save the score as best if it is the best
                            local best = scores:retrieve( "level"..level ) or scoreText
                            
                            
                            timerStash['newTimer'.. #timerStash] = timer.performWithDelay(2000, 
                            function()
                                local scoreForRemainingBabes = 0
                                for i=1, babeCount do
                                    if babes[i]  then
                                        if babes[i].state~="ghost" then
                                            scoreForRemainingBabes = scoreForRemainingBabes + 2000
                                        end
                                    end
                                end
                                if not popOnDisplay then
                                    director:openPopUp({bestScore = best, score =scoreText, scoreForRemainingBabes = scoreForRemainingBabes,level=level}, "screen-won",popClosed)
                                    popOnDisplay = true;
                                end
                                
                            end, 1)
                        end -- end not found
                        found = nil
                    end -- end man1 or man2
                    
                    
                end -- end retrun function
            end  -- end dieWithDelayHelper 
            if not (obj.health == nil) then
                if obj.name == 'man1' then
                end
                    if force < 0 then force = force*(-1) end
                    
                    if(obj.name == "man1" or obj.ame == "man2" ) then
                        obj.health = obj.health - force*5
                    else
                        obj.health = obj.health - force*3
                    end
                    
                    local scoreDelta = 0
                    if(obj.health < 80 and obj.health >20) then
                        
                        obj:setFrame(2)
                        
                        if(obj.name == "man1") then
                            scoreDelta = 200
                        elseif obj.name == "man2" then
                            scoreDelta = 200
                        elseif obj.name == "small-wooden-box" then
                            scoreDelta = 50
                        elseif obj.name == "big-wooden-box" then
                            scoreDelta = 60
                        elseif obj.name == "com" then
                            scoreDelta = 40
                        end
                    elseif obj.health <= 20 then
                        
                        local audioToPlay = nil
                        
                        if(obj.name == "man1") then
                            obj:setFrame(3)
                            
                            if not obj.died then
                                scoreDelta = 1000
                                obj:play()
                                obj.died = true
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(1000,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "man2" then
                            obj:setFrame(3)
                            
                            if not obj.died then
                                scoreDelta = 1000
                                obj:play()
                                obj.died = true
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(1000,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "small-wooden-box" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(200)
                                audioToPlay = audio.loadSound("audio/break-wood-1.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                            
                        elseif obj.name == "big-wooden-box" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(300)
                                audioToPlay = audio.loadSound("audio/break-wood-2.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "book-shelf" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(300)
                                audioToPlay = audio.loadSound("audio/break-wood-2.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "big-wooden-box" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                
                                incrementScore(300)
                                audioToPlay = audio.loadSound("audio/break-wood-2.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "small-wooden-box" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(300)
                                audioToPlay = audio.loadSound("audio/break-wood-2.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "wood-bar" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(300)
                                audioToPlay = audio.loadSound("audio/break-wood-2.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "com" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(150)
                                audioToPlay = audio.loadSound("audio/break-glass.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "glass-box" or obj.name =="t-a" or obj.name == "t-b" or obj.name == "t-c"  or obj.name == "t-d" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(50)
                                audioToPlay = audio.loadSound("audio/break-glass.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        elseif obj.name == "brick-small" or obj.name == "brick-large" then
                            if not obj.died then
                                obj:play()
                                obj.died = true
                                incrementScore(150)
                                audioToPlay = audio.loadSound("audio/break-wood-1.mp3")
                                timerStash['newTimer'.. #timerStash] = timer.performWithDelay(500,dieWithDelayHelper(obj), 1)
                            end
                        end
                        if audioToPlay ~= nil then
                            if soundOn then
                                local chanelX = audio.play(audioToPlay)
                            end
                        end
                        
                    end
                    
                    
                    incrementScore(scoreDelta)
                end
                
                
            end
            
            local removeBabe = function(dyingBabe)
                local dyingBabe = dyingBabe
                return function()
                    
                    
                    if dyingBabe.moving then
                        timerStash['newTimer'.. #timerStash] = timer.performWithDelay(1000, removeBabe(dyingBabe), 1)
                    else
                        
                        dyingBabe.state = "ghost"
                        dyingBabe:removeSelf()
                        dyingBabe = nil
                        local gameOver = true
                        
                        for i=1, babeCount do
                            if babes[i]  then
                                if babes[i].state~="ghost" then
                                    gameOver = false
                                end
                            end
                        end
                        
                        if gameOver then
                            
                            local found = false
                            for i=1,foreground.numChildren do
                                if(foreground[i].name=="man1" or foreground[i].name=="man2") then
                                    found = true
                                end
                                
                            end
                            
                            
                            --- Save the score as best if it is the best
                            local best = scores:retrieve( "level"..level ) or scoreText
                            
                            
                            if found then
                                if not popOnDisplay then
                                    director:openPopUp({bestScore = '', score =''}, "screen-lost",popClosed)
                                    popOnDisplay = true;
                                end
                                
                            else
                                if not popOnDisplay then
                                    local scoreForRemainingBabes = 0
                                    for i=1, babeCount do
                                        if babes[i]  then
                                            if babes[i].state~="ghost" then
                                                scoreForRemainingBabes = scoreForRemainingBabes + 1000
                                            end
                                        end
                                    end
                                    director:openPopUp({bestScore = best, score =scoreText, scoreForRemainingBabes = scoreForRemainingBabes,level=level}, "screen-won",popClosed)
                                    scoreForRemainingBabes = nil
                                    popOnDisplay = true;
                                end
                                
                            end
                            
                        end
                    end
                end
            end
            
            local function onLocalPostCollision( self, event )
                -- This new event type fires only after a collision has been completely resolved. You can use 
                -- this to obtain the calculated forces from the collision. For example, you might want to 
                -- destroy objects on collision, but only if the collision force is greater than some amount.
                
                
                if event.other.name ~= nil and event.other.name == "babe" then
                    if event.other.state == "flying" then
                        event.other.state = "dying"
                        followBabe = false
                        prevTrail.isVisible = true
                        
                        -- scrolling the view
                        local paraGroups = stage.paraGroups
                        
                        stage:removeEventListener( "touch", touchScreenForBabe )
                        
                    elseif event.other.state == "dying" then
                        event.other.state = "dead"
                        timerStash['newTimer'.. #timerStash] = timer.performWithDelay(5000, removeBabe(event.other), 1)
                    end
                end
                if self.name == 'man1' or self.name == 'man2' then
                    
                    if  event.force > 0.1  then
                        onLocalPostCollisionHelper(self,event.force)
                    end
                else
                    if  event.force > 0.4  then
                        onLocalPostCollisionHelper(self,event.force)
                    end    
                end
                
                if event.other.name == 'man1' or event.other.name == 'man2' then
                    if  event.force > 0.1  then
                        onLocalPostCollisionHelper(event.other,event.force)
                    end
                else
                    onLocalPostCollisionHelper(event.other,event.force)
                end    
           
                
                
                
                
                local bomb
                local bombR =20
                if self.name == "bomb"  then
                    bomb = self
                elseif  event.other.name == "bomb" then
                    bomb = event.other
                end
                
                if bomb ~=nil and bomb.active and bombable then
                    bomb.active = false
                    bomb:play()
                    timerStash['newTimer'.. #timerStash] = timer.performWithDelay( 500, 
                    function ( ) 
                        bomb:removeSelf( ) 
                        bomb = nil
                    end, 1 )
                    for i=1,foreground.numChildren do
                        local obj = foreground[i]
                        if obj and obj.bombable and obj.name ~= "bomb" then
                            local distance = math.sqrt(math.pow(bomb.x-obj.x,2) + math.pow(bomb.y-obj.y,2) )
                            if distance < bombR then
                                
                                local forcex = obj.x-bomb.x  
                                local forcey = (obj.y-bomb.y)*(-1)  
                                
                                --if obj.name == "man1" or obj.name == "man2" then
                                --end
                                
                                obj:applyForce( forcex*2, forcey*2, bomb.x, bomb.y ) 
                                --if obj.name == "man1" or obj.name == "man2" then 
                                onLocalPostCollisionHelper(obj,forcex*4)
                                --end
                                forcex,forcey,distance = nil, nil, nil
                            end
                        end
                    end
                    --bomb.removeSelf()
                    
                end
            end
            
            local function createObj(obj)
                local physicsParms = {}
                physicsParms.friction = 0.5
                physicsParms.bounce = 0
                --local shape_man1 = {-5,-9, 4,-20, 13,-13, 11,15, 12,20, -12,20, -14,12, -7,4}
                --local shape_man2 = {-11,-9, -8,-19,  7,-18,  12,-10, 7,-6, 11,13, 11,20 ,  -15,20, -9,10}
                local sequenceData
                
                physicsParms.density = 1
                
                -- Vertical slab
                if obj.name == "book-shelf" then
                    sequenceData =
                    {
                    frames= { 117,118,119,120,121,122,123,124,125,126,127 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 300
                    
                    -- Big wooden box
                elseif obj.name == "big-wooden-box" then
                    sequenceData =
                    {
                    frames= { 106,107,108,109,110,111,112,113,114,115,116 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 150
                    physicsParms.density = 0.5
                    -- Small wooden box
                elseif obj.name == "small-wooden-box" then
                    sequenceData =
                    {
                    frames= { 95,96,97,98,99,100,101,102,103,104,105 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 200
                    
                    -- Horizontal wood bar
                elseif obj.name == "wood-bar" then
                    
                    sequenceData =
                    {
                    frames= { 128,129,130,131,132,133,134,135,136,137 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 200
                    
                    
                    -- Computer
                elseif obj.name == "com" then
                    sequenceData =
                    {
                    frames= { 70,71,72,73,74,75,76,77,78,79,80,81,82,83 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                elseif obj.name == "brick-small" then
                    sequenceData =
                    {
                    frames= { 149,150,151,152,153,154,155,156,157,158,159}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                    
                elseif obj.name == "brick-large" then
                    sequenceData =
                    {
                    frames= { 138,139,140,141,142,143,144,145,146,147,148}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 150
                    
                elseif obj.name == "t-a" then
                    sequenceData =
                    {
                    frames= { 160,161,162,163,164,165,166,167}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                    
                elseif obj.name == "t-b" then
                    sequenceData =
                    {
                    frames= { 168,169,170,171,172,173,174,175,176,177,178}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 550
                    
                elseif obj.name == "t-c" then
                    sequenceData =
                    {
                    frames= { 179,180,181,182,183,184,185,186,187,188,189}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                    
                elseif obj.name == "glass-box" then
                    sequenceData =
                    {
                    frames= { 84,85,86,87,88,89,90,91,92,93,94}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                    
                elseif obj.name == "t-d" then
                    sequenceData =
                    {
                    frames= { 190,191}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 150
                elseif obj.name == "ball" then
                    sequenceData =
                    {
                    frames= { 192,193}, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 300     
                    if( obj.density ~= nil ) then
                        physicsParms.density = obj.density
                    end
                    physicsParms.shape = {-5,-2,-2,-5,  2,-5,5,-2,  5,2,2,5, -2,5,-5,2}
                    -- man 1
                elseif obj.name == "man1" then
                    sequenceData =
                    {
                    frames= { 34, 35, 36 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                    --physicsParms.shape = shape_man1
                    -- man 2
                elseif obj.name == "man2" then
                    sequenceData =
                    {
                    frames= { 37,38,39 }, -- frame indexes of animation, in image sheet
                    time = 1000,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    }
                    o = display.newSprite( all, sequenceData )
                    o.health = 100
                    --physicsParms.shape = shape_man2
                    
                elseif obj.name == "terrain-a" then
                    
                    o =  display.newImageRect( all ,203 ,50, 50 )
                    
                elseif obj.name == "terrain-b" then
                    o =  display.newImageRect( all ,204 ,85, 15 )
                    
                elseif obj.name == "terrain-bar" then
                    o =  display.newImageRect( all ,206 ,50, 5 )
                    
                elseif obj.name == "terrain-box" then
                    o =  display.newImageRect( all ,207 ,25, 25 )
                    
                elseif obj.name == "terrain-triangle-big" then
                    o =  display.newImageRect( all ,208 ,25, 25 )
                    
                elseif obj.name == "terrain-triangle-small" then
                    o =  display.newImageRect( all ,209 ,25, 15 )
                    
                elseif obj.name == "bomb" then
                    sequenceData =
                    {
                    frames= { 9,10,11,12,13,14,15,16,17,18,19,20 }, -- frame indexes of animation, in image sheet
                    time = 500,           -- Optional. In ms.  If not supplied, then sprite is frame-based.
                    loopCount = 1        -- Optional. Default is 0.
                    }
                    o = display.newSprite( backgrounds, sequenceData )
                    o.active = true
                end
                o.name = obj.name
                o.died = false
                o.soundEmited = false
                
                if obj.shape then
                    physicsParms.shape = obj.shape
                end
                
                o.rotation = obj.rotation
                
                if obj.terrain then
                    physicsParms.density = 4;
                    physics.addBody( o,"static", physicsParms) 
                else
                    physics.addBody( o,"dynamic", physicsParms) 
                end
                
                
                physicsParms = nil
                return o
                
            end
            -- listener function for enterFrame event
            
            xShift = nil
            
            -------------------------------------
            -------------------------------------
            --- Other touch screen methods ------
            -------------------------------------
            -------------------------------------
            
            
            touchScreenForBabe = function ( event )
                local flyingBabe = nil
                for i=1, babeCount do
                    if babes[i] and babes[i].state == "flying" then
                        flyingBabe = babes[i]
                    end
                end
                if flyingBabe == nil then return false end
                if not flyingBabe.powerApplied then
                    local musicPw = ""
                    if flyingBabe.kind == "babe-black" then -- fast runner
                        flyingBabe:applyForce(300,0, flyingBabe.x, flyingBabe.y )
                        musicPw = "audio/babe-black-power.mp3" 
                    elseif flyingBabe.kind == "babe-blue" then --boomarang
                        flyingBabe:applyForce( -300,0,flyingBabe.x, flyingBabe.y )
                        musicPw = "audio/babe-green-power.mp3" 
                    elseif flyingBabe.kind == "babe-green" then --thunder girl
                        flyingBabe:applyForce( 0,300, flyingBabe.x, flyingBabe.y )
                        musicPw = "audio/babe-green-power.mp3"
                    elseif flyingBabe.kind == "babe-red" then
                        --flyingBabe:applyForce( 1000,0, flyingBabe.x, flyingBabe.y )
                        musicPw = "audio/babe-red-power.mp3"
                    end
                    
                    flyingBabe.powerApplied = true
                    local startMusic = audio.loadSound(musicPw)
                    if soundOn then
                        local startMusicChanel = audio.play(startMusic)
                    end
                    flyingBabe = nil
                    return true
                else
                    flyingBabe = nil
                    return false
                end
                
            end
            
            --[[
            local textDebug1 = display.newText( 'test', 100, 50, native.systemFont, 16 )
            local textDebug2 = display.newText( 'test', 100, 75, native.systemFont, 16 )
            
            textDebug1:toFront()
            textDebug2:toFront()
            
            local monitorMem = function()
            collectgarbage()
            textDebug1.text =  "MemUsage: " .. collectgarbage("count")
            local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
            textDebug2.text =  "TexMem:   " .. textMem
            
            textDebug1:toFront()
            textDebug2:toFront()
            end
            ]]--
            
            local function onEveryFrame( event )
                -- print( 'on every frame', followBabe)
                -- monitorMem()                        
                
                if followBabe then
                    -- find the flying babe
                    local flyingBabe = nil
                    for i=1, babeCount do
                        if babes[i].state == "flying" then
                            flyingBabe = babes[i]
                        end
                    end
                    
                    if flyingBabe then
                        -- Create the display trail
                        if  prevTrail.numChildren > 0 then
                            
                            local lastDot = prevTrail[prevTrail.numChildren]
                            local distance = math.sqrt(math.pow(lastDot.x-flyingBabe.x,2) + math.pow(lastDot.y-flyingBabe.y,2))
                            if distance > 20 then
                                local circle = display.newCircle(flyingBabe.x,flyingBabe.y, 3)
                                prevTrail:insert( circle )
                            end
                            distance = nil
                        else
                            local circle = display.newCircle(flyingBabe.x,flyingBabe.y, 3)
                            prevTrail:insert( circle )
                        end
                        prevTrail:toFront()
                        prevTrail.alpha = 0.5                      
                    end
                    
                    
                end
            end
            
            -- methods to clear the timers and transactions
            
            function cancelAllTimers()
                local k, v
                
                for k,v in pairs(timerStash) do
                    timer.cancel( v )
                    v = nil; k = nil
                end
                
                timerStash = nil
                timerStash = {}
            end
            
            --
            
            function cancelAllTransitions()
                local k, v
                
                for k,v in pairs(transitionStash) do
                    transition.cancel( v )
                    v = nil; k = nil
                end
                
                transitionStash = nil
                transitionStash = {}
            end
            
            clean = function()
                ------------
                -- Event Listeners
                ------------
                Runtime:removeEventListener( "enterFrame", onEveryFrame )
                stage:removeEventListener( "touch", touchScreenForBabe )
                babeCircle:removeEventListener( "touch", touchBabe )
                
                
                
                for i=1,prevTrail.numChildren do
                    display.remove( prevTrail[i] )
                    prevTrail[i] = nil
                end
                display.remove(prevTrail); prevTrail = nil
                
                
                for i=1,livesGroup.numChildren do
                    display.remove( livesGroup[i] )
                    livesGroup[i] = nil
                end
                display.remove( livesGroup )
                livesGroup = nil
                
                if scoreTextLabel then 
                    display.remove(scoreTextLabel) 
                    scoreTextLabel = nil
                end
                if scoreTextBestLabel then 
                    display.remove(scoreTextBestLabel) 
                    scoreTextBestLabel = nil
                end
                if btPopUp then 
                    btPopUp:removeEventListener( 'touch', btPopUpt )
                    display.remove(btPopUp) 
                    btPopUp = nil
                end
                
                print(foreground.numChildren)
                
                
                if rect.cr then rect:removeEventListener( "postCollision", rect ) end
                display.remove(rect); rect = nil
                
                if object01_1.cr then object01_1:removeEventListener( "postCollision", object01_1 ) end
                display.remove(object01_1); object01_1 = nil
                
                if foreObject_1.cr then foreObject_1:removeEventListener( "postCollision", foreObject_1 ) end
                display.remove(foreObject_1); foreObject_1 = nil
                
                if foreObject_2.cr then foreObject_2:removeEventListener( "postCollision", foreObject_2 ) end
                display.remove(foreObject_2); foreObject_2 = nil
                
                if foreObject_3.cr then foreObject_3:removeEventListener( "postCollision", foreObject_3 ) end
                display.remove(foreObject_3); foreObject_3 = nil
                
                if foreObject_4.cr then foreObject_4:removeEventListener( "postCollision", foreObject_4 ) end
                display.remove(foreObject_4); foreObject_4 = nil
                
                if mainBack.cr then mainBack:removeEventListener( "postCollision", mainBack ) end
                display.remove(mainBack); mainBack = nil
                
                if launcher.cr then launcher:removeEventListener( "postCollision", launcher ) end
                display.remove(launcher); launcher = nil
                
                if spring.cr then spring:removeEventListener( "postCollision", spring ) end
                display.remove(spring); spring = nil
                
                if arrow.cr then arrow:removeEventListener( "postCollision", arrow ) end
                display.remove(arrow); arrow = nil
                
                if babeCircle.cr then babeCircle:removeEventListener( "postCollision", babeCircle ) end
                display.remove(babeCircle); babeCircle = nil
                
                
                
                for i=1,#levelData do
                    local obj = getObjectByName(levelData[i].name)
                    if obj.cr then obj:removeEventListener( "postCollision", obj ) end
                    display.remove(obj); obj = nil
                end
                
                for i=1,foreground.numChildren do
                    if foreground[i] then
                        if foreground[i].cr then foreground[i]:removeEventListener( "postCollision", foreground[i] ) end
                        display.remove(foreground[i]); foreground[i] = nil
                    end
                end
                
                for i=1,localGroup.numChildren do
                    display.remove(localGroup[i]); localGroup[i] = nil
                end
                
                print(foreground.numChildren)
               
                display.remove( foreground )
                foreground = nil
                
                if localGroup[1].cr then localGroup[1]:removeEventListener( "postCollision", localGroup[1] ) end
                display.remove(localGroup[1]); localGroup[1] = nil
                
                print(localGroup.numChildren)
                display.remove(localGroup); localGroup = nil
             
              
                ---------------------
                --Canceling transitions
                ---------------------
                cancelAllTransitions()
                
                ---------------------
                --Canceling timers
                ---------------------
                cancelAllTimers()   
                
                
                
                timerStash = nil
                transitionStash = nil
                
                path = nil
                file = nil
                widget = nil
                scores = nil
                scoreTextBest = nil
                scoreText = nil
                levelData = nil
                livesData = nil
                _W = nil
                _H = nil
                stageBottom = nil
                followBabe = nil
                babeCount = nil
                babeInit_x = nil
                babeInit_y = nil
                getBabeById = nil
                xShift = nil
                babeTerrainShift = nil
                babes = nil -- need to loop and remove display objects
                babeCount = nil
                popOnDisplay = nil
                allTransCount = nil
                xScale = nil
                bombable = nil
                
                
                
                print(foreObject_1)
                print(foreObject_2)
                print(foreObject_3)
                print(foreObject_4)
                print(bombable)
                print(arrow)
                print(launcher)
                print(rect)
                print(spring)
                print(mainBack)
                print(babeCircle)
                print(prevTrail)
                print(localGroup)
                print(stage)
            end
            
            ------------------
            -- POPUP
            ------------------
            popClosed = function(whatToDo)
                popOnDisplay = false
                -----------------
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
                else
                    soundOn = true
                end
                
                
                if whatToDo == "resume-level" then
                    physics.start()
                    
                    -- check if the game has already ended and show the won screen
                    
                    local gameOver = true
                    
                    for i=1, babeCount do
                        if babes[i]  then
                            if babes[i].state~="ghost" then
                                gameOver = false
                            end
                        end
                    end
                    if gameOver then    
                        local found = false
                        for i=1,foreground.numChildren do
                            if(foreground[i].name=="man1" or foreground[i].name=="man2") then
                                found = true
                            end
                            
                        end
                        
                        if not found then
                            
                            --- Save the score as best if it is the best
                            local best = scores:retrieve( "level"..level ) or scoreText
                            
                            
                            timerStash['newTimer'.. #timerStash] =timer.performWithDelay(2000, 
                            function()
                                local scoreForRemainingBabes = 0
                                for i=1, babeCount do
                                    if babes[i]  then
                                        if babes[i].state~="ghost" then
                                            scoreForRemainingBabes = scoreForRemainingBabes + 2000
                                        end
                                    end
                                end
                                if not popOnDisplay then
                                    director:openPopUp({bestScore = best, score =scoreText, scoreForRemainingBabes = scoreForRemainingBabes,level=level}, "screen-won",popClosed)
                                    popOnDisplay = true;
                                end
                                
                            end, 1)
                        end
                    end        
                    
                    return
                end
             
                
                if whatToDo == "reload-level" then
                    physics.stop()
                    clean()
                    director:changeScene({level=level}, "level-loader", "crossfade" )
                elseif whatToDo == "main-menu" then
                    physics.stop()
                    audio.stop()
                    clean()
                    director:changeScene( "screen2", "moveFromLeft" )
                elseif whatToDo == "next-level" then
                    physics.stop()
                    audio.stop()
                    level = level + 1
                    clean()
                    director:changeScene({level=level}, "level-loader", "crossfade" )
                end
                
            end
            
            
            local btPopUpt = function ( event )
                if event.phase == "began" then
                    physics.pause()
                    
                    
                    --Runtime:removeEventListener( "enterFrame", onEveryFrame )
                    --director:changeScene( "level-loader", "crossfade" )
                    if not popOnDisplay then
                        director:openPopUp( "screen-pause",popClosed)
                        popOnDisplay = true
                    end
                    
                    
                end
                return true
            end
            
            local btPopUp = display.newImageRect( all,200,45,32 )
            btPopUp:addEventListener( 'touch', btPopUpt )
            
            
            -- director:openPopUp( {bestScore=2000,currentScore = 1000},"screen-won",popClosed)
            -- btPopUp.isVisible = false
            --====================================================================--
            -- INITIALIZE
            --====================================================================--
            
            
            local initVars = function ()
                -------------------
                -- Playing init sounds
                -------------------
                local startMusic = audio.loadSound("audio/01-babeChat.mp3")
                if soundOn then
                    local startMusicChanel = audio.play(startMusic)
                end
                
                
                
                ------------------
                -- Inserts
                ------------------
                
                localGroup:insert( foreground )
                localGroup:insert( btPopUp )
                localGroup:insert( scoreTextBestLabel )
                localGroup:insert( scoreTextLabel)
                ------------------
                -- Positions
                ------------------
                btPopUp.x = 30
                btPopUp.y = _H-20
                
                object01_1.x = _W/2
                object01_1.y = _H/2+20
                
                foreObject_1.x = _W/2
                foreObject_1.y = stageBottom+51/2
                
                foreObject_2.x = _W/2+478
                foreObject_2.y = stageBottom+51/2
                
                foreObject_3.setFillColor(foreObject_3, 65,65,65)
                foreObject_3.name = "ground"
                
                ------------------------------------
                ------------------------------------
                --Create level details
                ------------------------------------
                ------------------------------------
                --====================================
                -- Creating Lives
                --====================================
                createLives()
                foreground:insert(livesGroup)
                
                
                
                
                loadNewLife()
                local minLevelX = nil
                local objXShift = 120
                local objectBotttom = display.contentHeight - 84
                
                for i=1,#levelData do
                    if minLevelX == nil or minLevelX > levelData[i].x then
                        minLevelX = levelData[i].x 
                    end
                end
                
                for i=1,#levelData do
                    local obj = createObj(levelData[i])
                    
                    obj.x = (levelData[i].x-objXShift - minLevelX)/2 +minLevelX
                    obj.y = objectBotttom - (objectBotttom - levelData[i].y)/2  
                    obj.bombable = true
                    obj.isBlcoks = true
                    foreground:insert(obj)
                    print ( 'adding .. ' .. obj.name)
                end
                
                minLevelX = nil
                objXShift = nil
                
                
                timerStash['newTimer'.. #timerStash]  = timer.performWithDelay(1000, 
                function() 
                    for i=1,foreground.numChildren do
                        foreground[i].cr = true
                        foreground[i].postCollision = onLocalPostCollision
                        foreground[i]:addEventListener( "postCollision", foreground[i] )
                    end
                end
                )
                
                
                
                xDif,stageID,stageID = nil,nil,nil
                
                
                
                ------------------
                -- Listeners
                ------------------
                Runtime:addEventListener( "enterFrame", onEveryFrame )
                
            end 
            
            initVars()
            
            --Cleaning
            
            
            ------------------
            -- MUST return a display.newGroup()
            ------------------
            
            return localGroup
            
            end
