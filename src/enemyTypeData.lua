-- each enemy type has three tables: 
--   * image data: sprite, width, height, mask (static)
--   * initial movement values: hspeed, vspeed, haccel, vaccel
--       (can be changed by behaviors)
--   * behaviors: made up subtotals for each behavior:
--       timer, behavior index, behavior arguments
--       an enemy can have an empty table with no behaviors

local enemyTypeData = {}

enemyTypeData["down"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 48, 48, 16, 1} ,
  { 0, 250, 0, 0 } ,
  {
    { 0, "break" } ,
  }
}

enemyTypeData["left"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 48, 48, 16, 1} ,
  { -250, 0, 0, 0 } ,
  {
    { 0, "break" } ,
  }
}

enemyTypeData["staticBullet"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 16, 16, 4, -1} ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "break" } ,
  }
}

enemyTypeData["aimedBullet"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 16, 16, 4, -1} ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 350, 0 } ,
    { 0, "break" } ,
  }
}

enemyTypeData["aimedBulletOffsetL"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 16, 16, 4, -1 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 350, -0.3} ,
    { 0, "break" } ,
  }
}

enemyTypeData["aimedBulletOffsetR"] = {
  { love.graphics.newImage("assets/sprites/bullet.png"), 16, 16, 4, -1 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 350, 0.3 } ,
    { 0, "break" } ,
  }
}

enemyTypeData["sine"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 1 } ,
  { 200, 150, -200, 0 } ,
  { 
    { 2, "setAccel", 200, 0 } ,
    { 0, "fire", "aimedBullet" } ,
    { 2, "setAccel", -200, 0 } ,
  }
}

enemyTypeData["dartR"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 1 } ,
  { 0, 250, 0, 0 } ,
  { 
    { 0.5, "setAccel", 400, 0 } ,
    { 0.75, "setAccel", -400, 0 } ,    
    { 0.75, "setAccel", 0, 0 } , 
    { 0, "break" }
  }
}

enemyTypeData["dartL"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16 , 1} ,
  { 0, 250, 0, 0 } ,
  { 
    { 0.5, "setAccel", -400, 0 } ,
    { 0.75, "setAccel", 400, 0 } ,    
    { 0.75, "setAccel", 0, 0 } , 
    { 0, "break" }
  }
}

enemyTypeData["dartRBullet"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 1 } ,
  { 0, 250, 0, 0 } ,
  { 
    { 0.5, "setAccel", 400, 0 } ,
    { 0.5, "fire", "aimedBullet" } ,
    { 0.25, "setAccel", -400, 0 } ,    
    { 0.75, "setAccel", 0, 0 } , 
    { 0, "break" }
  }
}

enemyTypeData["dartLBullet"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 1 } ,
  { 0, 250, 0, 0 } ,
  { 
    { 0.5, "setAccel", -400, 0 } ,
    { 0.5, "fire", "aimedBullet" } ,
    { 0.25, "setAccel", 400, 0 } ,    
    { 0.75, "setAccel", 0, 0 } , 
    { 0, "break" }
  }
}

enemyTypeData["missileL"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 16, 16, 4, -1 } ,
  { -100, 550, 0, 0 } ,
  { 
    { 0, "break" }
  }
}

enemyTypeData["missileStraight"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 16, 16, 4, -1 } ,
  { 0, 550, 0, 0 } ,
  { 
    { 0, "break" }
  }
}

enemyTypeData["missileR"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 16, 16, 4, -1 } ,
  { 100, 550, 0, 0 } ,
  { 
    { 0, "break" }
  }
}

enemyTypeData["spinner"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 10 } ,
  { 0, 100, 0, 0 } ,
  { 
    { 1, "fire", "staticBullet", {350*.71,350*.71,0,0} } ,
    { 0, "fire", "staticBullet", {-350*.71,350*.71,0,0} } ,
    { 0, "fire", "staticBullet", {350*.71,-350*.71,0,0} } ,
    { 0, "fire", "staticBullet", {-350*.71,-350*.71,0,0} } ,
    { 1, "fire", "staticBullet", {350,0,0,0} } ,
    { 0, "fire", "staticBullet", {-350,0,0,0} } ,
    { 0, "fire", "staticBullet", {0,350,0,0} } ,
    { 0, "fire", "staticBullet", {0,-350,0,0} } ,
  }
}

enemyTypeData["turret"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 3 } ,
  { 0, 200, 0, 0 } ,
  { 
    { 0.75, "setAccel", 0, -360 } ,
    { 0.5, "setAccel", 0, 0} ,
    { 0.5, "fire", "aimedBullet"} ,
    { 0.5, "fire", "aimedBullet"} ,
    { 0.5, "fire", "aimedBullet"} ,
    { 0.5, "setAccel", 0, 400} ,
    { 0.75, "setAccel", 0, 0} ,
    { 0, "break" } ,
  }
}

enemyTypeData["spreader"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 1 } ,
  { 0, 200, 0, 0 } ,
  { 
    { 1, "fire", "staticBullet", {350*.71,350*.71,0,0} } ,
    { 0, "fire", "staticBullet", {0,350,0,0} } ,
    { 0, "fire", "staticBullet", {-350*.71,350*.71,0,0} } ,
    { 0, "break" } ,
  }
}


enemyTypeData["homing"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 10 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "moveTowardsPlayer", 100, 0 } ,

  }
}

enemyTypeData["boss"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 15 } ,
  { -100, 0, 0, 0 } ,
  { 
    { 1, "fire", "aimedBullet", 350 } ,
    { 0, "fire", "aimedBulletOffsetL", 350 } ,
    { 0, "fire", "aimedBulletOffsetR", 350 } ,
    { 0.5, "fire", "aimedBullet", 350 } ,
    { 0, "fire", "aimedBulletOffsetL", 350 } ,
    { 0, "fire", "aimedBulletOffsetR", 350 } ,
    { 0.5, "fire", "aimedBullet", 350 } ,
    { 0, "fire", "aimedBulletOffsetL", 350 } ,
    { 0, "fire", "aimedBulletOffsetR", 350 } ,    
    { 2, "setSpeed", 100, 0 } ,    
    { 1, "fire", "aimedBullet", 350 } ,
    { 0, "fire", "aimedBulletOffsetL", 350 } ,
    { 0, "fire", "aimedBulletOffsetR", 350 } ,
    { 0.5, "fire", "aimedBullet", 350 } ,
    { 0, "fire", "aimedBulletOffsetL", 350 } ,
    { 0, "fire", "aimedBulletOffsetR", 350 } ,
    { 0.5, "fire", "aimedBullet", 350 } ,
    { 0, "fire", "aimedBulletOffsetL", 350 } ,
    { 0, "fire", "aimedBulletOffsetR", 350 } ,  
    --[[{ 1, "fire", "bullet", {350*.71,350*.71,0,0} } ,
    { 0, "fire", "bullet", {0,350,0,0} } ,
    { 0, "fire", "bullet", {-350*.71,350*.71,0,0} } ,
    { 0.5, "fire", "bullet", {350*.71,350*.71,0,0} } ,
    { 0, "fire", "bullet", {0,350,0,0} } ,
    { 0, "fire", "bullet", {-350*.71,350*.71,0,0} } ,
    { 0.5, "fire", "bullet", {350*.71,350*.71,0,0} } ,
    { 0, "fire", "bullet", {0,350,0,0} } ,
    { 0, "fire", "bullet", {-350*.71,350*.71,0,0} } ,]]
    { 2, "setSpeed", -100, 0 } ,
  }
}

enemyTypeData["arc"] = {
  { love.graphics.newImage("assets/sprites/popcorn.png"), 48, 48, 16, 1 } ,
  { 0, 0, 0, 0 } ,
  { 
    { 0, "setSpeed",  400, 100 } ,
    { 0, "setAccel", -200, 0} ,
    { 0, "break" } ,
  }
}

return enemyTypeData