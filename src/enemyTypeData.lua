-- each enemy type has three tables: 
--   * image data: sprite, width, height, mask (static)
--   * initial movement values: hspeed, vspeed, haccel, vaccel
--       (can be changed by behaviors)
--   * behaviors: made up subtotals for each behavior:
--       timer, behavior index, behavior arguments
--       an enemy can have an empty table with no behaviors

local enemyTypeData = {}


enemyTypeData["aimedBullet"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 32, 32, 16 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 300  } ,
    { 0, "break" } ,
  }
}

enemyTypeData["sine"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 32, 32, 16 } ,
  { 200, 150, -200, 0 } ,
  { 
    { 2, "setAccel", 200, 0 } ,
    { 0, "fire", "aimedBullet" } ,
    { 2, "setAccel", -200, 0 } ,
  }
}
enemyTypeData["homing"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 32, 32, 16 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 200  } ,
    { 0, "break" } ,
  }
}

enemyTypeData["looper"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 32, 32, 16 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "setSpeed",  200, 100 } ,
    { 0, "setAccel", -100, 0} ,
    { 0, "break" } ,
  }
}

return enemyTypeData