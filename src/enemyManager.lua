local ENEMYTYPEDATA = require("src.enemyTypeData")

-- an enemy contains its behavior table, timer, its behavior iterator, 
-- its x and y, its hspeed, its vspeed
local loopEnemy = {}

loopEnemy.sprite = ENEMYTYPEDATA["looper"][1][1]
loopEnemy.behavior = ENEMYTYPEDATA["looper"][2]
loopEnemy.timer = 0
loopEnemy.behaviorItr = 1
loopEnemy.x = 200 
loopEnemy.y = 100
loopEnemy.hspeed = ENEMYTYPEDATA["looper"][1][5]
loopEnemy.vspeed = ENEMYTYPEDATA["looper"][1][6]
loopEnemy.haccel = ENEMYTYPEDATA["looper"][1][7]
loopEnemy.vaccel = ENEMYTYPEDATA["looper"][1][8]

function updateEnemies(dt)
  loopEnemy.timer = loopEnemy.timer + dt
  if loopEnemy.timer > loopEnemy.behavior[loopEnemy.behaviorItr][1] then
    -- behavior definitions, maybe pull into their own functions
    if loopEnemy.behavior[loopEnemy.behaviorItr][2] == "setAccel" then
      loopEnemy.haccel = loopEnemy.behavior[loopEnemy.behaviorItr][3]
      loopEnemy.vaccel = loopEnemy.behavior[loopEnemy.behaviorItr][4]
    elseif loopEnemy.behavior[loopEnemy.behaviorItr][2] == "setSpeed" then
      loopEnemy.hspeed = loopEnemy.behavior[loopEnemy.behaviorItr][3]
      loopEnemy.vspeed = loopEnemy.behavior[loopEnemy.behaviorItr][4]    
    elseif loopEnemy.behavior[loopEnemy.behaviorItr][2] == "moveTowardsPlayer" then
      local target_x, target_y = getPlayerPos()
      local angle = math.atan2((target_y - loopEnemy.y), (target_x - loopEnemy.x))
  
      -- loopEnemy.rotation = angle + 1.571
  
      loopEnemy.hspeed = 200 * math.cos(angle)
      loopEnemy.vspeed = 200 * math.sin(angle)
    end
    
    -- iterate to next behavior
    loopEnemy.timer = 0
    loopEnemy.behaviorItr = loopEnemy.behaviorItr + 1
    if loopEnemy.behaviorItr > #loopEnemy.behavior then
      loopEnemy.behaviorItr = 1
    end
  end

  loopEnemy.hspeed = loopEnemy.hspeed + (loopEnemy.haccel * dt)
  loopEnemy.vspeed = loopEnemy.vspeed + (loopEnemy.vaccel * dt)
  loopEnemy.x = loopEnemy.x + (loopEnemy.hspeed * dt)
  loopEnemy.y = loopEnemy.y + (loopEnemy.vspeed * dt)
end

function drawEnemies()
  love.graphics.draw(loopEnemy.sprite,loopEnemy.x,loopEnemy.y,0,1.2,1.2)  
end