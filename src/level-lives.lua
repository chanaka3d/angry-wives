local M = {}
local objectBotttom = display.contentHeight - 42
local shape_terrain_b = {-49.5/2,-15.5/2,49.5/2,-15.5/2,85.4/2,14.6/2,-85.4/2,14.6/2}
local getLevelLives = function(level)
    local data
    if(level == 1) then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
        }
    elseif level == 2 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            
        }  
   elseif level == 3 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
        }  
   elseif level == 4 then
        data = {
            {name="terrain-b" ,terrain = "terrain" ,x=50,y=objectBotttom-50,shape=shape_terrain_b}, -- this has to be the first one to come if there is a terrain

           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
        }
   elseif level == 5 then
        data = {
           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
           {name="babe-red" ,kind = "babe-red", lived=false},
        } 
   elseif level == 6 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
        } 
        
    elseif level == 7 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            
        } 
    elseif level == 8 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
        } 
        
    elseif level == 9 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red"   ,kind = "babe-red", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red"   ,kind = "babe-red", lived=false},
        }
        
    elseif level == 10 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red"   ,kind = "babe-red", lived=false},
            {name="babe-red"   ,kind = "babe-red", lived=false},
        } 
        
    elseif level == 11 then
        data = {
            {name="babe-green" ,kind = "babe-green", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
        }
    elseif level == 12 then
        data = {
            {name="babe-green" ,kind = "babe-green", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
        } 
        
   elseif level == 13 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
        } 
   elseif level == 14 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
        } 
          
    elseif level == 15 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
        } 
    elseif level == 16 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
            {name="babe-green" ,kind = "babe-green", lived=false},
        }
    elseif level == 17 then
        data = {
            {name="babe-blue", kind = "babe-blue",  lived=false},
            {name="babe-red",   kind = "babe-red",    lived=false},
        } 
    elseif level == 18 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-blue" ,kind = "babe-blue", lived=false},
        } 
    elseif level == 19 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-blue" ,kind = "babe-blue", lived=false},
        } 
    elseif level == 20 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-blue" ,kind = "babe-blue", lived=false},
        } 
    elseif level == 21 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
        } 
    elseif level == 22 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
        }    
    elseif level == 23 then
        data = {
            {name="babe-black" ,kind = "babe-black", lived=false},
            {name="babe-red"   ,kind = "babe-red", lived=false},
            {name="babe-black" ,kind = "babe-black", lived=false},
        }
    elseif level == 24 then
        data = {
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
            {name="babe-red" ,kind = "babe-red", lived=false},
        }
            
    end
    
    
    
    return data
end
M.getLevelLives = getLevelLives

return M