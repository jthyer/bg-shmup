-- removing enemies from table mid-for loop skips an enemy, fix
-- aimed bullets fired up don't get removed from game, fix

local ENEMYTYPEDATA      = require("src.enemyTypeData")
local ENEMYPLACEMENTDATA = require("src.enemyPlacementData")
local enemyBehavior      = require("src.enemyBehavior")

local enemies, enemyItr, enemyTimer, enemyNext 

function checkPlayerCollision()
  local player_x, player_y, player_w, player_h = getPlayerMask()
  
  for i,v in ipairs(enemies) do
    if checkCollision(player_x,player_y,player_w,player_h,
      v.x+v.mask,v.y+v.mask,v.w-(v.mask*2),v.h-(v.mask*2)) then
      killPlayer()
    end

  end
end

function loadEnemies()
  enemies = {}
  enemyItr = 1
  enemyTimer = 0
  enemyNext = ENEMYPLACEMENTDATA[enemyItr]
end

function createEnemy(index,x,y)
  local e = {}
  e.index = index
  e.sprite = ENEMYTYPEDATA[index][1][1]
  e.color = {1, 0, 0}
  e.behavior = ENEMYTYPEDATA[index][3]
  e.health = ENEMYTYPEDATA[index][1][5]
  e.timer = 0
  e.behaviorItr = 1
  e.x, e.y = x, y
  e.w, e.h = ENEMYTYPEDATA[index][1][2],ENEMYTYPEDATA[index][1][3]
  e.mask = ENEMYTYPEDATA[index][1][4]
  e.hspeed, e.vspeed = ENEMYTYPEDATA[index][2][1], ENEMYTYPEDATA[index][2][2]
  e.haccel, e.vaccel = ENEMYTYPEDATA[index][2][3], ENEMYTYPEDATA[index][2][4]
  if #e.behavior > 0 then
    e.active = true
  else
    e.active = false
  end
  
  table.insert(enemies,e)
  return e
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
  
  checkPlayerCollision()
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
      enemyNext = {1000000,nil}
    end
    enemyTimer = 0
  end  
  
  -- update all existing enemies
  for i, v in ipairs(enemies) do
    if v.y > SCREENHEIGHT then
      table.remove(enemies, i)
    elseif v.health ~= -1 and 
      checkBulletCollision(v.x+v.mask,v.y+v.mask,v.w-(v.mask*2),v.h-(v.mask*2)) then
      v.health = v.health - 1
      if v.health == 0 then
        table.remove(enemies, i)
      end
    else
      updateEnemy(v,dt)
    end
  end
end

function getEnemyCount()
  return #enemies
end

function drawEnemies()  
  for i, v in ipairs(enemies) do
    love.graphics.setColor(v.color)
    love.graphics.rectangle("fill",v.x,v.y,v.w,v.h)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",v.x+v.mask,v.y+v.mask,
      v.w-(2*v.mask),v.h-(2*v.mask))
    --love.graphics.draw(v.sprite,v.x,v.y,0,1.2,1.2)
  end
end