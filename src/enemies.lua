loadEnemyFunc = {}
updateEnemyFunc = {}

require("src.enemy.popcorn")
require("src.enemy.turret")

local ENEMYDATA = require("src.enemiesData")
local enemies = {}
local iterator = 1
local timer = 0
local nextEnemy = ENEMYDATA[iterator]

function addEnemy(e_index,e_x,e_y)
  local e = { index = e_index, x = e_x, y = e_y }
  loadEnemyFunc[e.index](e)
  table.insert(enemies,e)
end

function updateEnemies(dt)
  -- add any new enemy spawns
  timer = timer + dt
  if nextEnemy[1] < timer then
    addEnemy(nextEnemy[2],nextEnemy[3],nextEnemy[4])
    iterator = iterator + 1
    if iterator <= #ENEMYDATA then
      nextEnemy = ENEMYDATA[iterator]
    else
      nextEnemy = {100000,nil}
    end
    timer = 0
  end
  
  -- update all existing enemies
  for i, v in ipairs(enemies) do
    if updateEnemyFunc[v.index] ~= nil and 
      not updateEnemyFunc[v.index](v,dt) then
      table.remove(enemies, i)
    end
  end
end

function drawEnemies()
  for i, v in ipairs(enemies) do
    love.graphics.draw(v.image,v.x,v.y,0,1.2,1.2)
  end
end