local M = {}
local shift = 120 
local objectBotttom = display.contentHeight - 84

local shape_terrain_a = {-25,-25, 25,-25, 25,-1, 4,-1, 4, 25, -25,25}
local shape_terrain_a_270 = {-25,-25,  0,-25,  0,-4.5,   25,-5,   25,25,    -25,25 ,-25,-25}
local shape_terrain_b = {-24.8,-8,25,-8,42.5,7.3,-42.5,7.3}
local shape_terrain_triangle_big = { 0,-12.5, 12.5,12.5, -12.5,12.5}
local shape_terrain_triangle_small = {0,-7.5, 12.5,7.5, -12.5,7.5} 
local shape_t_d = {-0.65, -0.85, 5.45,-5.25, 5.45, 4.85,-5.9, 4.85}
------------------
-- Shapes
------------------

local getLevelData = function(level)
    local data
     if(level == 1) then
        data = {
            
            
            
            { name="book-shelf",      x=240+shift, y=objectBotttom-25,rotation=0},--A
            { name="big-wooden-box",  x=240+shift, y=objectBotttom-75,rotation=0},--B
            { name="wood-bar",        x=280+shift, y=objectBotttom-105, rotation=90 },--C
            { name="man1",           x=245+shift, y=objectBotttom-130, rotation=0},--D
            { name="man1",           x=295+shift, y=objectBotttom-20,rotation=0},--D
            
            { name="small-wooden-box",  x=290+shift, y=objectBotttom-125,rotation=0},--E
            { name="wood-bar",        x=320+shift, y=objectBotttom-50,rotation=0},--G    --51 point reduction is working but don't know y..????
            
        }
    elseif level == 2 then
        data = {
            
            
            { name="book-shelf",        x=190+shift, y=objectBotttom-25,rotation=0},
            { name="book-shelf",        x=190+shift, y=objectBotttom-75,rotation=0},
            { name="small-wooden-box",  x=260+shift, y=objectBotttom-15, rotation=0 },
            { name="small-wooden-box",  x=300+shift, y=objectBotttom-15, rotation=0 },
            { name="small-wooden-box",  x=350+shift, y=objectBotttom-15, rotation=0 },
            
            { name="small-wooden-box",  x=355+shift, y=objectBotttom-45, rotation=0 },
            { name="small-wooden-box",  x=355+shift, y=objectBotttom-75, rotation=0 },
            { name="com",               x=370+shift, y=objectBotttom-105, rotation=0 },
            
            
            { name="glass-box",         x=260+shift, y=objectBotttom-40, rotation=0 },
            { name="glass-box",         x=260+shift, y=objectBotttom-60, rotation=0 },
            { name="glass-box",         x=260+shift, y=objectBotttom-80, rotation=0 },
            { name="man2",              x=290+shift, y=objectBotttom-50, rotation=0 },
            { name="wood-bar",          x=300+shift, y=objectBotttom-95, rotation=90 },
            { name="man1",              x=300+shift, y=objectBotttom-120, rotation=0 },
            { name="man1",              x=400+shift, y=objectBotttom-20, rotation=0 },
            
            
        }
        
    elseif level == 3 then
        data = {
            
            
            { name="brick-large",        x=140+shift+70, y=objectBotttom-10,rotation=0},
            { name="brick-large",        x=140+shift+70, y=objectBotttom-30,rotation=0},
            { name="small-wooden-box",   x=140+shift+70, y=objectBotttom-55,rotation=0},
            { name="small-wooden-box",   x=140+shift+70, y=objectBotttom-85,rotation=0},
            
            { name="man1",               x=185+shift+70, y=objectBotttom-20,rotation=0},
            
            { name="brick-large",        x=230+shift+70, y=objectBotttom-10,rotation=0},
            { name="brick-small",        x=240+shift+70, y=objectBotttom-30,rotation=0},
            
            { name="wood-bar",           x=270+shift+70, y=objectBotttom-45,rotation=90},
            { name="brick-small",        x=240+shift+70, y=objectBotttom-60,rotation=0},
            { name="brick-small",        x=240+shift+70, y=objectBotttom-80,rotation=0},
            { name="brick-small",        x=240+shift+70, y=objectBotttom-100,rotation=0},
            
            { name="glass-box",          x=245+shift+70, y=objectBotttom-120,rotation=0},
            { name="glass-box",          x=245+shift+70, y=objectBotttom-140,rotation=0},
            { name="wood-bar",           x=270+shift+70, y=objectBotttom-155,rotation=90},
            
            { name="com",                x=305+shift+70, y=objectBotttom-175,rotation=0},
            { name="wood-bar",           x=315+shift+70, y=objectBotttom-100,rotation=0},
            
            { name="brick-large",        x=335+shift+70, y=objectBotttom-10,rotation=0},
            { name="brick-small",        x=325+shift+70, y=objectBotttom-30,rotation=0},
            { name="brick-small",        x=375+shift+70, y=objectBotttom-10,rotation=0},
            
            
            { name="man2",               x=280+shift+70, y=objectBotttom-65,rotation=0},
            { name="man1",               x=375+shift+70, y=objectBotttom-40,rotation=0},
            { name="man2",               x=405+shift+70, y=objectBotttom-20,rotation=0},
            
            
            
        }
    elseif level == 4 then
        data = {
            { name="big-wooden-box",               x=200+shift, y=objectBotttom-25,rotation=0},
            { name="man1",                         x=200+shift, y=objectBotttom-70,rotation=0},
            
            { name="big-wooden-box",               x=280+shift, y=objectBotttom-25,rotation=0},
            { name="big-wooden-box",               x=280+shift, y=objectBotttom-75,rotation=0},
            { name="man2",               x=280+shift, y=objectBotttom-120,rotation=0},

            
            { name="big-wooden-box",               x=360+shift, y=objectBotttom-25,rotation=0},
            { name="book-shelf",                   x=330+shift, y=objectBotttom-75,rotation=0},
            { name="man1",                         x=355+shift, y=objectBotttom-70,rotation=0},

            { name="big-wooden-box",               x=360+shift, y=objectBotttom-125,rotation=0},
            
            { name="big-wooden-box",               x=420+shift, y=objectBotttom-25,rotation=0},
            { name="big-wooden-box",               x=415+shift, y=objectBotttom-75,rotation=0},
            { name="big-wooden-box",               x=440+shift, y=objectBotttom-125,rotation=0},
            { name="big-wooden-box",               x=420+shift, y=objectBotttom-175,rotation=0},
        }
        
        elseif level == 5 then
        data = {
            { name="brick-small",        x=150+shift+70, y=objectBotttom-10,rotation=0},
            { name="brick-small",        x=150+shift+70, y=objectBotttom-30,rotation=0},
            { name="brick-small",        x=150+shift+70, y=objectBotttom-50,rotation=0},
            
            { name="brick-small",        x=230+shift+70, y=objectBotttom-10,rotation=0},
            { name="brick-small",        x=230+shift+70, y=objectBotttom-30,rotation=0},
            { name="brick-small",        x=230+shift+70, y=objectBotttom-50,rotation=0},
            
            { name="wood-bar",           x=185+shift+70, y=objectBotttom-65,rotation=90},
            
            { name="brick-small",        x=150+shift+70, y=objectBotttom-80,rotation=0},
            { name="brick-small",        x=150+shift+70, y=objectBotttom-100,rotation=0},
            { name="brick-small",        x=150+shift+70, y=objectBotttom-120,rotation=0},
            
            { name="brick-small",        x=230+shift+70, y=objectBotttom-80,rotation=0},
            { name="brick-small",        x=230+shift+70, y=objectBotttom-100,rotation=0},
            { name="brick-small",        x=230+shift+70, y=objectBotttom-120,rotation=0},
            
            { name="wood-bar",           x=185+shift+70, y=objectBotttom-135,rotation=90},
            
            { name="man1",               x=185+shift+70, y=objectBotttom-20,rotation=0},
            { name="man2",               x=185+shift+70, y=objectBotttom-85,rotation=0},
            
            --- glass boxes
            { name="glass-box",          x=270+shift+70, y=objectBotttom-10,rotation=0},
            { name="glass-box",          x=270+shift+70, y=objectBotttom-30,rotation=0},
            { name="glass-box",          x=270+shift+70, y=objectBotttom-50,rotation=0},
            { name="glass-box",          x=270+shift+70, y=objectBotttom-70,rotation=0},
            { name="glass-box",          x=270+shift+70, y=objectBotttom-90,rotation=0},
            { name="glass-box",          x=270+shift+70, y=objectBotttom-110,rotation=0},
            { name="glass-box",          x=270+shift+70, y=objectBotttom-130,rotation=0},
            
            { name="glass-box",          x=290+shift+70, y=objectBotttom-10,rotation=0},
            { name="glass-box",          x=290+shift+70, y=objectBotttom-30,rotation=0},
            { name="glass-box",          x=290+shift+70, y=objectBotttom-50,rotation=0},
            { name="glass-box",          x=290+shift+70, y=objectBotttom-70,rotation=0},
            { name="glass-box",          x=290+shift+70, y=objectBotttom-90,rotation=0},
            { name="glass-box",          x=290+shift+70, y=objectBotttom-110,rotation=0},
            
            { name="wood-bar",           x=330+shift+70, y=objectBotttom-125,rotation=90},
            
            { name="glass-box",          x=340+shift+70, y=objectBotttom-10,rotation=0},
            { name="glass-box",          x=340+shift+70, y=objectBotttom-30,rotation=0},
            { name="glass-box",          x=340+shift+70, y=objectBotttom-50,rotation=0},
            { name="glass-box",          x=340+shift+70, y=objectBotttom-70,rotation=0},
            { name="glass-box",          x=340+shift+70, y=objectBotttom-90,rotation=0},
            { name="glass-box",          x=340+shift+70, y=objectBotttom-110,rotation=0},
            
            { name="man1",               x=312+shift+70, y=objectBotttom-20,rotation=0},

        }
        
        
     elseif level == 6 then
        data = {
            { name="big-wooden-box",     x=355+shift, y=objectBotttom-25,rotation=0},
            { name="big-wooden-box",     x=435+shift, y=objectBotttom-25,rotation=0},
            
            { name="glass-box",          x=325+shift, y=objectBotttom-60,rotation=0},
            { name="glass-box",          x=325+shift, y=objectBotttom-80,rotation=0},
            { name="glass-box",          x=325+shift, y=objectBotttom-100,rotation=0},
            { name="glass-box",          x=325+shift, y=objectBotttom-120,rotation=0},
            
            { name="man1",              x=355+shift, y=objectBotttom-70,rotation=0},
            { name="man2",              x=425+shift, y=objectBotttom-70,rotation=0},
            
            { name="glass-box",          x=380+shift, y=objectBotttom-60,rotation=0},
            { name="glass-box",          x=380+shift, y=objectBotttom-80,rotation=0},
            { name="glass-box",          x=380+shift, y=objectBotttom-100,rotation=0},
            
            { name="glass-box",          x=400+shift, y=objectBotttom-60,rotation=0},
            { name="glass-box",          x=400+shift, y=objectBotttom-80,rotation=0},
            { name="glass-box",          x=400+shift, y=objectBotttom-100,rotation=0},
            
            { name="glass-box",          x=450+shift, y=objectBotttom-60,rotation=0},
            { name="glass-box",          x=450+shift, y=objectBotttom-80,rotation=0},
            { name="glass-box",          x=450+shift, y=objectBotttom-100,rotation=0},
            
            { name="wood-bar",          x=420+shift, y=objectBotttom-115,rotation=90},
            
            { name="big-wooden-box",    x=380+shift, y=objectBotttom-145,rotation=0},
            
           { name="book-shelf",         x=430+shift, y=objectBotttom-145,rotation=0},
            { name="book-shelf",        x=450+shift, y=objectBotttom-145,rotation=0},
            
            { name="com",               x=390+shift, y=objectBotttom-185,rotation=0},
            { name="man1",              x=425+shift, y=objectBotttom-190,rotation=0},
    }
    elseif level == 7 then
        data = {
            {name="brick-large",          x=90+shift+100, y=objectBotttom-25,rotation=90},
            {name="brick-large",          x=170+shift+100, y=objectBotttom-25,rotation=90},
            {name="man1",                 x=130+shift+100, y=objectBotttom-20,rotation=0},
            {name="wood-bar",             x=130+shift+100, y=objectBotttom-55,rotation=90},
            {name="man2",                 x=130+shift+100, y=objectBotttom-80,rotation=0},
            
            {name="glass-box",          x=220+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",          x=220+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",          x=220+shift+100, y=objectBotttom-50,rotation=0},
            {name="glass-box",          x=220+shift+100, y=objectBotttom-70,rotation=0},
            {name="wood-bar",           x=260+shift+100, y=objectBotttom-85,rotation=90},
            {name="man1",               x=260+shift+100, y=objectBotttom-20,rotation=0},
            {name="man2",               x=260+shift+100, y=objectBotttom-110,rotation=0},
            
            {name="glass-box",          x=300+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",          x=300+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",          x=300+shift+100, y=objectBotttom-50,rotation=0},
            {name="glass-box",          x=300+shift+100, y=objectBotttom-70,rotation=0},
            
            {name="glass-box",          x=340+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",          x=340+shift+100, y=objectBotttom-30,rotation=0},
            {name="wood-bar",           x=380+shift+100, y=objectBotttom-45,rotation=90},
            {name="glass-box",          x=420+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",          x=420+shift+100, y=objectBotttom-30,rotation=0},
            {name="man1",               x=380+shift+100, y=objectBotttom-20,rotation=0},
            
            
            {name="glass-box",          x=340+shift+100, y=objectBotttom-60,rotation=0},
            {name="glass-box",          x=340+shift+100, y=objectBotttom-80,rotation=0},
            {name="wood-bar",           x=380+shift+100, y=objectBotttom-95,rotation=90},
            {name="glass-box",          x=420+shift+100, y=objectBotttom-60,rotation=0},
            {name="glass-box",          x=420+shift+100, y=objectBotttom-80,rotation=0},
            {name="man2",               x=380+shift+100, y=objectBotttom-120,rotation=0},
            
            
        }
    elseif level == 8 then
        data = {
            { name="glass-box",               x=140+shift+100, y=objectBotttom-10,rotation=0},
            { name="glass-box",               x=140+shift+100, y=objectBotttom-30,rotation=0},
            { name="glass-box",               x=140+shift+100, y=objectBotttom-50,rotation=0},
            { name="glass-box",               x=140+shift+100, y=objectBotttom-70,rotation=0},
            
            { name="glass-box",               x=230+shift+100, y=objectBotttom-10,rotation=0},
            { name="glass-box",               x=230+shift+100, y=objectBotttom-30,rotation=0},
            { name="glass-box",               x=230+shift+100, y=objectBotttom-50,rotation=0},
            { name="glass-box",               x=230+shift+100, y=objectBotttom-70,rotation=0},
            
            { name="glass-box",               x=330+shift+100, y=objectBotttom-10,rotation=0},
            { name="glass-box",               x=330+shift+100, y=objectBotttom-30,rotation=0},
            { name="glass-box",               x=330+shift+100, y=objectBotttom-50,rotation=0},
            { name="glass-box",               x=330+shift+100, y=objectBotttom-70,rotation=0},
            
            { name="glass-box",               x=420+shift+100, y=objectBotttom-10,rotation=0},
            { name="glass-box",               x=420+shift+100, y=objectBotttom-30,rotation=0},
            { name="glass-box",               x=420+shift+100, y=objectBotttom-50,rotation=0},
            { name="glass-box",               x=420+shift+100, y=objectBotttom-70,rotation=0},
            
            { name="wood-bar",                x=180+shift+100, y=objectBotttom-85,rotation=90},
            { name="wood-bar",                x=280+shift+100, y=objectBotttom-85,rotation=90},
            { name="wood-bar",                x=380+shift+100, y=objectBotttom-85,rotation=90},
            
            { name="man1",                    x=180+shift+100, y=objectBotttom-20,rotation=0},
            { name="man2",                    x=260+shift+100, y=objectBotttom-20,rotation=0},
            { name="man2",                    x=380+shift+100, y=objectBotttom-20,rotation=0},
            
            
        }
    elseif level == 9 then
        data = {
            {name="terrain-box",          x=230+shift+100, y=objectBotttom-80,rotation=0,terrain=true},
            {name="terrain-box",          x=400+shift+100, y=objectBotttom-80,rotation=0,terrain=true},
            
            {name="com",          x=130+shift+100, y=objectBotttom-15,rotation=0},
            {name="com",          x=130+shift+100, y=objectBotttom-45,rotation=0},
            {name="com",          x=130+shift+100, y=objectBotttom-75,rotation=0},
            {name="com",          x=130+shift+100, y=objectBotttom-105,rotation=0},
            {name="com",          x=130+shift+100, y=objectBotttom-135,rotation=0},
            
            {name="com",          x=160+shift+100, y=objectBotttom-15,rotation=0},
            {name="com",          x=160+shift+100, y=objectBotttom-45,rotation=0},
            {name="com",          x=160+shift+100, y=objectBotttom-75,rotation=0},
            {name="com",          x=160+shift+100, y=objectBotttom-105,rotation=0},
            {name="com",          x=160+shift+100, y=objectBotttom-135,rotation=0},
            
            {name="com",          x=300+shift+100, y=objectBotttom-15,rotation=0},
            {name="com",          x=300+shift+100, y=objectBotttom-45,rotation=0},
            {name="com",          x=300+shift+100, y=objectBotttom-75,rotation=0},
            {name="com",          x=300+shift+100, y=objectBotttom-105,rotation=0},
            {name="com",          x=300+shift+100, y=objectBotttom-135,rotation=0},
            
            {name="com",          x=330+shift+100, y=objectBotttom-15,rotation=0},
            {name="com",          x=330+shift+100, y=objectBotttom-45,rotation=0},
            {name="com",          x=330+shift+100, y=objectBotttom-75,rotation=0},
            {name="com",          x=330+shift+100, y=objectBotttom-105,rotation=0},
            {name="com",          x=330+shift+100, y=objectBotttom-135,rotation=0},
            
            {name="man1",         x=230+shift+100, y=objectBotttom-20,rotation=0},
            {name="man1",         x=230+shift+100, y=objectBotttom-125,rotation=0},
            {name="man1",         x=400+shift+100, y=objectBotttom-20,rotation=0},
            {name="man1",         x=400+shift+100, y=objectBotttom-125,rotation=0},
        }
        
    elseif level == 10 then
        data = {
            {name="terrain-bar",          x=200+shift, y=objectBotttom-60,rotation=0,terrain=true},
            {name="terrain-bar",          x=300+shift, y=objectBotttom-60,rotation=0,terrain=true},
            
            {name="glass-box",          x=290+shift, y=objectBotttom-10,rotation=0},
            {name="glass-box",          x=290+shift, y=objectBotttom-30,rotation=0},
            
            {name="man1",          x=320+shift, y=objectBotttom-20,rotation=0},
            {name="bomb",          x=350+shift, y=objectBotttom-10,rotation=0},
            {name="man2",          x=400+shift, y=objectBotttom-20,rotation=0},
            
            {name="brick-large",          x=280+shift, y=objectBotttom-75,rotation=0},
            {name="brick-large",          x=280+shift, y=objectBotttom-95,rotation=0},
            {name="brick-large",          x=280+shift, y=objectBotttom-115,rotation=0},
            
            {name="terrain-bar",          x=360+shift, y=objectBotttom-115,rotation=0,terrain=true},
            
            {name="ball",          x=320+shift, y=objectBotttom-130,rotation=0},
            {name="ball",          x=350+shift, y=objectBotttom-130,rotation=0},
            {name="ball",          x=380+shift, y=objectBotttom-130,rotation=0},
            
        }
        
    elseif level == 11 then
        data = {
            {name="terrain-a"              ,x=130+shift+70, y=objectBotttom-50,rotation=90,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="terrain-a"              ,x=290+shift+70, y=objectBotttom-50,rotation=90,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="terrain-a"              ,x=450+shift+70, y=objectBotttom-50,rotation=90,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="brick-small"            ,x=415+shift+70, y=objectBotttom-110,rotation=0},
            
            {name="wood-bar"               ,x=210+shift+70, y=objectBotttom-105,rotation=90},
            {name="ball"                    ,x=180+shift+70, y=objectBotttom-120,rotation=0},
            {name="ball"                    ,x=220+shift+70, y=objectBotttom-120,rotation=0},
            
            {name="man2"                    ,x=200+shift+70, y=objectBotttom-20,rotation=0},
            {name="bomb"                    ,x=240+shift+70, y=objectBotttom-10,rotation=0},
            
            {name="glass-box"              ,x=320+shift+70, y=objectBotttom-110,rotation=90},
            {name="wood-bar"               ,x=365+shift+70, y=objectBotttom-125,rotation=90},
            {name="man1"                    ,x=370+shift+70, y=objectBotttom-20,rotation=0},
            {name="ball"                    ,x=345+shift+70, y=objectBotttom-140,rotation=0},
            {name="ball"                    ,x=385+shift+70, y=objectBotttom-140,rotation=0},

            
        }
    elseif level == 12 then
        data = {
            {name="brick-large",   x=180+shift+100, y=objectBotttom-10,rotation=0},
            {name="brick-large",   x=180+shift+100, y=objectBotttom-30,rotation=0},
            {name="brick-large",   x=180+shift+100, y=objectBotttom-50,rotation=0},
            
            {name="ball",          x=170+shift+100, y=objectBotttom-70,rotation=0,density=3},
            {name="ball",          x=195+shift+100, y=objectBotttom-70,rotation=0,density=5},
            {name="terrain-box",   x=180+shift+100, y=objectBotttom-150,rotation=0,terrain=true},
            {name="terrain-triangle-big",   x=230+shift+100, y=objectBotttom-150,rotation=90,terrain=true,shape=shape_terrain_triangle_big},
            
            {name="ball",          x=165+shift+100, y=objectBotttom-185,rotation=0},
            {name="ball",          x=190+shift+100, y=objectBotttom-185,rotation=0},
            
            {name="man1",          x=230+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="terrain-box",   x=280+shift+100, y=objectBotttom-25,rotation=0,terrain=true},
            {name="terrain-box",   x=280+shift+100, y=objectBotttom-75,rotation=0,terrain=true},
            
            {name="bomb",          x=325+shift+100, y=objectBotttom-10,rotation=0},
            {name="man2",          x=355+shift+100, y=objectBotttom-20,rotation=0},
        
        }  
    elseif level == 13 then
        data = {
            {name="brick-large",   x=110+shift+100, y=objectBotttom-25,rotation=90},
            {name="brick-large",   x=110+shift+100, y=objectBotttom-75,rotation=90},
            
            {name="wood-bar",    x=150+shift+100, y=objectBotttom-105,rotation=90},
            {name="brick-large",   x=190+shift+100, y=objectBotttom-25,rotation=90},
            {name="brick-large",   x=190+shift+100, y=objectBotttom-75,rotation=90},
            
            {name="man1",    x=150+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="terrain-bar",  x=220+shift+100, y=objectBotttom-75,rotation=90,terrain=true},
            {name="terrain-bar",  x=280+shift+100, y=objectBotttom-75,rotation=90,terrain=true},
            
            {name="bomb",         x=250+shift+100, y=objectBotttom-10,rotation=0},
            {name="wood-bar",         x=250+shift+100, y=objectBotttom-130,rotation=90},
            {name="ball",         x=250+shift+100, y=objectBotttom-145,rotation=0},
            
            {name="brick-large",   x=300+shift+100, y=objectBotttom-25,rotation=90},
            {name="brick-large",   x=380+shift+100, y=objectBotttom-25,rotation=90},
            {name="wood-bar",   x=340+shift+100, y=objectBotttom-55,rotation=90},
            {name="man1",       x=340+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="brick-large",   x=300+shift+100, y=objectBotttom-85,rotation=90},
            {name="brick-large",   x=380+shift+100, y=objectBotttom-85,rotation=90},
            {name="wood-bar",   x=340+shift+100, y=objectBotttom-115,rotation=90},
            {name="man1",       x=340+shift+100, y=objectBotttom-80,rotation=0},
                 
        }
        
    elseif level == 14 then
        data = {
            {name="terrain-box",  x=125+shift+100, y=objectBotttom-25,rotation=0,terrain=true},
            {name="terrain-bar",  x=165+shift+100, y=objectBotttom-55,rotation=0,terrain=true},
            
            {name="book-shelf",   x=205+shift+100, y=objectBotttom-85,rotation=0},
            {name="wood-bar",   x=245+shift+100, y=objectBotttom-115,rotation=90},
            {name="ball",         x=245+shift+100, y=objectBotttom-135,rotation=0},
            {name="book-shelf",   x=285+shift+100, y=objectBotttom-85,rotation=0},
            
            {name="man1",       x=205+shift+100, y=objectBotttom-20,rotation=0},
            {name="man2",       x=285+shift+100, y=objectBotttom-20,rotation=0},
            {name="bomb",       x=245+shift+100, y=objectBotttom-10,rotation=0},
             
            
            {name="terrain-bar",  x=325+shift+100, y=objectBotttom-55,rotation=0,terrain=true},
            {name="terrain-box",  x=365+shift+100, y=objectBotttom-25,rotation=0,terrain=true},
            
            {name="com",       x=330+shift+100, y=objectBotttom-75,rotation=0},
            {name="com",       x=330+shift+100, y=objectBotttom-105,rotation=0},
            {name="com",       x=330+shift+100, y=objectBotttom-135,rotation=0},
            {name="com",       x=330+shift+100, y=objectBotttom-165,rotation=0},
            {name="ball",      x=330+shift+100, y=objectBotttom-190,rotation=0},
            
            {name="com",       x=360+shift+100, y=objectBotttom-75,rotation=0},
            {name="com",       x=360+shift+100, y=objectBotttom-105,rotation=0},
            {name="com",       x=360+shift+100, y=objectBotttom-135,rotation=0},
            {name="com",       x=360+shift+100, y=objectBotttom-165,rotation=0},
            {name="ball",      x=360+shift+100, y=objectBotttom-190,rotation=0},
            
            {name="man1",       x=415+shift+100, y=objectBotttom-20,rotation=0},
            {name="man2",       x=440+shift+100, y=objectBotttom-20,rotation=0},
        }
    elseif level == 15 then
        data = {
            {name="terrain-box",  x=130+shift+100, y=objectBotttom-25,rotation=0,terrain=true},
            {name="terrain-box",  x=180+shift+100, y=objectBotttom-85,rotation=0,terrain=true},
            {name="terrain-box",  x=155+shift+100, y=objectBotttom-140,rotation=0,terrain=true},
            {name="terrain-box",  x=205+shift+100, y=objectBotttom-140,rotation=0,terrain=true},
            
            
            {name="terrain-box",  x=400+shift+100, y=objectBotttom-25,rotation=0,terrain=true},
            {name="terrain-box",  x=350+shift+100, y=objectBotttom-85,rotation=0,terrain=true},
            {name="terrain-box",  x=325+shift+100, y=objectBotttom-140,rotation=0,terrain=true},
            {name="terrain-box",  x=375+shift+100, y=objectBotttom-140,rotation=0,terrain=true},
            
            {name="bomb",         x=265+shift+100, y=objectBotttom-10,rotation=0},
            {name="man1",         x=230+shift+100, y=objectBotttom-10,rotation=0},
            {name="man1",         x=195+shift+100, y=objectBotttom-10,rotation=0},
            
            {name="man2",         x=300+shift+100, y=objectBotttom-10,rotation=0},
            {name="man2",         x=335+shift+100, y=objectBotttom-10,rotation=0},
            
            {name="ball",         x=205+shift+100, y=objectBotttom-175,rotation=0},
            {name="ball",         x=180+shift+100, y=objectBotttom-175,rotation=0},
            
            {name="ball",         x=325+shift+100, y=objectBotttom-175,rotation=0},
            {name="ball",         x=350+shift+100, y=objectBotttom-175,rotation=0},
        }
    elseif level == 16 then
        data = {
            {name="terrain-triangle-big",  x=115+shift+100, y=objectBotttom-25,rotation=0,terrain=true,shape=shape_terrain_triangle_big},
            {name="terrain-triangle-big",  x=195+shift+100, y=objectBotttom-25,rotation=0,terrain=true,shape=shape_terrain_triangle_big},
            
            {name="wood-bar",          x=155+shift+100, y=objectBotttom-55,rotation=90},
            {name="man1",              x=155+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="glass-box",         x=110+shift+100, y=objectBotttom-70,rotation=90},
            {name="glass-box",         x=135+shift+100, y=objectBotttom-70,rotation=90},
            {name="glass-box",         x=165+shift+100, y=objectBotttom-70,rotation=90},
            {name="glass-box",         x=185+shift+100, y=objectBotttom-70,rotation=90},
            
            
            {name="bomb",              x=240+shift+100, y=objectBotttom-10,rotation=0},
            {name="brick-large",       x=280+shift+100, y=objectBotttom-10,rotation=0},
            {name="brick-large",       x=280+shift+100, y=objectBotttom-30,rotation=0},
            {name="brick-large",       x=280+shift+100, y=objectBotttom-50,rotation=0},
            
            {name="terrain-box",       x=280+shift+100, y=objectBotttom-90,rotation=0,terrain=true},
            
            {name="brick-large",       x=280+shift+100, y=objectBotttom-125,rotation=0},
            {name="brick-large",       x=280+shift+100, y=objectBotttom-145,rotation=0},
            {name="brick-large",       x=280+shift+100, y=objectBotttom-165,rotation=0},
            
            {name="brick-large",       x=330+shift+100, y=objectBotttom-10,rotation=0},
            {name="brick-large",       x=330+shift+100, y=objectBotttom-30,rotation=0},
            {name="brick-large",       x=330+shift+100, y=objectBotttom-50,rotation=0},
            {name="man1",              x=330+shift+100, y=objectBotttom-80,rotation=0},

            
            {name="brick-large",       x=380+shift+100, y=objectBotttom-10,rotation=0},
            {name="brick-large",       x=380+shift+100, y=objectBotttom-30,rotation=0},
            {name="man1",              x=380+shift+100, y=objectBotttom-60,rotation=0},
            
            {name="man1",              x=420+shift+100, y=objectBotttom-20,rotation=0},
            
        }  
        
    elseif level == 17 then
        data = {
            { name="terrain-a",         x=250+shift+50, y=objectBotttom-50,rotation=0,terrain = true,shape = shape_terrain_a},
            { name="man1",               x=290+shift+50, y=objectBotttom-20,rotation=0},
            { name="man1",               x=260+shift+50, y=objectBotttom-120,rotation=0},
            { name="glass-box",          x=290+shift+50, y=objectBotttom-110,rotation=0},

            { name="ball",          x=290+shift+50, y=objectBotttom-130,rotation=0},
            { name="t-d",          x=345+shift+50, y=objectBotttom-10,rotation=0, shape = shape_t_d},
            { name="brick-small",          x=370+shift+50, y=objectBotttom-10,rotation=0},
            { name="brick-small",          x=370+shift+50, y=objectBotttom-30,rotation=0},
            { name="brick-small",          x=370+shift+50, y=objectBotttom-50,rotation=0},
            { name="brick-small",          x=370+shift+50, y=objectBotttom-70,rotation=0},
            { name="man2",          x=370+shift+50, y=objectBotttom-100,rotation=0},

            { name="bomb",               x=310+shift+50, y=objectBotttom-20,rotation=0},
  
        }   
        
    elseif level == 18 then
        data = {
            {name="terrain-b" ,terrain = "terrain" ,x=190+shift+100, y=objectBotttom-20,rotation=0,terrain = true ,shape=shape_terrain_b}, -- this has to be the first one to come if there is a terrain
            { name="book-shelf",                    x=150+shift+100, y=objectBotttom-55,rotation=0},
            { name="small-wooden-box",               x=150+shift+100, y=objectBotttom-100,rotation=0},
            { name="small-wooden-box",               x=150+shift+100, y=objectBotttom-130,rotation=0},
            { name="com",                           x=150+shift+100, y=objectBotttom-160,rotation=0},
            { name="man1",                          x=220+shift+100, y=objectBotttom-50,rotation=0},
            
            {name="terrain-a"                   ,x=340+shift+100, y=objectBotttom-50,rotation=0,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="glass-box"                   ,x=300+shift+100, y=objectBotttom-110,rotation=0},
            {name="glass-box"                   ,x=300+shift+100, y=objectBotttom-130,rotation=0},
            {name="glass-box"                   ,x=300+shift+100, y=objectBotttom-150,rotation=0},
            {name="glass-box"                   ,x=300+shift+100, y=objectBotttom-170,rotation=0},
            
            {name="glass-box"                   ,x=380+shift+100, y=objectBotttom-110,rotation=0},
            {name="glass-box"                   ,x=380+shift+100, y=objectBotttom-130,rotation=0},
            {name="glass-box"                   ,x=380+shift+100, y=objectBotttom-150,rotation=0},
            {name="glass-box"                   ,x=380+shift+100, y=objectBotttom-170,rotation=0},
            
            {name="wood-bar"                   ,x=340+shift+100, y=objectBotttom-185,rotation=90},
            
            {name="ball"                       ,x=300+shift+100, y=objectBotttom-200,rotation=0},
            {name="ball"                       ,x=325+shift+100, y=objectBotttom-200,rotation=0},
            {name="ball"                       ,x=350+shift+100, y=objectBotttom-200,rotation=0},
            {name="ball"                       ,x=380+shift+100, y=objectBotttom-200,rotation=0},
            
            {name="man2"                       ,x=370+shift+100, y=objectBotttom-20,rotation=0},
            {name="bomb"                       ,x=400+shift+100, y=objectBotttom-10,rotation=0},
            {name="man2"                       ,x=440+shift+100, y=objectBotttom-20,rotation=0},

        }
        
        
    elseif level == 19 then
        data = {
            {name="terrain-a"                   ,x=150+shift+100, y=objectBotttom-50,rotation=0,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="terrain-a"                   ,x=150+shift+100, y=objectBotttom-150,rotation=0,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="terrain-a"                   ,x=295+shift+100, y=objectBotttom-50,rotation=0,terrain = true,shape = shape_terrain_a}, -- this has to be the first one to come if there is a terrain
            {name="ball"                        ,x=190+shift+100, y=objectBotttom-210,rotation=0, density=4},
            {name="ball"                        ,x=165+shift+100, y=objectBotttom-210,rotation=0, density=4},
            
            {name="man2"                       ,x=195+shift+100, y=objectBotttom-20,rotation=0},
            {name="bomb"                       ,x=220+shift+100, y=objectBotttom-10,rotation=0},
            
            {name="brick-large",x=320+shift+100, y=objectBotttom-110,rotation=0},
            {name="brick-large",x=320+shift+100, y=objectBotttom-130,rotation=0},
            {name="ball",       x=320+shift+100, y=objectBotttom-155,rotation=0},
            {name="man1",       x=350+shift+100, y=objectBotttom-20,rotation=0},
            {name="bomb",       x=385+shift+100, y=objectBotttom-10,rotation=0},
            
        }
        
        
    elseif level == 20 then
        data = {
            {name="terrain-box",          x=175+shift+100, y=objectBotttom-25,rotation=0,terrain=true},
            {name="terrain-box",          x=175+shift+100, y=objectBotttom-75,rotation=0,terrain=true},
            {name="terrain-box",          x=175+shift+100, y=objectBotttom-125,rotation=0,terrain=true},
            {name="terrain-bar",          x=250+shift+100, y=objectBotttom-100,rotation=0,terrain=true},
            
            {name="ball",          x=260+shift+100, y=objectBotttom-115,rotation=0},
            {name="ball",          x=285+shift+100, y=objectBotttom-115,rotation=0},
            
            {name="man1",          x=220+shift+100, y=objectBotttom-20,rotation=0},
            {name="bomb",          x=245+shift+100, y=objectBotttom-10,rotation=0},
            {name="man2",          x=280+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="terrain-triangle-big",          x=330+shift+100, y=objectBotttom-25,rotation=0,terrain=true, shape=shape_terrain_triangle_big},
            
            {name="glass-box",          x=370+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",          x=370+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",          x=370+shift+100, y=objectBotttom-50,rotation=0},
            {name="man2",          x=370+shift+100, y=objectBotttom-80,rotation=0},
        }
        
    elseif level == 21 then
        data = {
            {name="brick-large",          x= 120+shift+100, y=objectBotttom-25,rotation=90},
            {name="brick-large",          x=190+shift+100, y=objectBotttom-25,rotation=90},
            {name="man1",                 x=150+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="terrain-triangle-big", x=125+shift+100, y=objectBotttom-75,rotation=0,terrain=true,shape=shape_terrain_triangle_big},
            {name="terrain-triangle-big", x=175+shift+100, y=objectBotttom-75,rotation=0,terrain=true,shape=shape_terrain_triangle_big},
            
            {name="glass-box",            x=220+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",            x=220+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",            x=220+shift+100, y=objectBotttom-50,rotation=0},
            
            {name="glass-box",            x=240+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",            x=240+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",            x=240+shift+100, y=objectBotttom-50,rotation=0},
            
            {name="wood-bar",             x=260+shift+100, y=objectBotttom-65,rotation=90},
            
            {name="bomb",                 x=280+shift+100, y=objectBotttom-80,rotation=0},
            
            {name="glass-box",            x=300+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",            x=300+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",            x=300+shift+100, y=objectBotttom-50,rotation=0},
            
            {name="glass-box",            x=220+shift+100, y=objectBotttom-80,rotation=0},
            {name="glass-box",            x=220+shift+100, y=objectBotttom-100,rotation=0},
            {name="glass-box",            x=220+shift+100, y=objectBotttom-120,rotation=0},
            
            {name="glass-box",            x=240+shift+100, y=objectBotttom-80,rotation=0},
            {name="glass-box",            x=240+shift+100, y=objectBotttom-100,rotation=0},
            {name="glass-box",            x=240+shift+100, y=objectBotttom-120,rotation=0},
            
            {name="terrain-triangle-big", x=255+shift+100, y=objectBotttom-155,rotation=0,terrain=true,shape=shape_terrain_triangle_big},
            {name="terrain-triangle-big", x=305+shift+100, y=objectBotttom-155,rotation=0,terrain=true,shape=shape_terrain_triangle_big},
            
            {name="man1",                 x=270+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="glass-box",            x=340+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",            x=340+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",            x=340+shift+100, y=objectBotttom-50,rotation=0},
            {name="glass-box",            x=340+shift+100, y=objectBotttom-70,rotation=0},
            {name="glass-box",            x=340+shift+100, y=objectBotttom-90,rotation=0},
            {name="glass-box",            x=340+shift+100, y=objectBotttom-110,rotation=0},
            
            {name="glass-box",            x=360+shift+100, y=objectBotttom-10,rotation=0},
            {name="glass-box",            x=360+shift+100, y=objectBotttom-30,rotation=0},
            {name="glass-box",            x=360+shift+100, y=objectBotttom-50,rotation=0},
            {name="glass-box",            x=360+shift+100, y=objectBotttom-70,rotation=0},
            {name="glass-box",            x=360+shift+100, y=objectBotttom-90,rotation=0},
            {name="glass-box",            x=360+shift+100, y=objectBotttom-110,rotation=0},
            
            {name="man2",                 x=350+shift+100, y=objectBotttom-130,rotation=0},
        }
   elseif level == 22 then
        data = {
            {name="com",                 x=130+shift+100, y=objectBotttom-15,rotation=0},
            {name="com",                 x=130+shift+100, y=objectBotttom-45,rotation=0},
            {name="com",                 x=130+shift+100, y=objectBotttom-75,rotation=0},
            {name="man1",                x=220+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="terrain-bar",         x=165+shift+100, y=objectBotttom-95,rotation=0,terrain=true},
            {name="glass-box",           x=125+shift+100, y=objectBotttom-110,rotation=0},
            {name="glass-box",           x=125+shift+100, y=objectBotttom-130,rotation=0},
            {name="glass-box",           x=125+shift+100, y=objectBotttom-150,rotation=0},
            {name="terrain-bar",         x=165+shift+100, y=objectBotttom-165,rotation=0,terrain=true},
            {name="ball",                x=155+shift+100, y=objectBotttom-110,rotation=0},
            {name="ball",                x=180+shift+100, y=objectBotttom-110,rotation=0},
            
            {name="terrain-bar",         x=325+shift+100, y=objectBotttom-150,rotation=0,terrain=true},
            {name="terrain-bar",         x=325+shift+100, y=objectBotttom-80,rotation=0,terrain=true},
            
            {name="bomb",                x=315+shift+100, y=objectBotttom-105,rotation=0},
            {name="man1",                x=285+shift+100, y=objectBotttom-95, rotation=0},
            {name="man2",                x=345+shift+100, y=objectBotttom-105,rotation=0},
        }
    elseif level == 23 then
        data = {
            {name="brick-large",          x=60+shift+100, y=objectBotttom-25,rotation=90},
            {name="brick-large",          x=140+shift+100, y=objectBotttom-25,rotation=90},
            {name="man1",                 x=100+shift+100, y=objectBotttom-20,rotation=0},
            {name="wood-bar",             x=100+shift+100, y=objectBotttom-55,rotation=90},
            {name="man2",                 x=100+shift+100, y=objectBotttom-80,rotation=0},
            
            {name="terrain-bar",          x=215+shift+100, y=objectBotttom-25,rotation=-30,terrain=true},
            {name="terrain-bar",          x=366+shift+100, y=objectBotttom-95,rotation=-30,terrain=true},
            
            {name="terrain-box",          x=466+shift+100, y=objectBotttom-110,rotation=0, terrain=true},
            {name="terrain-box",          x=516+shift+100, y=objectBotttom-110,rotation=0, terrain=true},
            
            {name="ball",                 x=460+shift+100, y=objectBotttom-145,rotation=0},
            {name="ball",                 x=485+shift+100, y=objectBotttom-145,rotation=0},
            {name="ball",                 x=510+shift+100, y=objectBotttom-145,rotation=0},
            {name="ball",                 x=525+shift+100, y=objectBotttom-145,rotation=0},
            
            {name="bomb",                 x=430+shift+100, y=objectBotttom-10,rotation=0},
            
            {name="bomb",                 x=325+shift+100, y=objectBotttom-10,rotation=0},
            {name="man1",                 x=345+shift+100, y=objectBotttom-20,rotation=0},
            {name="man2",                 x=405+shift+100, y=objectBotttom-20,rotation=0},
        }
    elseif level == 24 then
        data = {
            {name="terrain-bar",          x=130+shift+100, y=objectBotttom-43,rotation=60,terrain=true},
            {name="terrain-bar",          x=240+shift+100, y=objectBotttom-43,rotation=60,terrain=true},
            {name="terrain-bar",          x=350+shift+100, y=objectBotttom-43,rotation=60,terrain=true},
            
            
            {name="bomb",                 x=175+shift+100, y=objectBotttom-10,rotation=0},
            {name="man1",                 x=205+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="bomb",                 x=285+shift+100, y=objectBotttom-10,rotation=0},
            {name="man1",                 x=315+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="bomb",                 x=395+shift+100, y=objectBotttom-10,rotation=0},
            {name="man1",                 x=425+shift+100, y=objectBotttom-20,rotation=0},
            
            {name="terrain-bar",          x=220+shift+100, y=objectBotttom-170,rotation=0,terrain=true},
            {name="glass-box",            x=180+shift+100, y=objectBotttom-185,rotation=0},
            {name="glass-box",            x=180+shift+100, y=objectBotttom-205,rotation=0},
            {name="glass-box",            x=180+shift+100, y=objectBotttom-225,rotation=0},
            
            {name="man1",                 x=230+shift+100, y=objectBotttom-195,rotation=0},
            
            
        }
    end
    
    
    
    
    return data
end
M.getLevelData = getLevelData

return M



