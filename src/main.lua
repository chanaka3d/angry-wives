CiderRunMode = {};CiderRunMode.assertImage = true;require "CiderDebugger";display.setStatusBar( display.HiddenStatusBar )

--====================================================================--
-- DIRECTOR CLASS SAMPLE
--====================================================================--

--[[

 - Version: 1.3
 - Made by Ricardo Rauber Pereira @ 2010
 - Blog: http://rauberlabs.blogspot.com/
 - Mail: ricardorauber@gmail.com

******************
 - INFORMATION
******************

  - This is a little sample of what Director Class does.
  - If you like Director Class, please help us donating at my blog, so I could
	keep doing it for free. http://rauberlabs.blogspot.com/

--]]

--====================================================================--
-- IMPORT DIRECTOR CLASS
--====================================================================--

local director = require("director")
local physics = require( "physics" )
physics.start()
local options = require("assets.backgrounds").getSheetOptions()
backgrounds = graphics.newImageSheet( "assets/backgrounds.png", options )

options = require("assets.all").getSheetOptions()
all = graphics.newImageSheet( "assets/all.png", options )
options = nil

--[[
local saveData = "My app state data"

local path = system.pathForFile( "myfile.txt", system.DocumentsDirectory )
local file = io.open( path, "w" )
file:write( saveData )
io.close( file )

--]]
local path = system.pathForFile( "angryBabes.txt", system.DocumentsDirectory )
local file = io.open( path, "r" )

if file ~= nil then
    local saveData = file:read( "*a" )
    io.close( file )

    print(saveData)
    if saveData == "true" then 
        soundOn = true
    else
        soundOn = false
    end
else
    soundOn = true
end

print( soundOn )
--====================================================================--
-- CREATE A MAIN GROUP
--====================================================================--

local mainGroup = display.newGroup()


--====================================================================--
-- PLAY THE MAIN MUSIC
--====================================================================--

backgroundMusic = audio.loadStream("audio/main.mp3")
if soundOn then
    backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }  )  -- play the background music on channel 1, loop infinitely, and fadein over 5 seconds 
end

--====================================================================--
-- MAIN FUNCTION
--====================================================================--

local main = function ()
	------------------
	-- Add the group from director class
	------------------
	
	mainGroup:insert(director.directorView)
	
	------------------
	-- Change scene without effects
	------------------
	
	director:changeScene("screen1")
	------------------
	-- Return
	------------------
	
	return true
end

--====================================================================--
-- BEGIN
--====================================================================--

main()

-- It's that easy! :-)

local monitorMem = function()



    collectgarbage()

    print( "MemUsage: " .. collectgarbage("count") )



    local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000

    print( "TexMem:   " .. textMem )

end



--Runtime:addEventListener( "enterFrame", monitorMem )
