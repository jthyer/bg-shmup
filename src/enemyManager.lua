local ENEMYTYPEDATA      = require("src.enemyTypeData")
local ENEMYPLACEMENTDATA = require("src.enemyPlacementData")
local enemyBehavior      = require("src.enemyBehavior")

local enemies = {}
local enemyItr = 1
local enemyTimer = 0
local enemyNext = ENEMYPLACEMENTDATA[enemyItr]

function createEnemy(index,x,y)
  local e = {}
  
  e.sprite = ENEMYTYPEDATA[index][1][1]
  e.behavior = ENEMYTYPEDATA[index][3]
  e.timer = 0
  e.behaviorItr = 1
  e.x, e.y = x, y
  e.hspeed, e.vspeed = ENEMYTYPEDATA[index][2][1], ENEMYTYPEDATA[index][2][2]
  e.haccel, e.vaccel = ENEMYTYPEDATA[index][2][3], ENEMYTYPEDATA[index][2][4]
  if #e.behavior > 0 then
    e.active = true
  else
    e.active = false
  end
  
  table.insert(enemies,e)
end

function updateEnemy(e, dt)
  e.timer = e.timer + dt
  
  -- make any changes to behavior
  if e.active and e.timer > e.behavior[e.behaviorItr][1] then
    local behaviorIndex = e.behavior[e.behaviorItr][2]
    
    enemyBehavior[behaviorIndex](e)

    e.timer = 0
    e.behaviorItr = e.behaviorItr + 1
    if e.behaviorItr > #e.behavior then
      e.behaviorItr = 1
    end
  end

  -- update speed and position
  e.hspeed = e.hspeed + (e.haccel * dt)
  e.vspeed = e.vspeed + (e.vaccel * dt)
  e.x = e.x + (e.hspeed * dt)
  e.y = e.y + (e.vspeed * dt)
end

function updateEnemies(dt)
  -- add any new enemy spawns
  enemyTimer = enemyTimer + dt
  if enemyNext[1] < enemyTimer then
    createEnemy(enemyNext[2],enemyNext[3],enemyNext[4])
    
    enemyItr = enemyItr + 1
    if enemyItr <= #ENEMYPLACEMENTDATA then
      enemyNext = ENEMYPLACEMENTDATA[enemyItr]
    else
      enemyNext = {100000,nil}
    end
    enemyTimer = 0
  end  
  
  -- update all existing enemies
  for i, v in ipairs(enemies) do
    if v.y > SCREENHEIGHT then
      table.remove(enemies, i)
    else
      updateEnemy(v,dt)
    end
  end
end

function drawEnemies()
  for i, v in ipairs(enemies) do
    love.graphics.draw(v.sprite,v.x,v.y,0,1.2,1.2)
  end
end