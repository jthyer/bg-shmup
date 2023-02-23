
-- class = enemy type name
-- image = sprite, width, height, mask. We'll worry about rotation and animation later.
-- behaviors (the meat of it): a timer, a behavior name, a table of behaviors
--   setMove - changes movement variables
--     hspeed, vspeed, haccel, vaccel. this should be enough to do a loop de loop
--   createEnemy (making bullets), we'll do this one later

local enemyTypeData = {}
  
enemyTypeData["sine"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 32, 32, 16,
    200, 100, -200, 0 } ,
  { 
    { 2, "setAccel", 200, 0 } ,
    { 2, "setAccel", -200, 0 } ,
  }
}

enemyTypeData["looper"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 32, 32, 16,
    -200, 100, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 200  } ,
    --{ 10, "setSpeed", -200, 0 } ,
  }
}

return enemyTypeData