loadFunc = {}
updateFunc = {}

require("src.entity.popcorn")
require("src.entity.player")

local ENTITYDATA = require("src.scene.entityData")
local entities = {}
local iterator = 1
local timer = 0
local nextEntity = ENTITYDATA[iterator]

function addEntity(e)
  loadFunc[e.index](e)
  table.insert(entities,e)
end

function loadEntities()

end

function updateEntities(dt)
  timer = timer + dt
  if nextEntity[1] < timer then
    addEntity(nextEntity[2])
    iterator = iterator + 1
    if iterator <= #ENTITYDATA then
      nextEntity = ENTITYDATA[iterator]
    else
      nextEntity = {100000,nil}
    end
    timer = 0
  end
  
  for i, v in ipairs(entities) do
    if updateFunc[v.index] ~= nil and 
      not updateFunc[v.index](v,dt) then
      table.remove(entities, i)
    end
  end
end

function drawEntities()
  for i, v in ipairs(entities) do
    love.graphics.draw(v.image,v.x,v.y,0,1.2,1.2)
  end
end