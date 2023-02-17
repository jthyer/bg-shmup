loadFunc = {}
updateFunc = {}

require("src.entity.popcorn")
require("src.entity.bullet")
require("src.entity.turret")
require("src.entity.player")

local ENTITYDATA = require("src.entityData")
local entities = {}
local iterator = 1
local timer = 0
local nextEntity = ENTITYDATA[iterator]

local player_x, player_y

function setPlayerPos(x,y)
  player_x = x
  player_y = y
end

function getPlayerPos()
  return player_x, player_y
end

function addBullet(e_index,e_x,e_y,target_x,target_y)
  local e = { index = e_index, x = e_x, y = e_y, 
    target_x = player_x, target_y = player_y } 
  loadFunc[e.index](e)
  table.insert(entities,e)
end

function addEntity(e_index,e_x,e_y)
  local e = { index = e_index, x = e_x, y = e_y }
  loadFunc[e.index](e)
  table.insert(entities,e)
end

function loadEntities()

end

function updateEntities(dt)
  -- add any new enemy spawns
  timer = timer + dt
  if nextEntity[1] < timer then
    addEntity(nextEntity[2],nextEntity[3],nextEntity[4])
    iterator = iterator + 1
    if iterator <= #ENTITYDATA then
      nextEntity = ENTITYDATA[iterator]
    else
      nextEntity = {100000,nil}
    end
    timer = 0
  end
  
  -- update all existing entities
  for i, v in ipairs(entities) do
    if updateFunc[v.index] ~= nil and 
      not updateFunc[v.index](v,dt) then
      table.remove(entities, i)
    end
  end
end

function drawEntities()
  for i, v in ipairs(entities) do
    if v.class == "enemy" then
      love.graphics.draw(v.image,v.x,v.y,0,1.2,1.2)
    end
  end
  for i, v in ipairs(entities) do
    if v.class == "player" then
      love.graphics.draw(v.image,v.x,v.y,0,1.2,1.2)
      break
    end
  end
  for i, v in ipairs(entities) do
    if v.class == "bullet" then
      local offset = 1.2*v.width/2
      love.graphics.draw(v.image,v.x+offset,v.y+offset,v.rotation,1.2,1.2,offset,offset)
    end
  end
end